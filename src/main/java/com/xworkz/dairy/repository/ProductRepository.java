package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.ProductEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ProductRepository {
    ProductEntity save(ProductEntity entity);

    List<ProductEntity> findAll();

    ProductEntity findById(Integer id);

    boolean update(ProductEntity productEntity);

    long countProducts();

    List<ProductEntity> searchProducts(String keyword);

    List<String> getAllProductTypes();
    
    boolean softDelete(Integer productId, String updatedBy);

    long countByStatus(boolean active);


    long countProductsBySearch(String keyword);

    void delete(ProductEntity entity);

    long count();
    
    @Query(value = "SELECT * FROM product_entity WHERE is_active = true ORDER BY product_id LIMIT :limit OFFSET :offset",
           nativeQuery = true)
    List<ProductEntity> findPaginated(@Param("offset") int offset, @Param("limit") int limit);
}
