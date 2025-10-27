package com.xworkz.dairy.controller;


import com.xworkz.dairy.dto.AdminDTO;
import com.xworkz.dairy.dto.ProductDTO;
import com.xworkz.dairy.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/")
public class ProductController {

    //controller---service---repository

    @Autowired
    private ProductService productService;


    @PostMapping("save")
    public String saveProduct(@ModelAttribute ProductDTO productDTO, HttpSession session, RedirectAttributes redirectAttributes) {
        log.info("Attempting to save product: {}", productDTO);
        try {
            AdminDTO sessionAdmin = (AdminDTO) session.getAttribute("adminDTO");
            if (sessionAdmin == null) {
                log.warn("Unauthorized access attempt - no admin session found");
                return "redirect:/adminLogin";
            }
            if (productDTO.getProductName() == null || productDTO.getProductName().trim().isEmpty()) {
                log.warn("Validation failed: Product name is required");
                redirectAttributes.addFlashAttribute("errorMessage", "Product name is required");
                return "redirect:/productDashboard";
            }
            
            log.info("Saving product with admin: {}", sessionAdmin.getAdminName());
            productService.saveProduct(productDTO, sessionAdmin.getAdminName());
            log.info("Product saved successfully");
            redirectAttributes.addFlashAttribute("successMessage", "Product saved successfully!");
        } catch (Exception e) {
            log.error("Error saving product: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "Error saving product: " + e.getMessage());
        }
        return "redirect:/productDashboard";
    }

    //repository---service---controller--read

    @GetMapping("productDashboard")
    public String getAllProducts(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "6") int size,
            Model model, 
            HttpSession session) {
        try {
            log.info("Loading product dashboard - Page: {}, Size: {}", page, size);
            AdminDTO sessionAdmin = (AdminDTO) session.getAttribute("adminDTO");
            if (sessionAdmin == null) {
                log.warn("Unauthorized access attempt - no admin session found");
                return "redirect:/adminLogin";
            }

            log.info("Fetching products for admin: {}", sessionAdmin.getAdminName());
            
            // Get total count of products for pagination
            long totalProducts = productService.getTotalProductCount();
            int totalPages = (int) Math.ceil((double) totalProducts / size);
            
            // Adjust page number if out of bounds
            if (page < 1) page = 1;
            if (page > totalPages && totalPages > 0) page = totalPages;
            
            // Get paginated products
            List<ProductDTO> products = productService.getProductsPaginated((page - 1) * size, size);
            
            log.info("Fetched {} products out of {} (Page {}/{})", 
                products.size(), totalProducts, page, totalPages);
            
            model.addAttribute("allProducts", products);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("totalProducts", totalProducts);
            model.addAttribute("pageSize", size);
            
            if (products.isEmpty()) {
                log.warn("No products found in the database");
                model.addAttribute("infoMessage", "No products found. Please add some products.");
            }
            
            return "productDashboard";
            
        } catch (Exception e) {
            log.error("Error loading product dashboard: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "Error loading products: " + e.getMessage());
            return "productDashboard";
        }
    }

    @GetMapping("deleteProduct")
    @ResponseBody
    public Map<String, Object> deleteProduct(@RequestParam("productId") Integer productId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        AdminDTO adminDTO = (AdminDTO) session.getAttribute("adminDTO");
        if (adminDTO == null) {
            response.put("success", false);
            response.put("message", "Please login to delete products");
            response.put("redirect", "/adminLogin");
            return response;
        }
        
        try {
            boolean deleted = productService.softDeleteProduct(productId, adminDTO.getAdminName());
            if (deleted) {
                response.put("success", true);
                response.put("message", "Product deleted successfully!");
            } else {
                response.put("success", false);
                response.put("message", "Failed to delete product!");
            }
        } catch (Exception e) {
            log.error("Error deleting product: {}", e.getMessage(), e);
            response.put("success", false);
            response.put("message", "An error occurred while deleting the product");
        }
        
        return response;
    }

    @PostMapping("updateProduct")
    public String updateProduct(@ModelAttribute ProductDTO productDTO, HttpSession session, RedirectAttributes redirectAttributes) {
        AdminDTO adminDTO = (AdminDTO) session.getAttribute("adminDTO");
        if (adminDTO == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please login to update products");
            return "redirect:/adminLogin";
        }
        productDTO.setUpdatedBy(adminDTO.getAdminName());
        productDTO.setUpdatedAt(LocalDateTime.now());
        boolean updated = productService.update(productDTO);
        if (updated) {
            redirectAttributes.addFlashAttribute("successMessage", "Product updated successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update product!");
        }
        return "redirect:/productDashboard";
    }

    @GetMapping("searchProduct")
    public String searchProduct(@ModelAttribute ProductDTO productDTO, Model model) {
        List<ProductDTO> searchProducts = productService.searchProducts(productDTO.getProductName());
        model.addAttribute("searchProducts", searchProducts);
        return "productDashboard";
    }
    @GetMapping("countProducts")
    public String countProducts(Model model) {
        long count = productService.countProducts();
        model.addAttribute("count", count);
        return "productDashboard";
    }
    @GetMapping("countProductsBySearch")
    public String countProductsBySearch(@ModelAttribute ProductDTO productDTO, Model model) {
        long count = productService.countProductsBySearch(productDTO.getProductName());
        model.addAttribute("count", count);
        return "productDashboard";
    }
    @GetMapping("countByStatus")
    public String countByStatus(Model model) {
        long count = productService.countByStatus(true);
        model.addAttribute("count", count);
        return "productDashboard";
    }
    @GetMapping("searchProducts")
    public String searchProducts(@ModelAttribute ProductDTO productDTO, Model model) {
        List<ProductDTO> searchProducts = productService.searchProducts(productDTO.getProductName());
        model.addAttribute("searchProducts", searchProducts);
        return "productDashboard";
    }
    @GetMapping("getAllProductTypes")
    public String getAllProductTypes(Model model) {
        List<String> productTypes = productService.getAllProductTypes();
        model.addAttribute("productTypes", productTypes);
        return "productDashboard";
    }
}