package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.AdminEntity;

public interface AdminRepository {
    Boolean save(AdminEntity adminEntity);

    AdminEntity findByEmail(String email);

    void update(AdminEntity adminEntity);

    AdminEntity findByResetToken(String token);
}


