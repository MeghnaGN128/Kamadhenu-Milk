package com.xworkz.dairy.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "milk_collection_audit")
public class MilkCollectionAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "audit_id")
    private Integer auditId;

    @Column(name = "action", nullable = false)
    private String action;

    @Column(name = "action_timestamp", nullable = false)
    private LocalDateTime actionTimestamp;

    @Column(name = "performed_by")
    private String performedBy;

    @OneToOne
    @JoinColumn(name = "milk_collection_id")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private MilkCollectionEntity milkCollection;
}