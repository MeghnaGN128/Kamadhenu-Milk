package com.xworkz.dairy.service;

import com.xworkz.dairy.entity.AgentAuditEntity;
import com.xworkz.dairy.entity.AgentEntity;

public interface AgentAuditService {
    void logAgentAction(AgentEntity agent, String action, String performedBy);
    AgentAuditEntity getLastAgentAudit(AgentEntity agent);
}


