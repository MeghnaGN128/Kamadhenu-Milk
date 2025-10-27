
package com.xworkz.dairy.service;

import com.xworkz.dairy.dto.ProductDTO;

import java.util.List;

public interface ProductService {

    void saveProduct(ProductDTO productDTO, String adminName);

    List<ProductDTO> getAllProducts();

    List<ProductDTO> findAll();

    ProductDTO findById(Integer id);

    boolean update(ProductDTO productDTO);

    long countProducts();

    List<ProductDTO> searchProducts(String keyword);

    List<String> getAllProductTypes();

    long countByStatus(boolean active);

    long countProductsBySearch(String keyword);

    boolean softDeleteProduct(Integer productId, String adminName);

    boolean deleteProduct(ProductDTO productDTO);
    
    // Pagination methods
    long getTotalProductCount();
    List<ProductDTO> getProductsPaginated(int offset, int pageSize);
}
