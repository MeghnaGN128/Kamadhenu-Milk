package com.xworkz.dairy.service;

import com.xworkz.dairy.entity.AgentAuditEntity;
import com.xworkz.dairy.entity.AgentEntity;
import com.xworkz.dairy.repository.AgentAuditRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AgentAuditServiceImpl implements AgentAuditService {

    @Autowired
    private AgentAuditRepo agentAuditRepo;

    @Override
    @Transactional
    public void logAgentAction(AgentEntity agent, String action, String performedBy) {
        try {
            if (agent == null) {
                throw new IllegalArgumentException("Agent cannot be null");
            }
            
            AgentAuditEntity audit = new AgentAuditEntity();
            audit.setAgent(agent);
            audit.setAgentName(agent.getFirstName() + " " + agent.getLastName());
            audit.setAction(action);
            audit.setCreatedBy(performedBy);
            audit.setUpdatedBy(performedBy);
            
            agentAuditRepo.save(audit);
        } catch (Exception e) {
            throw new RuntimeException("Failed to log agent action: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public AgentAuditEntity getLastAgentAudit(AgentEntity agent) {
        try {
            if (agent == null) {
                throw new IllegalArgumentException("Agent cannot be null");
            }
            return agentAuditRepo.findTopByAgentOrderByCreatedOnDesc(agent);
        } catch (Exception e) {
            throw new RuntimeException("Failed to get last agent audit: " + e.getMessage(), e);
        }
    }
}
