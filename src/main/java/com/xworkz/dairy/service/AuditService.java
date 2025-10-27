package com.xworkz.dairy.service;

import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.entity.AdminEntity;

public interface AuditService {
    public void logAdminLogin(AdminEntity adminEntity);
    public void logAdminLogout(AdminEntity adminEntity);

    void logAdminAuditSave(AdminDTO adminDTO);
}
