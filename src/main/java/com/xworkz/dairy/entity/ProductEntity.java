package com.xworkz.dairy.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "products")
@Data
@NoArgsConstructor
@AllArgsConstructor
@NamedQueries({
        @NamedQuery(name = "findAllProducts", query = "SELECT p FROM ProductEntity p WHERE p.active = true"),
        @NamedQuery(name = "findByProductName", query = "SELECT p FROM ProductEntity p WHERE p.productName = :productName AND p.active = true"),
        @NamedQuery(name = "findByProductType", query = "SELECT p FROM ProductEntity p WHERE p.productType = :productType AND p.active = true"),
        @NamedQuery(name = "findByProductId", query = "SELECT p FROM ProductEntity p WHERE p.productId = :productId AND p.active = true"),
        @NamedQuery(name = "softDeleteProduct", query = "UPDATE ProductEntity p SET p.active = false, p.updatedDate = :updatedDate, p.updatedBy = :updatedBy WHERE p.productId = :productId")
})
public class ProductEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Integer productId;

    @Column(name = "product_name", nullable = false, length = 100)
    private String productName;

    @Column(name = "product_type", nullable = false)
    private String productType;

    @Column(name = "product_price", nullable = false)
    private Double productPrice;

    @Column(name = "active")
    private Boolean active = true;

    @Column(name = "created_by", nullable = false, length = 50)
    private String createdBy;

    @Column(name = "created_date", nullable = false)
    private LocalDateTime createdDate = LocalDateTime.now();

    @Column(name = "updated_by", length = 50)
    private String updatedBy;

    @Column(name = "updated_date")
    private LocalDateTime updatedDate;
}
