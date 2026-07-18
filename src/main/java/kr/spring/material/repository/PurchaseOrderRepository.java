package kr.spring.material.repository;

import java.util.Collection;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.spring.material.entity.PurchaseOrderEntity;

@Repository
public interface PurchaseOrderRepository
        extends JpaRepository<PurchaseOrderEntity, Long> {

	boolean existsByMaterial_MatCodeAndStatusIn(
		    String matCode,
		    Collection<String> statuses
		);

    List<PurchaseOrderEntity>
        findAllByOrderByOrderIdDesc();
}