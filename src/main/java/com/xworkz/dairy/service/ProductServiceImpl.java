package com.xworkz.dairy.service;

import com.xworkz.dairy.dto.ProductDTO;
import com.xworkz.dairy.entity.ProductEntity;
import com.xworkz.dairy.repository.ProductRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public void saveProduct(ProductDTO productDTO, String adminName) {
        log.info("Saving product: {}", productDTO);
        try {
            ProductEntity productEntity = new ProductEntity();
            BeanUtils.copyProperties(productDTO, productEntity);
            productEntity.setCreatedDate(LocalDateTime.now());
            productEntity.setCreatedBy(adminName);
            productEntity.setActive(true); // Ensure active is set
            
            log.info("Product entity before save: {}", productEntity);
            ProductEntity savedEntity = productRepository.save(productEntity);
            log.info("Product saved successfully with ID: {}", savedEntity.getProductId());
        } catch (Exception e) {
            log.error("Error saving product: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to save product: " + e.getMessage(), e);
        }
    }

    @Override
    public List<ProductDTO> getAllProducts() {
        log.info("Fetching all products");
        try {
            List<ProductEntity> entities = productRepository.findAll();
            log.info("Found {} products in database", entities.size());

            if (entities.isEmpty()) {
                log.warn("No products found in the database");
                return Collections.emptyList();
            }

            List<ProductDTO> dtos = new ArrayList<>();
            for (ProductEntity e : entities) {
                ProductDTO dto = new ProductDTO();
                BeanUtils.copyProperties(e, dto);
                dtos.add(dto);
                log.debug("Mapped product: {}", dto);
            }

            log.info("Successfully retrieved {} products", dtos.size());
            return dtos;
        } catch (Exception e) {
            log.error("Error fetching products: {}", e.getMessage(), e);
            throw new RuntimeException("Failed to fetch products: " + e.getMessage(), e);
        }
    }

    @Override
    public List<ProductDTO> findAll() {
        List<ProductEntity> entities = productRepository.findAll();
        if (entities == null || entities.isEmpty()) {
            return Collections.emptyList();
        }
        return entities.stream()
                .map(entity -> {
                    ProductDTO dto = new ProductDTO();
                    BeanUtils.copyProperties(entity, dto);
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Override
    public ProductDTO findById(Integer id) {
        if (id == null) {
            return null;
        }
        return productRepository.findAll().stream()
                .filter(entity -> id.equals(entity.getProductId()))
                .findFirst()
                .map(entity -> {
                    ProductDTO dto = new ProductDTO();
                    BeanUtils.copyProperties(entity, dto);
                    return dto;
                })
                .orElse(null);
    }

    @Override
    public boolean update(ProductDTO productDTO) {
        if (productDTO == null || productDTO.getProductId() == null) return false;

        ProductEntity entity = new ProductEntity();
        BeanUtils.copyProperties(productDTO, entity);
        return productRepository.update(entity);
    }


    @Override
    public long countProducts() {
        return productRepository.findAll().size();
    }

    @Override
    public List<ProductDTO> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return Collections.emptyList();
        }
        String searchTerm = keyword.toLowerCase();
        return productRepository.findAll().stream()
                .filter(entity -> 
                    entity.getProductName() != null && 
                    entity.getProductName().toLowerCase().contains(searchTerm)
                )
                .map(entity -> {
                    ProductDTO dto = new ProductDTO();
                    BeanUtils.copyProperties(entity, dto);
                    return dto;
                })
                .collect(Collectors.toList());
    }

    @Override
    public List<String> getAllProductTypes() {
        return productRepository.findAll().stream()
                .map(ProductEntity::getProductType)
                .filter(type -> type != null && !type.trim().isEmpty())
                .distinct()
                .collect(Collectors.toList());
    }

    @Override
    public long countByStatus(boolean active) {
        return (int) productRepository.findAll().stream()
                .filter(entity -> entity.getActive() == active)
                .count();
    }

    @Override
    public long countProductsBySearch(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return 0;
        }
        String searchTerm = keyword.toLowerCase();
        return productRepository.findAll().stream()
                .filter(entity ->
                    entity.getProductName() != null && 
                    entity.getProductName().toLowerCase().contains(searchTerm)
                )
                .count();
    }

    @Override
    public boolean softDeleteProduct(Integer productId, String adminName) {
        if (productId == null) {
            log.warn("Cannot delete — missing productId");
            return false;
        }
        
        try {
            log.info("Soft deleting product with ID: {}", productId);
            return productRepository.softDelete(productId, adminName);
        } catch (Exception e) {
            log.error("Error soft deleting product with ID: {}", productId, e);
            return false;
        }
    }
    
    @Override
    @Deprecated
    public boolean deleteProduct(ProductDTO productDTO) {
        throw new UnsupportedOperationException("Use softDeleteProduct() method instead");
    }

    @Override
    public long getTotalProductCount() {
        try {
            log.info("Fetching total product count");
            return productRepository.count();
        } catch (Exception e) {
            log.error("Error getting total product count: {}", e.getMessage(), e);
            return 0;
        }
    }

    @Override
    public List<ProductDTO> getProductsPaginated(int offset, int pageSize) {
        log.info("Fetching paginated products - offset: {}, pageSize: {}", offset, pageSize);
        try {
            List<ProductEntity> entities = productRepository.findPaginated(offset, pageSize);
            log.info("Found {} products for pagination", entities.size());
            
            List<ProductDTO> dtos = new ArrayList<>();
            for (ProductEntity entity : entities) {
                ProductDTO dto = new ProductDTO();
                BeanUtils.copyProperties(entity, dto);
                dtos.add(dto);
            }
            return dtos;
        } catch (Exception e) {
            log.error("Error fetching paginated products: {}", e.getMessage(), e);
            return Collections.emptyList();
        }
    }
}