package com.xworkz.dairy.service;

import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.entity.AdminEntity;
import com.xworkz.dairy.repository.AdminRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.UUID;

@Service
@Slf4j
public class AdminServiceImpl implements AdminService {
    @Autowired
    AdminRepository adminRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired(required = false)
    JavaMailSender mailSender;
    
    @PersistenceContext
    private EntityManager entityManager;

    private static final int MAX_FAILED_ATTEMPTS = 3;
    private static final int TOKEN_EXPIRY_MINUTES = 30;
    @Override
    public boolean save(AdminDTO adminDTO) {

        AdminEntity adminEntity = new AdminEntity();
        BeanUtils.copyProperties(adminDTO, adminEntity);
        String encodedPassword = passwordEncoder.encode(adminDTO.getPassword());
        adminEntity.setPassword(encodedPassword);

        Boolean save = adminRepository.save(adminEntity);
        if(save){
            log.info("Admin saved successfully");
            return true;

        }else {
            log.info("Admin not saved");
            return false;
        }
    }


    @Override
    public AdminDTO adminlogin(String email, String password) {
        if(email ==null || password ==null){
            return null;
        }
        AdminEntity adminEntity = adminRepository.findByEmail(email);

        if(adminEntity ==null){
            return null;
        }

        // If account is locked, do not proceed
        if (Boolean.TRUE.equals(adminEntity.getAccountLocked())) {
            log.info("Account is locked for email: {}", email);
            return null;
        }

        if(!passwordEncoder.matches(password, adminEntity.getPassword())){
            // increment failed attempts
            int attempts = adminEntity.getFailedAttempts() == null ? 0 : adminEntity.getFailedAttempts();
            attempts++;
            adminEntity.setFailedAttempts(attempts);
            if (attempts >= MAX_FAILED_ATTEMPTS) {
                adminEntity.setAccountLocked(true);
                log.info("Account locked due to too many failed attempts for email: {}", email);
            }
            adminRepository.update(adminEntity);
            return null;
        }

        // successful login: reset attempts
        adminEntity.setFailedAttempts(0);
        adminRepository.update(adminEntity);
        AdminDTO adminDTO = new AdminDTO();
        BeanUtils.copyProperties(adminEntity, adminDTO);
        return adminDTO;
    }

    @Override
    @Transactional
    public boolean update(AdminDTO adminDTO1) {
        try {
            AdminEntity adminEntity = adminRepository.findByEmail(adminDTO1.getEmail());
            if (adminEntity == null) {
                log.error("No admin found with email: {}", adminDTO1.getEmail());
                return false;
            }

            log.info("Updating admin profile for: {}", adminDTO1.getEmail());
            log.info("New mobile number: {}", adminDTO1.getMobileNumber());
            
            // Update the fields that can be modified
            adminEntity.setAdminName(adminDTO1.getAdminName());
            adminEntity.setMobileNumber(adminDTO1.getMobileNumber());
            
            // Only update password if a new one was provided
            if (adminDTO1.getPassword() != null && !adminDTO1.getPassword().isEmpty()) {
                String encodedPassword = passwordEncoder.encode(adminDTO1.getPassword());
                adminEntity.setPassword(encodedPassword);
            }
            
            // Save the updated entity
            adminRepository.update(adminEntity);
            log.info("Successfully updated admin profile for: {}", adminDTO1.getEmail());
            return true;
        } catch (Exception e) {
            log.error("Error updating admin profile: {}", e.getMessage(), e);
            return false;
        }
    }

    @Override
    public boolean isAccountLocked(String email) {
        AdminEntity adminEntity = adminRepository.findByEmail(email);
        return adminEntity != null && Boolean.TRUE.equals(adminEntity.getAccountLocked());
    }

    @Override
    public String initiatePasswordReset(String email, String appBaseUrl) {
        AdminEntity adminEntity = adminRepository.findByEmail(email);
        if (adminEntity == null) {
            log.info("No admin found for email: {}", email);
            return null;
        }
        String token = UUID.randomUUID().toString();
        adminEntity.setResetToken(token);
        adminEntity.setResetTokenExpiry(LocalDateTime.now().plusMinutes(TOKEN_EXPIRY_MINUTES));
        adminRepository.update(adminEntity);

        String resetUrl = appBaseUrl + "/adminSetPassword?token=" + token;
        if (mailSender == null) {
            log.warn("JavaMailSender bean not configured. Skipping email send. Reset URL: {}", resetUrl);
        } else {
            try {
                String html = "<p>Dear Admin,</p>" +
                        "<p>We received a request to reset the password for your admin account.</p>" +
                        "<p>To set a new password, please click the link below (valid for " + TOKEN_EXPIRY_MINUTES + " minutes):</p>" +
                        "<p><a href='" + resetUrl + "' target='_blank'>Set your admin password</a></p>" +
                        "<p>If you did not request this, please disregard this email.</p>" +
                        "<p>Regards,<br/>DataBloom Support Team</p>";

                log.info("Sending password reset email to {} with URL: {}", email, resetUrl);

                MimeMessage mimeMessage = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
                helper.setFrom("ninganurmeghna@gmail.com");
                helper.setTo(email);
                helper.setSubject("Admin Account Password Reset");
                helper.setText(html, true);
                mailSender.send(mimeMessage);
                log.info("Password reset email sent to {}", email);
            } catch (Exception ex) {
                log.error("Failed to send password reset email to {}", email, ex);
            }
        }

        return token;
    }

    @Override
    public boolean resetPassword(String token, String newPassword) {
        AdminEntity adminEntity = adminRepository.findByResetToken(token);
        if (adminEntity == null) return false;
        if (adminEntity.getResetTokenExpiry() == null || LocalDateTime.now().isAfter(adminEntity.getResetTokenExpiry())) {
            log.info("Reset token expired for admin: {}", adminEntity.getEmail());
            return false;
        }
        String encodedPassword = passwordEncoder.encode(newPassword);
        adminEntity.setPassword(encodedPassword);
        adminEntity.setResetToken(null);
        adminEntity.setResetTokenExpiry(null);
        adminEntity.setFailedAttempts(0);
        adminEntity.setAccountLocked(false);
        adminRepository.update(adminEntity);
        return true;
    }

    @Override
    public AdminEntity findByEmailEntity(String email) {
        return adminRepository.findByEmail(email);
    }

    @Override
    public boolean mobileNumberExists(String mobileNumber) {
        if (mobileNumber == null) {
            return false;
        }
        try {
            log.info("Checking if mobile number exists: {}", mobileNumber);
            TypedQuery<AdminEntity> query = entityManager.createQuery(
                "SELECT a FROM AdminEntity a WHERE a.mobileNumber = :mobileNumber", 
                AdminEntity.class
            );
            query.setParameter("mobileNumber", mobileNumber);
            return !query.getResultList().isEmpty();
        } catch (Exception e) {
            log.error("Error checking if mobile number exists: {}", e.getMessage(), e);
            return false;
        }
    }

    @Override
    public AdminDTO findByEmail(String email) {
        AdminEntity adminEntity = adminRepository.findByEmail(email);
        if (adminEntity != null) {
            AdminDTO dto = new AdminDTO();
            dto.setAdminId(adminEntity.getAdminId());
            dto.setAdminName(adminEntity.getAdminName());
            dto.setEmail(adminEntity.getEmail());
            dto.setMobileNumber(adminEntity.getMobileNumber());
            dto.setPassword(adminEntity.getPassword());
            return dto;
        }
        return null;
    }

}