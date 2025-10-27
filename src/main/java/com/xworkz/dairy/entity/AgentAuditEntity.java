package com.xworkz.dairy.entity;

import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "agent_audit")
@Data
public class AgentAuditEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "audit_id")
    private Long auditId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agent_id", nullable = false, referencedColumnName = "agent_id")
    private AgentEntity agent;

    @Column(name = "agent_name", nullable = false, length = 100)
    private String agentName;

    @Column(name = "action", length = 50, nullable = false)
    private String action;

    @Column(name = "created_by", length = 100, nullable = false)
    private String createdBy;

    @CreationTimestamp
    @Column(name = "created_on", updatable = false, nullable = false)
    private LocalDateTime createdOn;

    @Column(name = "updated_by", length = 100)
    private String updatedBy;

    @UpdateTimestamp
    @Column(name = "updated_on")
    private LocalDateTime updatedOn;

    @PrePersist
    @PreUpdate
    public void prePersist() {
        if (createdOn == null) {
            createdOn = LocalDateTime.now();
        }
        updatedOn = LocalDateTime.now();
    }

}