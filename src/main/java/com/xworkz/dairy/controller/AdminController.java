package com.xworkz.dairy.controller;

import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.entity.AdminEntity;
import com.xworkz.dairy.repository.AdminRepository;
import com.xworkz.dairy.service.AdminService;
import com.xworkz.dairy.service.AgentService;
import com.xworkz.dairy.service.AuditService;
import com.xworkz.dairy.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Slf4j
@Controller
@RequestMapping({"/"})
public class AdminController {

    @Autowired
    private AuditService auditService;

    @Autowired
    private AdminRepository adminRepo;

    @Autowired
    private AdminService adminService;

    @Autowired
    private AgentService agentService;

    @Autowired
    private ProductService productService;

    @GetMapping({"adminLogin", "login"})
    public String adminLogin() {
        log.info("Admin login page loaded");
        return "adminLoginForm";
    }

    @PostMapping("adminLoginSuccess")
    public String adminLogin(@RequestParam String adminName,
                             @RequestParam String password,
                             Model model,
                             HttpSession session) {

        boolean isLocked = adminService.isAccountLocked(adminName);
        if (isLocked) {
            model.addAttribute("lockMessage", "Your account is locked due to too many failed attempts. Please reset your password.");
            model.addAttribute("email", adminName);
            return "adminaccountlocked";
        }

        AdminDTO adminDTO = adminService.adminlogin(adminName, password);
        if (adminDTO != null) {
            log.info("Admin login successful");
            AdminEntity adminEntity = adminRepo.findByEmail(adminDTO.getEmail());
            auditService.logAdminLogin(adminEntity);
            session.setAttribute("adminDTO", adminDTO);
            model.addAttribute("adminDTO", adminDTO);
            long agentCount = agentService.getAgentCount();
            model.addAttribute("agentCount", agentCount);

            long countProducts = productService.countProducts();
            model.addAttribute("productCount", countProducts);
            return "adminloginsuccessfully";
        } else {
            log.info("Admin login failed");
            if (adminService.isAccountLocked(adminName)) {
                model.addAttribute("lockMessage", "Your account is now locked due to too many failed attempts. Please reset your password.");
                model.addAttribute("email", adminName);
                return "adminaccountlocked";
            }
            model.addAttribute("message", "Invalid admin name or password");
            return "adminLoginForm";
        }
    }

    @GetMapping("adminprofile")
    public String adminProfile(HttpSession session, Model model) {
        AdminDTO adminDTO = (AdminDTO) session.getAttribute("adminDTO");
        if (adminDTO == null) {
            return "redirect:/adminLogin";
        }
        model.addAttribute("adminDTO", adminDTO);
        return "adminprofile";
    }

    @PostMapping("updateAdminProfile")
    public String updateAdminProfile(@Valid @ModelAttribute AdminDTO adminDTO,
                                     BindingResult result,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {

        log.info("Updating admin profile: {}", adminDTO);

        AdminDTO sessionAdmin = (AdminDTO) session.getAttribute("adminDTO");
        if (sessionAdmin == null) {
            return "redirect:/adminLogin";
        }

      /*  // Validate mobile number format
        if (adminDTO.getMobileNumber() != null && !adminDTO.getMobileNumber().matches("^[6-9]\\d{9}$")) {
            log.error("Invalid mobile number format: {}", adminDTO.getMobileNumber());
            result.rejectValue("mobileNumber", "error.adminDTO", "Please enter a valid 10-digit Indian mobile number starting with 6-9");
        }
*/
        // Check mobile uniqueness
        if (adminService.mobileNumberExists(adminDTO.getMobileNumber())) {
            AdminEntity existingAdmin = adminService.findByEmailEntity(sessionAdmin.getEmail());
            if (existingAdmin == null || !adminDTO.getMobileNumber().equals(existingAdmin.getMobileNumber())) {
                log.error("Mobile number already exists: {}", adminDTO.getMobileNumber());
                result.rejectValue("mobileNumber", "error.adminDTO", "This mobile number is already registered");
            }
        }

        // Return to form if validation errors
        if (result.hasErrors()) {
            log.error("Validation errors: {}", result.getAllErrors());
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.adminDTO", result);
            redirectAttributes.addFlashAttribute("adminDTO", adminDTO);
            return "redirect:/adminprofile";
        }

        try {
            try {
                // Keep old password if blank
                if (adminDTO.getPassword() == null || adminDTO.getPassword().isEmpty()) {
                    adminDTO.setPassword(sessionAdmin.getPassword());
                }

                // Update the profile
                adminService.update(adminDTO);

                // Fetch latest values from DB to reflect immediately
                AdminDTO updatedAdmin = adminService.findByEmail(adminDTO.getEmail());
                session.setAttribute("adminDTO", updatedAdmin);
                redirectAttributes.addFlashAttribute("message", "Profile updated successfully!");
                auditService.logAdminAuditSave(updatedAdmin);
            } catch (Exception e) {
                log.error("Error updating admin profile: {}", e.getMessage(), e);
                redirectAttributes.addFlashAttribute("error", "Failed to update profile: " + e.getMessage());
            }
        } catch (Exception e) {
            log.error("Error updating admin profile", e);
            redirectAttributes.addFlashAttribute("error", "An error occurred while updating your profile. Please try again.");
        }

        return "redirect:/adminprofile";
    }

    @GetMapping("adminaccountlocked")
    public String adminAccountLocked(@RequestParam(required = false) String email, Model model) {
        model.addAttribute("email", email);
        return "adminaccountlocked";
    }

    @GetMapping("adminForgotPassword")
    public String adminForgotPassword(@RequestParam(required = false) String email, Model model) {
        model.addAttribute("email", email);
        model.addAttribute("info", "Enter your email to receive a reset link.");
        return "adminforgotpassword";
    }

    @PostMapping("sendResetLink")
    public String sendResetLink(@RequestParam String email,
                                @RequestParam(required = false) String source,
                                HttpServletRequest request,
                                Model model) {
        String baseUrl = request.getScheme() + "://" + request.getServerName()
                + ((request.getServerPort() == 80 || request.getServerPort() == 443) ? "" : (":" + request.getServerPort()))
                + request.getContextPath();

        adminService.initiatePasswordReset(email, baseUrl);
        model.addAttribute("email", email);
        model.addAttribute("info", "If an account exists for this email, a reset link has been sent.");
        return "locked".equalsIgnoreCase(source) ? "adminaccountlocked" : "adminforgotpassword";
    }

    @GetMapping("adminSetPassword")
    public String showSetPassword(@RequestParam String token, Model model) {
        model.addAttribute("token", token);
        return "adminsetpassword";
    }

    @PostMapping("adminSetPassword")
    public String handleSetPassword(@RequestParam String token,
                                    @RequestParam String password,
                                    @RequestParam String confirmPassword,
                                    Model model,
                                    RedirectAttributes redirectAttributes) {
        if (!password.equals(confirmPassword)) {
            model.addAttribute("token", token);
            model.addAttribute("error", "Passwords do not match");
            return "adminsetpassword";
        }

        boolean ok = adminService.resetPassword(token, password);
        if (ok) {
            redirectAttributes.addFlashAttribute("message", "Password has been reset. You can now log in.");
            return "redirect:/adminLogin";
        } else {
            model.addAttribute("error", "Invalid or expired link. Please request a new reset link.");
            return "adminaccountlocked";
        }
    }

    @GetMapping("logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        AdminDTO adminDTO = (AdminDTO) session.getAttribute("adminDTO");
        if (adminDTO != null) {
            AdminEntity adminEntity = adminRepo.findByEmail(adminDTO.getEmail());
            auditService.logAdminLogout(adminEntity);
        }
        session.invalidate();
        redirectAttributes.addFlashAttribute("message", "You have been logged out successfully.");
        log.info("Logout successful");
        return "redirect:/adminLogin";
    }

    @GetMapping("dashboard")
    public String dashboard(HttpSession session, Model model) {
        AdminDTO adminDTO = (AdminDTO) session.getAttribute("adminDTO");
        if (adminDTO == null) {
            return "redirect:/adminLogin";
        }
        model.addAttribute("adminDTO", adminDTO);
        return "adminloginsuccessfully";
    }

    @GetMapping("adminloginsuccessfully")
    public String adminDashboard(HttpSession session, Model model) {
        AdminDTO adminDTO = (AdminDTO) session.getAttribute("adminDTO");
        if (adminDTO == null) {
            return "redirect:/adminLogin";
        }
        model.addAttribute("adminDTO", adminDTO);
        return "adminloginsuccessfully";
    }

    @PostMapping("admindetails")
    @ResponseBody
    public ResponseEntity<String> saveAdminDetails(
            @Valid @RequestBody AdminDTO adminDTO,
            BindingResult bindingResult) {

        log.info("Received admin details: {}", adminDTO);

        if (bindingResult.hasErrors()) {
            String errorMessage = bindingResult.getAllErrors().get(0).getDefaultMessage();
            return ResponseEntity.badRequest().body(errorMessage);
        }

        boolean saved = adminService.save(adminDTO);
        if (saved) {
            return ResponseEntity.ok("Admin details saved successfully!");
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Failed to save admin details.");
        }
    }
}
