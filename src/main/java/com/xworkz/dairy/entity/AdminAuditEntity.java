package com.xworkz.dairy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "login_audit")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "adminAuditId")
    private Long adminAuditId;

    // Relation to admin_info
    @OneToOne
    @JoinColumn(name = "admin_id", referencedColumnName = "admin_id")
    @ToString.Exclude
    private AdminEntity admin;

    @Column(name = "admin_name", nullable = false)
    private String adminName;

    @Column(name = "login_time")
    private LocalDateTime loginTime;

    @Column(name = "logout_time")
    private LocalDateTime logoutTime;

    @Column(name = "action")
    private String action; // e.g. LOGIN, LOGOUT, SAVE

}
