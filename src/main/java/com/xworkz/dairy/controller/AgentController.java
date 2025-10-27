package com.xworkz.dairy.controller;

import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.dto.AgentDTO;
import com.xworkz.dairy.service.AgentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/")
public class AgentController {

    @Autowired
    private AgentService agentService;

    @GetMapping("agentdashboard")
    public String adminDashboard(HttpSession session, Model model,
                                @RequestParam(required = false) String search) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminDTO");
        if (admin == null) {
            return "redirect:/adminLogin";
        }

        List<AgentDTO> agentsList;
        long agentsCount;

        if (search != null && !search.trim().isEmpty()) {
            agentsList = agentService.searchAgents(search.trim());
            agentsCount = agentsList.size();
            model.addAttribute("search", search);
        } else {
            agentsList = agentService.getAllAgents();
            agentsCount = agentService.getAgentCount();
        }

        model.addAttribute("agentsList", agentsList);
//        model.addAttribute("agentsCount", agentsCount);
        model.addAttribute("agentsCount", agentService.getAgentCount());
        // Add other counts if needed
        // model.addAttribute("productsCount", productService.getProductCount());
        // model.addAttribute("ordersCount", orderService.getOrderCount());
        // model.addAttribute("customersCount", customerService.getCustomerCount());

        return "agentdashboard";
    }

    @PostMapping("addAgent")
    public String saveAgent(@ModelAttribute AgentDTO agentDTO, HttpSession session, RedirectAttributes redirectAttributes) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminDTO");
        if (admin == null) {
            return "redirect:/adminLogin";
        }

        log.info("Registering new Agent: {}", agentDTO);

        try {
            agentService.registerAgent(agentDTO, admin.getAdminName());
            redirectAttributes.addAttribute("addSuccess", true);
        } catch (Exception e) {
            log.error("Error adding agent: {}", e.getMessage());
            redirectAttributes.addAttribute("error", "Failed to add agent: " + e.getMessage());
        }
        
        return "redirect:/agentdashboard";
    }

    @GetMapping("showEditAgent")
    public String editAgent(@RequestParam("id") Integer id, Model model) {
        AgentDTO agent = agentService.findById(id);
        if (agent == null) {
            return "redirect:/adminDashboard"; // fallback
        }

        List<String> milkTypes = agentService.getAllMilkTypes();
        model.addAttribute("milkTypes", milkTypes);

        model.addAttribute("agent", agent);
        return "editAgent";
    }

    @PostMapping("updateAgent")
    public String updateAgent(@ModelAttribute AgentDTO agentDTO, RedirectAttributes redirectAttributes, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("adminDTO");
        if (admin == null) {
            return "redirect:/adminLogin";
        }

        try {
            boolean updated = agentService.updateAgent(agentDTO, admin.getAdminName());
            if (updated) {
                redirectAttributes.addAttribute("updateSuccess", true);
            } else {
                redirectAttributes.addAttribute("error", "Failed to update agent. Please try again.");
            }
        } catch (Exception e) {
            log.error("Error updating agent: {}", e.getMessage());
            redirectAttributes.addAttribute("error", "Error updating agent: " + e.getMessage());
        }

        return "redirect:/agentdashboard";
    }

    @GetMapping("deleteAgent")
    public String deleteAgent(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {

        log.info("Deleting agent with ID: {}", id);

        boolean deleted = agentService.deleteAgent(id);

        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Agent deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to delete agent!");
        }

        return "redirect:/agentdashboard";
    }

    @GetMapping("registerAgent")
    public String showRegisterAgentPage(Model model) {
        List<String> milkTypes = agentService.getAllMilkTypes();
        model.addAttribute("milkTypes", milkTypes);
        return "registerAgent";  // JSP page name
    }

    @GetMapping("agentLogin")
    public String showAgentLoginPage() {
        return "agentLoginForm";  // JSP page name
    }

    @GetMapping("agentLoginSuccess")
    public String agentLoginSuccess(HttpSession session, Model model) {
        AgentDTO loggedInAgent = (AgentDTO) session.getAttribute("adminDTO");
        if (loggedInAgent == null) {
            return "redirect:/agentLogin";
        }

        log.info("Agent logged in successfully: {}", loggedInAgent);

        model.addAttribute("agent", loggedInAgent);

        return "agentLoginSuccess";  // JSP page name
    }

    @GetMapping("agentLogout")
    public String agentLogout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("successMessage", "You have been logged out successfully.");
        return "redirect:/agentLogin";
    }
}
