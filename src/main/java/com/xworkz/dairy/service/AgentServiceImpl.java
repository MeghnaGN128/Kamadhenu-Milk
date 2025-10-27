package com.xworkz.dairy.service;

import com.xworkz.dairy.dto.AgentDTO;
import com.xworkz.dairy.entity.AgentEntity;
import com.xworkz.dairy.repository.AgentRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@Slf4j
public class AgentServiceImpl implements AgentService {

    @Autowired
    private AgentRepository agentRepo;
    
    @Autowired
    private AgentAuditService agentAuditService;

    @Override
    public List<AgentDTO> getAllAgents() {
        List<AgentEntity> entities = agentRepo.findAll();
        if (entities == null || entities.isEmpty()) {
            return Collections.emptyList();
        }

        List<AgentDTO> dtos = new ArrayList<>();
        for (AgentEntity e : entities) {
            AgentDTO dto = new AgentDTO();
            BeanUtils.copyProperties(e, dto);
            dtos.add(dto);
        }
        return dtos;
    }

    @Override
    public void registerAgent(AgentDTO dto, String adminName) {
        AgentEntity entity = new AgentEntity();
        BeanUtils.copyProperties(dto, entity);

        entity.setActive(true);
        entity.setCreatedBy(adminName);
        entity.setCreatedDate(LocalDateTime.now());

        agentRepo.save(entity);
        
        // Log the agent creation in audit
        try {
            agentAuditService.logAgentAction(entity, "AGENT_CREATED", adminName);
        } catch (Exception e) {
            log.error("Failed to log agent creation audit: {}", e.getMessage(), e);
        }

        log.info("Registered agent: {}", entity.getEmail());
    }

    @Override
    public AgentDTO findById(Integer id) {
        AgentEntity entity = agentRepo.findById(id);
        if (entity == null) return null;

        AgentDTO dto = new AgentDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

    @Override
    public boolean updateAgent(AgentDTO dto, String adminName) {
        AgentEntity entity = agentRepo.findById(dto.getAgentId());
        if (entity == null) return false;

        // Get the original values before update for audit
        String originalValues = String.format("Name: %s %s, Email: %s, Phone: %s, Status: %s",
                entity.getFirstName(), entity.getLastName(),
                entity.getEmail(), entity.getPhoneNumber(),
                entity.getActive() ? "Active" : "Inactive");

        // Update the entity
        BeanUtils.copyProperties(dto, entity, "agentId", "createdBy", "createdDate");
        entity.setUpdatedBy(adminName);
        entity.setUpdatedDate(LocalDateTime.now());

        boolean updated = agentRepo.update(entity);
        
        if (updated) {
            // Log the agent update in audit
            try {
                String action = String.format("AGENT_UPDATED - Previous values: %s", originalValues);
                agentAuditService.logAgentAction(entity, action, adminName);
            } catch (Exception e) {
                log.error("Failed to log agent update audit: {}", e.getMessage(), e);
            }
        }

        return updated;
    }

    @Override
    public boolean deleteAgent(Integer id) {
        AgentEntity entity = agentRepo.findById(id);
        if (entity == null) return false;

        // Log the agent deletion in audit before actually deleting
        try {
            agentAuditService.logAgentAction(entity, "AGENT_DELETED", "system");
        } catch (Exception e) {
            log.error("Failed to log agent deletion audit: {}", e.getMessage(), e);
        }

        return agentRepo.delete(id);
    }

    @Override
    public boolean existsByEmail(String email) {
        return agentRepo.findByEmail(email) != null;
    }

    @Override
    public boolean existsByPhoneNumber(String phoneNumber) {
        return agentRepo.findByPhoneNumber(phoneNumber) != null;
    }

    @Override
    public long getAgentCount() {
        return agentRepo.countAgents();
    }

    @Override
    public List<AgentDTO> searchAgents(String keyword) {
        List<AgentEntity> entities = agentRepo.searchAgents(keyword);
        if (entities == null || entities.isEmpty()) {
            return Collections.emptyList();
        }

        List<AgentDTO> dtos = new ArrayList<>();
        for (AgentEntity e : entities) {
            AgentDTO dto = new AgentDTO();
            BeanUtils.copyProperties(e, dto);
            dtos.add(dto);
        }
        return dtos;
    }

    @Override
    public long getAgentSearchCount(String keyword) {
        return agentRepo.countAgentsBySearch(keyword);
    }

    @Override
    public List<String> getAllMilkTypes() {
        return agentRepo.getAllMilkTypes();
    }

    @Override
    public AgentDTO getAgentByPhoneNumber(String phoneNumber) {
        AgentEntity entity = agentRepo.findByPhoneNumber(phoneNumber);
        if (entity == null) return null;

        AgentDTO dto = new AgentDTO();
        BeanUtils.copyProperties(entity, dto);
        return dto;
    }

    @Override
    public AgentEntity findByEmail(String email) {
        return agentRepo.findByEmail(email);
    }

    @Override
    public AgentEntity findByEmailEntity(String email) {
        AgentEntity entity = agentRepo.findByEmail(email);
        if (entity == null) throw new IllegalArgumentException("Agent not found");
        return entity;
    }
}
