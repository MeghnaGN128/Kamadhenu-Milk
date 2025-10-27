
package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.AdminEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.*;

@Repository
@Slf4j
public class AdminRepositoryImpl implements AdminRepository {
    @Autowired
    EntityManagerFactory emf;

    @Override
    public Boolean save(AdminEntity adminEntity) {
        EntityManager em=null;
        EntityTransaction et=null;
        try{
            em=emf.createEntityManager();
            et=em.getTransaction();
            et.begin();
            em.persist(adminEntity);
            et.commit();
            return true;
        } catch (PersistenceException e) {
            et.rollback();
            return false;
        }finally {
            em.close();
        }

    }

    @Override
    public AdminEntity findByEmail(String email) {
        EntityManager em=null;
        try {
            em=emf.createEntityManager();
            log.info("findByEmail method");
            AdminEntity adminEntity = em.createNamedQuery("findByEmail",AdminEntity.class).setParameter("email",email).getSingleResult();
            log.info("AdminEntity found");
            return adminEntity;

        }catch (PersistenceException e){
            log.info("AdminEntity not found");
            return null;
        }finally {
            em.close();
        }
    }

    @Override
    public void update(AdminEntity adminEntity) {
        EntityManager em=null;
        EntityTransaction et=null;
        try{
            em=emf.createEntityManager();
            et=em.getTransaction();
            et.begin();

            AdminEntity adminEntity1 = em.find(AdminEntity.class, adminEntity.getAdminId());

            log.info("AdminEntity found{"+adminEntity1+"}");
            adminEntity1.setAdminName(adminEntity.getAdminName());
            adminEntity1.setEmail(adminEntity.getEmail());
            adminEntity1.setPassword(adminEntity.getPassword());
            adminEntity1.setMobileNumber(adminEntity.getMobileNumber());
            // Persist lockout-related fields as well
            adminEntity1.setFailedAttempts(adminEntity.getFailedAttempts());
            adminEntity1.setAccountLocked(adminEntity.getAccountLocked());
            // Persist reset token fields
            adminEntity1.setResetToken(adminEntity.getResetToken());
            adminEntity1.setResetTokenExpiry(adminEntity.getResetTokenExpiry());

            em.merge(adminEntity1);





            //  em.merge(adminEntity);
            et.commit();

            log.info("AdminEntity updated{"+adminEntity1+"}");

        }catch (PersistenceException e){
            et.rollback();
            log.info("AdminEntity not updated");
        }finally {
            em.close();
        }
    }

    @Override
    public AdminEntity findByResetToken(String token) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            TypedQuery<AdminEntity> q = em.createQuery("SELECT a FROM AdminEntity a WHERE a.resetToken = :token", AdminEntity.class);
            q.setParameter("token", token);
            return q.getSingleResult();
        } catch (PersistenceException e) {
            log.info("AdminEntity not found by reset token");
            return null;
        } finally {
            if (em != null) em.close();
        }

    }
}