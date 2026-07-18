package kr.spring.material.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import kr.spring.material.dto.MaterialRegisterDTO;
import kr.spring.material.dto.StockTransactionDTO;
import kr.spring.material.entity.MaterialEntity;
import kr.spring.material.entity.MaterialHistoryEntity;
import kr.spring.material.entity.PurchaseOrderEntity;
import kr.spring.material.repository.MaterialHistoryRepository;
import kr.spring.material.repository.MaterialRepository;
import kr.spring.material.repository.PurchaseOrderRepository;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import kr.spring.material.dto.PurchaseOrderRegisterDTO;
import kr.spring.member.entity.EmployeeEntity;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class MaterialService {

    private final MaterialRepository materialRepository;

    private final MaterialHistoryRepository
            materialHistoryRepository;

    private final PurchaseOrderRepository
            purchaseOrderRepository;
    
    private final MemberRepository
    		memberRepository;
    /**
     * 전체 자재 또는 자재 코드·자재명 검색
     */
    @Transactional(readOnly = true)
    public Page<MaterialEntity> searchMaterials(
            String keyword,
            Pageable pageable) {

        if (keyword == null || keyword.isBlank()) {
            return materialRepository.findAll(
                pageable
            );
        }

        String searchKeyword =
                keyword.trim();

        return materialRepository
            .findByMatCodeContainingIgnoreCaseOrMatNameContainingIgnoreCase(
                searchKeyword,
                searchKeyword,
                pageable
            );
    }
    /**
     * 자재 한 건 조회
     */
    @Transactional(readOnly = true)
    public MaterialEntity getMaterial(
            String matCode) {

        return materialRepository.findById(matCode)
            .orElseThrow(() ->
                new IllegalArgumentException(
                    "자재를 찾을 수 없습니다."
                )
            );
    }

    /**
     * 신규 자재 등록
     */
    @Transactional
    public void registerMaterial(
            MaterialRegisterDTO dto) {

        String matCode =
                dto.getMatCode().trim().toUpperCase();

        // 자재 코드 중복 검사
        if (materialRepository.existsById(matCode)) {
            throw new IllegalArgumentException(
                "이미 등록된 자재 코드입니다."
            );
        }

        // 재고 수량 추가 검증
        if (dto.getCurrentStock() < 0) {
            throw new IllegalArgumentException(
                "현재 재고는 0 이상이어야 합니다."
            );
        }

        if (dto.getSafetyStock() < 0) {
            throw new IllegalArgumentException(
                "안전 재고는 0 이상이어야 합니다."
            );
        }

        MaterialEntity material =
                new MaterialEntity();

        material.setMatCode(matCode);
        material.setMatName(
            dto.getMatName().trim()
        );
        material.setCurrentStock(
            dto.getCurrentStock()
        );
        material.setSafetyStock(
            dto.getSafetyStock()
        );

        materialRepository.save(material);
    }

    /**
     * 자재 입고·출고 처리
     *
     * 반환값:
     * true  = 안전 재고 미만
     * false = 정상 재고
     */
    @Transactional
    public boolean processStock(
            String matCode,
            StockTransactionDTO dto,
            String empId) {

        /*
         * 1. 입출고 대상 자재 조회
         */
        MaterialEntity material =
                materialRepository.findById(matCode)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "자재를 찾을 수 없습니다."
                        )
                    );

        /*
         * 2. 처리 사원 조회
         */
        EmployeeEntity employee =
                memberRepository.findById(empId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "사원 정보를 찾을 수 없습니다."
                        )
                    );

        String type = dto.getType();
        int quantity = dto.getQuantity();

        /*
         * 3. 입력값 검사
         */
        if (quantity <= 0) {
            throw new IllegalArgumentException(
                "입출고 수량은 1개 이상이어야 합니다."
            );
        }

        if (type == null || type.isBlank()) {
            throw new IllegalArgumentException(
                "입고 또는 출고를 선택해 주세요."
            );
        }

        type = type.trim().toUpperCase();

        /*
         * 4. 변경 전 재고 저장
         */
        int stockBefore =
                material.getCurrentStock();

        /*
         * 5. 현재 재고 변경
         */
        if ("IN".equals(type)) {

            material.increaseStock(quantity);

        } else if ("OUT".equals(type)) {

            material.decreaseStock(quantity);

        } else {
            throw new IllegalArgumentException(
                "잘못된 입출고 유형입니다."
            );
        }

        /*
         * 6. 변경 후 재고 저장
         */
        int stockAfter =
                material.getCurrentStock();

        /*
         * 7. 입출고 이력 생성
         */
        MaterialHistoryEntity history =
                new MaterialHistoryEntity();

        history.setMaterial(material);
        history.setEmployee(employee);
        history.setType(type);
        history.setQuantity(quantity);

        history.setStockBefore(stockBefore);
        history.setStockAfter(stockAfter);

        materialHistoryRepository.save(history);

        /*
         * 8. 안전 재고 여부 확인
         */
        boolean belowSafetyStock =
                material.isBelowSafetyStock();

        /*
         * 9. 출고 후 안전 재고 미만이면
         * 발주서 자동 생성
         */
        if ("OUT".equals(type)
                && belowSafetyStock) {

            createPurchaseOrderIfNecessary(
                material,
                empId
            );
        }

        return belowSafetyStock;
    }

    /**
     * 처리 중인 발주서가 없을 때 자동 생성
     */
    private void createPurchaseOrderIfNecessary(
            MaterialEntity material,
            String empId) {

        /*
         * 아직 완료되거나 취소되지 않은 발주 상태
         */
        List<String> openStatuses =
                List.of(
                    "CREATED",
                    "APPROVED",
                    "ORDERED"
                );

        /*
         * 동일 자재의 처리 중 발주서 확인
         */
        boolean openOrderExists =
                purchaseOrderRepository
                    .existsByMaterial_MatCodeAndStatusIn(
                        material.getMatCode(),
                        openStatuses
                    );

        /*
         * 이미 처리 중인 발주서가 있다면
         * 새 발주서를 생성하지 않는다.
         */
        if (openOrderExists) {
            return;
        }

        /*
         * 목표 재고:
         * 안전 재고의 2배
         */
        int targetStock =
                material.getSafetyStock() * 2;

        /*
         * 발주 수량:
         * 목표 재고 - 현재 재고
         */
        int orderQuantity =
                targetStock
                - material.getCurrentStock();

        if (orderQuantity <= 0) {
            return;
        }

        PurchaseOrderEntity order =
                new PurchaseOrderEntity();

        order.setMaterial(material);
        order.setOrderQuantity(
            orderQuantity
        );

        
        EmployeeEntity employee =
                memberRepository.findById(empId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "사원 정보를 찾을 수 없습니다."
                        )
                    );
        
        order.setStatus("CREATED");
        order.setCreatedBy(employee);

        purchaseOrderRepository.save(order);
    }

    /**
     * 전체 입출고 내역 조회
     */
    @Transactional(readOnly = true)
    public Page<MaterialHistoryEntity>
            getAllHistories(
                    Pageable pageable) {

        return materialHistoryRepository
            .findAllByOrderByHistoryIdDesc(
                pageable
            );
    }

    /**
     * 특정 자재의 입출고 내역 조회
     */
    @Transactional(readOnly = true)
    public List<MaterialHistoryEntity>
            getMaterialHistories(
                    String matCode) {

        return materialHistoryRepository
            .findByMaterial_MatCodeOrderByHistoryIdDesc(
                matCode
            );
    }
    /**
     * 발주서 전체 조회
     */
    @Transactional(readOnly = true)
    public List<PurchaseOrderEntity>
            getPurchaseOrders() {

        return purchaseOrderRepository
            .findAllByOrderByOrderIdDesc();
    }
    /**
     * 발주서 한 건 조회
     */
    @Transactional(readOnly = true)
    public PurchaseOrderEntity getPurchaseOrder(
            Long orderId) {

        return purchaseOrderRepository
            .findById(orderId)
            .orElseThrow(() ->
                new IllegalArgumentException(
                    "발주서를 찾을 수 없습니다."
                )
            );
    }
    
    /**
     * 발주 처리
     */
    @Transactional
    public void placePurchaseOrder(
            Long orderId) {

        PurchaseOrderEntity order =
                purchaseOrderRepository
                    .findById(orderId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "발주서를 찾을 수 없습니다."
                        )
                    );

        /*
         * 자동 생성 상태의 발주서만
         * 실제 발주 처리 가능
         */
        if (!"CREATED".equals(order.getStatus())) {
            throw new IllegalArgumentException(
                "생성 상태의 발주서만 발주할 수 있습니다."
            );
        }

        order.setStatus("ORDERED");

        /*
         * findById()로 조회한 Entity는 영속 상태이므로
         * 별도로 save()를 호출하지 않아도
         * 변경 감지로 STATUS가 수정된다.
         */
    }

    
    /**
     * 발주서 작성용 전체 자재 조회
     */
    @Transactional(readOnly = true)
    public List<MaterialEntity> getAllMaterials() {

        return materialRepository.findAll(
            Sort.by(
                Sort.Direction.ASC,
                "matCode"
            )
        );
    }

    
    /**
     * 수동 발주서 등록
     */
    @Transactional
    public void registerPurchaseOrder(
            PurchaseOrderRegisterDTO dto,
            String empId) {

        /*
         * 발주할 자재 조회
         */
        MaterialEntity material =
                materialRepository
                    .findById(dto.getMatCode())
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "자재를 찾을 수 없습니다."
                        )
                    );

        /*
         * 작성자 조회
         */
        EmployeeEntity employee =
                memberRepository
                    .findById(empId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "사원 정보를 찾을 수 없습니다."
                        )
                    );

        if (dto.getOrderQuantity() <= 0) {
            throw new IllegalArgumentException(
                "발주 수량은 1개 이상이어야 합니다."
            );
        }

        /*
         * 처리 중인 동일 자재 발주서 확인
         */
        List<String> openStatuses =
                List.of(
                    "CREATED",
                    "APPROVED",
                    "ORDERED"
                );

        boolean openOrderExists =
                purchaseOrderRepository
                    .existsByMaterial_MatCodeAndStatusIn(
                        material.getMatCode(),
                        openStatuses
                    );

        if (openOrderExists) {
            throw new IllegalArgumentException(
                "해당 자재에 처리 중인 발주서가 이미 존재합니다."
            );
        }

        PurchaseOrderEntity order =
                new PurchaseOrderEntity();

        order.setMaterial(material);
        order.setOrderQuantity(
            dto.getOrderQuantity()
        );
        order.setStatus("CREATED");
        order.setCreatedBy(employee);

        purchaseOrderRepository.save(order);
    }
    
    /**
     * 발주 자재 입고 완료 처리
     */
    @Transactional
    public void completePurchaseOrder(
            Long orderId,
            String empId) {

        /*
         * 1. 발주서 조회
         */
        PurchaseOrderEntity order =
                purchaseOrderRepository
                    .findById(orderId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "발주서를 찾을 수 없습니다."
                        )
                    );

        /*
         * 2. 발주 상태 검사
         */
        if (!"ORDERED".equals(order.getStatus())) {
            throw new IllegalArgumentException(
                "발주 완료 상태의 발주서만 입고 처리할 수 있습니다."
            );
        }

        /*
         * 3. 입고 처리 사원 조회
         */
        EmployeeEntity employee =
                memberRepository
                    .findById(empId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "사원 정보를 찾을 수 없습니다."
                        )
                    );

        /*
         * 4. 발주서에 연결된 자재 조회
         */
        MaterialEntity material =
                order.getMaterial();

        int stockBefore =
                material.getCurrentStock();

        /*
         * 5. 발주 수량만큼 현재 재고 증가
         */
        material.increaseStock(
            order.getOrderQuantity()
        );

        int stockAfter =
                material.getCurrentStock();

        /*
         * 6. 입고 이력 저장
         */
        MaterialHistoryEntity history =
                new MaterialHistoryEntity();

        history.setMaterial(material);
        history.setEmployee(employee);
        history.setType("IN");
        history.setQuantity(
            order.getOrderQuantity()
        );

        history.setStockBefore(
            stockBefore
        );

        history.setStockAfter(
            stockAfter
        );

        materialHistoryRepository.save(history);

        /*
         * 7. 발주 상태 및 완료 일자 변경
         */
        order.setStatus("COMPLETED");
        order.setCompletedAt(
            LocalDateTime.now()
        );
    }
    
    
    
    
    
    /**
     * 안전 재고 미만 자재 개수 조회
     */
    @Transactional(readOnly = true)
    public long getLowStockCount() {

        return materialRepository
            .countLowStockMaterials();
    }
}