package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.AdminAuditEntity;

import java.util.Optional;

public interface AdminAuditRepository {
    void save(AdminAuditEntity audit);

    void updateAdminAudit(AdminAuditEntity audit);

    Optional<AdminAuditEntity> findByAdminId(Integer adminId);

    void saveOrUpdate(AdminAuditEntity audit);

}
