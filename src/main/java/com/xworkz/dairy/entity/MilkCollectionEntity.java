package com.xworkz.dairy.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "milk_collection")
public class MilkCollectionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "milk_collection_id")
    private Integer milkCollectionId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "agent_id", nullable = false)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private AgentEntity agent;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "admin_id", nullable = false)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private AdminEntity admin;

    @Column(name = "type_of_milk", nullable = false)
    private String typeOfMilk;

    @Column(name = "price", nullable = false)
    private Double price;

    @Column(name = "quantity", nullable = false)
    private Float quantity;

    @Column(name = "total_amount", nullable = false)
    private Double totalAmount;

    @Column(name = "collected_at", nullable = false)
    private LocalDate collectedAt;

    @Column(name = "phone_number", length = 15)
    private String phoneNumber;

    @Column(name = "agent_name")
    private String agentName;

    @Column(name = "agent_email")
    private String agentEmail;

    @OneToOne(mappedBy = "milkCollection", cascade = CascadeType.ALL)
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private MilkCollectionAuditEntity audit;
}