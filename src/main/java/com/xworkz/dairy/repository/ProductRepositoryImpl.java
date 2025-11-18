package com.xworkz.dairy.repository;

import com.xworkz.dairy.entity.ProductEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

@Slf4j
@Repository
public class ProductRepositoryImpl implements ProductRepository {

    @Autowired
    private EntityManagerFactory emf;

    @Override
    public ProductEntity save(ProductEntity entity) {
        EntityManager em = null;
        EntityTransaction tx = null;
        try {
            em = emf.createEntityManager();
            tx = em.getTransaction();
            tx.begin();
            em.persist(entity);
            tx.commit();
            return entity;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            log.error("Error saving product", e);
            throw e;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<ProductEntity> findAll() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT p FROM ProductEntity p WHERE p.active = true", ProductEntity.class).getResultList();
        } catch (Exception e) {
            log.error("Error fetching products", e);
            return Collections.emptyList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public ProductEntity findById(Integer id) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT p FROM ProductEntity p WHERE p.productId = :id AND p.active = true", ProductEntity.class)
                   .setParameter("id", id)
                   .getResultStream()
                   .findFirst()
                   .orElse(null);
        } catch (Exception e) {
            log.error("Error finding product with ID {}", id, e);
            return null;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public boolean update(ProductEntity entity) {
        EntityManager em = null;
        EntityTransaction tx = null;
        try {
            em = emf.createEntityManager();
            tx = em.getTransaction();
            tx.begin();

            ProductEntity existing = em.find(ProductEntity.class, entity.getProductId());
            if (existing == null) {
                log.warn("No product found with ID: {}", entity.getProductId());
                return false;
            }

            existing.setProductName(entity.getProductName());
            existing.setProductType(entity.getProductType());
            existing.setProductPrice(entity.getProductPrice());
            existing.setUpdatedBy(entity.getUpdatedBy());
            existing.setUpdatedDate(LocalDateTime.now());

            em.merge(existing);
            tx.commit();
            log.info("Product updated successfully for ID: {}", entity.getProductId());
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            log.error("Error updating product", e);
            return false;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public long countProducts() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT COUNT(p) FROM ProductEntity p", Long.class).getSingleResult();
        } catch (Exception e) {
            log.error("Error counting products", e);
            return 0;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<ProductEntity> searchProducts(String keyword) {
       EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createNamedQuery("searchProducts", ProductEntity.class)
                    .setParameter("keyword", keyword)
                    .getResultList();
        } catch (Exception e) {
            log.error("Error searching products: {}", keyword, e);
            return Collections.emptyList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<String> getAllProductTypes() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT DISTINCT p.type FROM ProductEntity p WHERE p.type IS NOT NULL", String.class)
                    .getResultList();
        } catch (Exception e) {
            log.error("Error fetching product types", e);
            return Collections.emptyList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public long countByStatus(boolean active) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT COUNT(p) FROM ProductEntity p WHERE p.active = :active", Long.class)
                    .setParameter("active", active)
                    .getSingleResult();
        } catch (Exception e) {
            log.error("Error counting products by status", e);
            return 0;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public long countProductsBySearch(String keyword) {
      EntityManager em = null;
        try {
            em = emf.createEntityManager();
            String q = "SELECT COUNT(p) FROM ProductEntity p WHERE " +
                    "(LOWER(p.name) LIKE :kw OR LOWER(p.type) LIKE :kw) " +
                    "AND p.active = true";
            Long count = em.createQuery(q, Long.class)
                    .setParameter("kw", "%" + keyword.toLowerCase() + "%")
                    .getSingleResult();
            return count != null ? count : 0;
        } catch (Exception e) {
            log.error("Error counting products by search keyword: {}", keyword, e);
            return 0;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public boolean softDelete(Integer productId, String updatedBy) {
        EntityManager em = null;
        EntityTransaction tx = null;
        try {
            em = emf.createEntityManager();
            tx = em.getTransaction();
            tx.begin();
            
            int updated = em.createNamedQuery("softDeleteProduct")
                .setParameter("productId", productId)
                .setParameter("updatedBy", updatedBy)
                .setParameter("updatedDate", LocalDateTime.now())
                .executeUpdate();
                
            tx.commit();
            log.info("Soft deleted product with ID: {}", productId);
            return updated > 0;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) tx.rollback();
            log.error("Error soft deleting product with ID: {}", productId, e);
            return false;
        } finally {
            if (em != null) em.close();
        }
    }
    
    @Override
    @Deprecated
    public void delete(ProductEntity entity) {
        throw new UnsupportedOperationException("Use softDelete() method instead");
    }

    @Override
    public long count() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery("SELECT COUNT(p) FROM ProductEntity p WHERE p.active = true", Long.class)
                   .getSingleResult();
        } catch (Exception e) {
            log.error("Error counting products", e);
            return 0;
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public List<ProductEntity> findPaginated(int offset, int limit) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery(
                    "SELECT p FROM ProductEntity p WHERE p.active = true ORDER BY p.productId", 
                    ProductEntity.class)
                   .setFirstResult(offset)
                   .setMaxResults(limit)
                   .getResultList();
        } catch (Exception e) {
            log.error("Error fetching paginated products", e);
            return Collections.emptyList();
        } finally {
            if (em != null) em.close();
        }
    }

    @Override
    public ProductEntity findByProductName(String name) {

        EntityManager em = null;
        try {
            em = emf.createEntityManager();

            em = emf.createEntityManager();
            return em.createNamedQuery("findByProductName",ProductEntity.class)
                    .setParameter("productName", name)
                    .getSingleResult();



        } catch (Exception e) {
          //  log.error("Error finding product with ID {}", e);
            return null;
        } finally {
            if (em != null) em.close();
        }

    }

    public List<String> findDistinctActiveProductNames() {

        EntityManager em = null;
        try {
            em = emf.createEntityManager();

            return em.createQuery(
                            "SELECT DISTINCT p.productName FROM ProductEntity p WHERE p.active = true " +
                                    "AND p.productType = 'Buy' " +
                                    "AND p.productName LIKE '%Milk%' " ,
                            String.class)
                    .getResultList();


        } catch (Exception e) {
            //  log.error("Error finding product with ID {}", e);
            return null;
        } finally {
            if (em != null) em.close();
        }





    }

}
