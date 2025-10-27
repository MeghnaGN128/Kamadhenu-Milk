package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.AgentEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.*;
import java.util.Collections;
import java.util.List;

@Repository
@Slf4j
public class AgentRepositoryImpl implements AgentRepository {

    @Autowired
    private EntityManagerFactory emf;

    @Override
    public List<AgentEntity> findAll() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createNamedQuery("findAllAgents", AgentEntity.class).getResultList();
        } catch (Exception e) {
            log.error("Error fetching all agents", e);
            return Collections.emptyList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public void save(AgentEntity agent) {
        EntityManager em = null;
        EntityTransaction tx = null;
        try {
            em = emf.createEntityManager();
            tx = em.getTransaction();
            tx.begin();
            em.persist(agent);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            log.error("Error saving agent: {}", agent, e);
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public AgentEntity findById(Integer id) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.find(AgentEntity.class, id);
        } catch (Exception e) {
            log.error("Error finding agent by ID: {}", id, e);
            return null;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public boolean update(AgentEntity agentEntity) {
        EntityManager em = null;
        EntityTransaction tx = null;
        try {
            em = emf.createEntityManager();
            tx = em.getTransaction();
            tx.begin();
            em.merge(agentEntity);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            log.error("Error updating agent: {}", agentEntity, e);
            return false;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public boolean delete(Integer id) {
        EntityManager em = null;
        EntityTransaction tx = null;
        try {
            em = emf.createEntityManager();
            tx = em.getTransaction();
            tx.begin();
            AgentEntity agent = em.find(AgentEntity.class, id);
            if (agent != null) {
                agent.setActive(false); // Soft delete
                em.merge(agent);
            }
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            log.error("Error deleting (soft) agent with ID: {}", id, e);
            return false;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public AgentEntity findByEmail(String email) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createNamedQuery("findByAgentEmail", AgentEntity.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            log.error("Error finding agent by email: {}", email, e);
            return null;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public AgentEntity findByPhoneNumber(String phoneNumber) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createNamedQuery("findByAgentPhoneNumber", AgentEntity.class)
                    .setParameter("phoneNumber", phoneNumber)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            log.error("Error finding agent by phone number: {}", phoneNumber, e);
            return null;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public long countAgents() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT COUNT(a) FROM AgentEntity a", Long.class).getSingleResult();
        } catch (Exception e) {
            log.error("Error counting agents", e);
            return 0;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<AgentEntity> searchAgents(String keyword) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            
            // Try to parse as integer for agent ID search
            try {
                Integer agentId = Integer.parseInt(keyword.trim());
                AgentEntity agent = em.find(AgentEntity.class, agentId);
                if (agent != null && agent.getActive()) {
                    return Collections.singletonList(agent);
                }
            } catch (NumberFormatException e) {
                // Not a number, continue with other search criteria
            }
            
            // Search by email (exact match, case-insensitive)
            try {
                String normalizedEmail = keyword.trim().toLowerCase();
                TypedQuery<AgentEntity> emailQuery = em.createQuery(
                    "SELECT a FROM AgentEntity a WHERE LOWER(a.email) = :email AND a.active = true", 
                    AgentEntity.class);
                emailQuery.setParameter("email", normalizedEmail);
                List<AgentEntity> emailResults = emailQuery.getResultList();
                if (!emailResults.isEmpty()) {
                    return emailResults;
                }
            } catch (Exception e) {
                log.warn("Error searching by email: {}", keyword, e);
            }
            
            // Search by phone number (exact match)
            try {
                String normalizedPhone = keyword.trim();
                TypedQuery<AgentEntity> phoneQuery = em.createQuery(
                    "SELECT a FROM AgentEntity a WHERE a.phoneNumber = :phone AND a.active = true", 
                    AgentEntity.class);
                phoneQuery.setParameter("phone", normalizedPhone);
                List<AgentEntity> phoneResults = phoneQuery.getResultList();
                if (!phoneResults.isEmpty()) {
                    return phoneResults;
                }
            } catch (Exception e) {
                log.warn("Error searching by phone: {}", keyword, e);
            }
            
            // If no exact matches found, fall back to partial search
            String searchPattern = "%" + keyword.toLowerCase() + "%";
            String q = "SELECT a FROM AgentEntity a WHERE " +
                     "(LOWER(a.firstName) LIKE :kw OR " +
                     "LOWER(a.lastName) LIKE :kw OR " +
                     "LOWER(a.email) LIKE :kw OR " +
                     "a.phoneNumber LIKE :kw) " +
                     "AND a.active = true";
            
            return em.createQuery(q, AgentEntity.class)
                    .setParameter("kw", searchPattern)
                    .getResultList();
                    
        } catch (Exception e) {
            log.error("Error searching agents by keyword: {}", keyword, e);
            return Collections.emptyList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<String> getAllMilkTypes() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT DISTINCT a.typesOfMilk FROM AgentEntity a WHERE a.typesOfMilk IS NOT NULL", String.class)
                    .getResultList();
        } catch (Exception e) {
            log.error("Error fetching milk types", e);
            return Collections.emptyList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public long countByStatus(boolean active) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT COUNT(a) FROM AgentEntity a WHERE a.active = :active", Long.class)
                    .setParameter("active", active)
                    .getSingleResult();
        } catch (Exception e) {
            log.error("Error counting agents by status", e);
            return 0;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public long countAgentsBySearch(String keyword) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            String q = "SELECT COUNT(a) FROM AgentEntity a WHERE " +
                    "(LOWER(a.firstName) LIKE :kw OR LOWER(a.lastName) LIKE :kw OR LOWER(a.email) LIKE :kw OR a.phoneNumber LIKE :kw) " +
                    "AND a.active = true";
            Long count = em.createQuery(q, Long.class)
                    .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                    .getSingleResult();
            return count != null ? count : 0;
        } catch (Exception e) {
            log.error("Error counting agents by search keyword: {}", keyword, e);
            return 0;
        } finally {
            if (em != null) em.close();
        }
    }
}
