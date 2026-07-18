package kr.spring.material.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import kr.spring.material.entity.MaterialEntity;

@Repository
public interface MaterialRepository
        extends JpaRepository<MaterialEntity, String> {

	Page<MaterialEntity>
        findByMatCodeContainingIgnoreCaseOrMatNameContainingIgnoreCase(
            String matCode,
            String matName,
            Pageable pageable
        );
	
	
	
    @Query("""
            SELECT COUNT(m)
            FROM MaterialEntity m
            WHERE m.currentStock < m.safetyStock
        """)
        long countLowStockMaterials();
	
	
	
}