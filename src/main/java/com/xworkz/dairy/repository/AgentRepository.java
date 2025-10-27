package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.AgentEntity;

import java.util.List;

public interface AgentRepository {

    List<AgentEntity> findAll();

    void save(AgentEntity agent);

    AgentEntity findById(Integer id);

    boolean update(AgentEntity agentEntity);

    boolean delete(Integer id);

    AgentEntity findByEmail(String email);

    AgentEntity findByPhoneNumber(String phoneNumber);

    long countAgents();

    List<AgentEntity> searchAgents(String keyword);

    List<String> getAllMilkTypes();

    long countByStatus(boolean active);

    long countAgentsBySearch(String keyword);
}
