package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.AgentAuditEntity;
import com.xworkz.dairy.entity.AgentEntity;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.query.FluentQuery;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;

@Repository
public class AgentAuditRepoImpl implements AgentAuditRepo {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public AgentAuditEntity findTopByAgentOrderByCreatedOnDesc(AgentEntity agent) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM AgentAuditEntity a WHERE a.agent = :agent ORDER BY a.createdOn DESC";
            Query<AgentAuditEntity> query = session.createQuery(hql, AgentAuditEntity.class);
            query.setParameter("agent", agent);
            query.setMaxResults(1);
            return query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean existsByAgent(AgentEntity agent) {
        return false;
    }

    @Override
    public AgentAuditEntity save(AgentAuditEntity audit) {
        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            try {
                session.save(audit);
                transaction.commit();
                return audit;
            } catch (Exception e) {
                transaction.rollback();
                throw new RuntimeException("Failed to save agent audit", e);
            }
        }
    }

    @Override
    public AgentAuditEntity findByAgent(AgentEntity agent) {
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM AgentAuditEntity a WHERE a.agent = :agent ORDER BY a.auditId DESC";
            Query<AgentAuditEntity> query = session.createQuery(hql, AgentAuditEntity.class);
            query.setParameter("agent", agent);
            query.setMaxResults(1);
            return query.uniqueResult();
        } catch (Exception e) {
            throw new RuntimeException("Failed to find agent audit by agent", e);
        }
    }

    @Override
    public void update(AgentAuditEntity audit) {
        try (Session session = sessionFactory.openSession()) {
            Transaction transaction = session.beginTransaction();
            try {
                session.update(audit);
                transaction.commit();
            } catch (Exception e) {
                transaction.rollback();
                throw new RuntimeException("Failed to update agent audit", e);
            }
        }
    }

    @Override
    public List<AgentAuditEntity> findAll() {
        return Collections.emptyList();
    }

    @Override
    public List<AgentAuditEntity> findAll(Sort sort) {
        return Collections.emptyList();
    }

    @Override
    public Page<AgentAuditEntity> findAll(Pageable pageable) {
        return null;
    }

    @Override
    public List<AgentAuditEntity> findAllById(Iterable<Long> longs) {
        return Collections.emptyList();
    }

    @Override
    public long count() {
        return 0;
    }

    @Override
    public void deleteById(Long aLong) {

    }

    @Override
    public void delete(AgentAuditEntity entity) {

    }

    @Override
    public void deleteAllById(Iterable<? extends Long> longs) {

    }

    @Override
    public void deleteAll(Iterable<? extends AgentAuditEntity> entities) {

    }

    @Override
    public void deleteAll() {

    }

    @Override
    public <S extends AgentAuditEntity> List<S> saveAll(Iterable<S> entities) {
        return Collections.emptyList();
    }

    @Override
    public Optional<AgentAuditEntity> findById(Long aLong) {
        return Optional.empty();
    }

    @Override
    public boolean existsById(Long aLong) {
        return false;
    }

    @Override
    public void flush() {

    }

    @Override
    public <S extends AgentAuditEntity> S saveAndFlush(S entity) {
        return null;
    }

    @Override
    public <S extends AgentAuditEntity> List<S> saveAllAndFlush(Iterable<S> entities) {
        return Collections.emptyList();
    }

    @Override
    public void deleteAllInBatch(Iterable<AgentAuditEntity> entities) {

    }

    @Override
    public void deleteAllByIdInBatch(Iterable<Long> longs) {

    }

    @Override
    public void deleteAllInBatch() {

    }

    @Override
    public AgentAuditEntity getOne(Long aLong) {
        return null;
    }

    @Override
    public AgentAuditEntity getById(Long aLong) {
        return null;
    }

    @Override
    public AgentAuditEntity getReferenceById(Long aLong) {
        return null;
    }

    @Override
    public <S extends AgentAuditEntity> Optional<S> findOne(Example<S> example) {
        return Optional.empty();
    }

    @Override
    public <S extends AgentAuditEntity> List<S> findAll(Example<S> example) {
        return Collections.emptyList();
    }

    @Override
    public <S extends AgentAuditEntity> List<S> findAll(Example<S> example, Sort sort) {
        return Collections.emptyList();
    }

    @Override
    public <S extends AgentAuditEntity> Page<S> findAll(Example<S> example, Pageable pageable) {
        return null;
    }

    @Override
    public <S extends AgentAuditEntity> long count(Example<S> example) {
        return 0;
    }

    @Override
    public <S extends AgentAuditEntity> boolean exists(Example<S> example) {
        return false;
    }

    @Override
    public <S extends AgentAuditEntity, R> R findBy(Example<S> example, Function<FluentQuery.FetchableFluentQuery<S>, R> queryFunction) {
        return null;

    }
}
