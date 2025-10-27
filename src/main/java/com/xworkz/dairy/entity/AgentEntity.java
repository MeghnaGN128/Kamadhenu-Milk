package com.xworkz.dairy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "agent_info")
@Data
@NoArgsConstructor
@AllArgsConstructor
@NamedQueries({
        @NamedQuery(name = "findAllAgents", query = "SELECT a FROM AgentEntity a WHERE a.active = true"),
        @NamedQuery(name = "findByAgentEmail", query = "SELECT a FROM AgentEntity a WHERE a.email = :email"),
        @NamedQuery(name = "findByAgentPhoneNumber", query = "SELECT a FROM AgentEntity a WHERE a.phoneNumber = :phoneNumber"),
        @NamedQuery(name = "findByAgentId", query = "SELECT a FROM AgentEntity a WHERE a.agentId = :agentId")
})
public class AgentEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "agent_id")
    private Integer agentId;

    @Column(name = "first_name", nullable = false, length = 50)
    private String firstName;

    @Column(name = "last_name", length = 50)
    private String lastName;

    @Column(name = "email", unique = true, nullable = false, length = 100)
    private String email;

    @Column(name = "phone_number", unique = true, nullable = false, length = 15)
    private String phoneNumber;

    @Column(name = "address", length = 255)
    private String address;

    @Column(name = "types_of_milk", length = 100)
    private String typesOfMilk;

    @Column(name = "active")
    private Boolean active = true;

    @Column(name = "created_by", nullable = false, length = 50)
    private String createdBy;

    @Column(name = "created_date", nullable = false)
    private java.time.LocalDateTime createdDate;

    @Column(name = "updated_by", length = 50)
    private String updatedBy;

    @Column(name = "updated_date")
    private java.time.LocalDateTime updatedDate;
}
