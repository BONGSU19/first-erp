package kr.spring.material.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.spring.material.entity.MaterialHistoryEntity;

@Repository
public interface MaterialHistoryRepository
        extends JpaRepository<MaterialHistoryEntity, Long> {

    List<MaterialHistoryEntity>
        findByMaterial_MatCodeOrderByHistoryIdDesc(
            String matCode
        );

    Page<MaterialHistoryEntity>
        findAllByOrderByHistoryIdDesc(
            Pageable pageable
        );
}