package com.xworkz.dairy.service;

import com.xworkz.dairy.dto.AgentDTO;
import com.xworkz.dairy.entity.AgentEntity;

import java.util.List;

public interface AgentService {

    List<AgentDTO> getAllAgents();

    void registerAgent(AgentDTO agentDTO, String adminName);

    AgentDTO findById(Integer id);

    boolean updateAgent(AgentDTO agentDTO, String adminName);

    boolean deleteAgent(Integer id);

    boolean existsByEmail(String email);

    boolean existsByPhoneNumber(String phoneNumber);

    long getAgentCount();

    List<AgentDTO> searchAgents(String keyword);

    long getAgentSearchCount(String keyword);

    List<String> getAllMilkTypes();

    AgentDTO getAgentByPhoneNumber(String phoneNumber);

    AgentEntity findByEmail(String email);

    AgentEntity findByEmailEntity(String email);
}
