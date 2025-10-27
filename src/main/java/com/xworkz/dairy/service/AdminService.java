package com.xworkz.dairy.service;

import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.entity.AdminEntity;

import javax.validation.Valid;

public interface AdminService {

    boolean save(@Valid AdminDTO adminDTO);

    AdminDTO adminlogin(String adminName, String password);

    boolean update(AdminDTO adminDTO1);

    String initiatePasswordReset(String email, String baseUrl);

    boolean isAccountLocked(String adminName);

    boolean resetPassword(String token, String password);

    AdminEntity findByEmailEntity(String email);

    boolean mobileNumberExists(String mobileNumber);

    AdminDTO findByEmail(String email);

}
