package com.xworkz.dairy.restcontroller;


import com.xworkz.dairy.dto.AgentDTO;
import com.xworkz.dairy.entity.AgentEntity;
import com.xworkz.dairy.service.AgentService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/agent")
public class AgentRestController {

    @Autowired
    private AgentService agentService;

    // ✅ Check if email is already registered
    @GetMapping("/checkEmail")
    public boolean checkEmail(@RequestParam String email) {
        return !agentService.existsByEmail(email); // return false if already registered
    }

    // ✅ Check if phone number is already registered
    @GetMapping("/checkPhone")
    public boolean checkPhone(@RequestParam String phoneNumber) {
        return !agentService.existsByPhoneNumber(phoneNumber); // return false if already registered
    }

    // ✅ For login page: check if email exists
    @GetMapping("/login/check-email")
    public Map<String, Boolean> checkEmailForLogin(@RequestParam String email) {
        boolean exists = agentService.existsByEmail(email);
        Map<String, Boolean> response = new HashMap<>();
        response.put("exists", exists); // true if email exists
        return response;
    }

    // ✅ Login endpoint using just email (no OTP logic)
    @PostMapping("/login")
    public Map<String, Object> loginAgent(@RequestParam String email, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        AgentEntity entity = agentService.findByEmail(email);
        if (entity != null && entity.getActive()) {
            AgentDTO dto = new AgentDTO();
            BeanUtils.copyProperties(entity, dto);
            session.setAttribute("loggedInAgent", dto);
            log.info("Agent logged in: {}", dto.getEmail());
            response.put("login", true);
            response.put("agent", dto);
        } else {
            log.warn("Login failed for email: {}", email);
            response.put("login", false);
        }

        return response;
    }

    // ✅ Logout
    @PostMapping("/logout")
    public Map<String, Object> logoutAgent(HttpSession session) {
        session.invalidate();
        Map<String, Object> response = new HashMap<>();
        response.put("loggedOut", true);
        return response;
    }
}
