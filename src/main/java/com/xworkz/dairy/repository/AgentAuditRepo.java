package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.AgentAuditEntity;
import com.xworkz.dairy.entity.AgentEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AgentAuditRepo extends JpaRepository<AgentAuditEntity, Long> {

    AgentAuditEntity findTopByAgentOrderByCreatedOnDesc(AgentEntity agent);

    boolean existsByAgent(AgentEntity agent);

    AgentAuditEntity findByAgent(AgentEntity agent);

    void update(AgentAuditEntity audit);
}