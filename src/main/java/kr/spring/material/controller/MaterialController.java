package kr.spring.material.controller;

import java.util.List;

import javax.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.material.dto.MaterialRegisterDTO;
import kr.spring.material.dto.StockTransactionDTO;
import kr.spring.material.entity.MaterialEntity;
import kr.spring.material.entity.MaterialHistoryEntity;
import kr.spring.material.service.MaterialService;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

import kr.spring.material.entity.PurchaseOrderEntity;
import kr.spring.material.dto.PurchaseOrderRegisterDTO;

@Controller
@RequiredArgsConstructor
public class MaterialController {

    private final MaterialService materialService;
    private final MemberRepository memberRepository;

    /**
     * 자재 목록
     */
    @GetMapping("/materials")
    public String materialList(
            @RequestParam(required = false)
            String keyword,

            @RequestParam(
                defaultValue = "0"
            )
            int materialPage,

            @RequestParam(
                defaultValue = "0"
            )
            int historyPage,

            Authentication authentication,
            Model model) {

        /*
         * 자재 목록:
         * 한 페이지에 5개
         * 자재 코드 오름차순
         */
        Pageable materialPageable =
                PageRequest.of(
                    materialPage,
                    5,
                    Sort.by(
                        Sort.Direction.ASC,
                        "matCode"
                    )
                );

        /*
         * 입출고 이력:
         * 한 페이지에 10개
         *
         * Repository 메서드 이름에서
         * historyId DESC 정렬을 처리함
         */
        Pageable historyPageable =
                PageRequest.of(
                    historyPage,
                    10
                );

        Page<MaterialEntity> materialResult =
                materialService.searchMaterials(
                    keyword,
                    materialPageable
                );

        Page<MaterialHistoryEntity> historyResult =
                materialService.getAllHistories(
                    historyPageable
                );

        addLoginMember(authentication, model);

        /*
         * 실제 목록 데이터
         */
        model.addAttribute(
            "materials",
            materialResult.getContent()
        );

        model.addAttribute(
            "histories",
            historyResult.getContent()
        );

        /*
         * Page 객체
         */
        model.addAttribute(
            "materialPage",
            materialResult
        );

        model.addAttribute(
            "historyPage",
            historyResult
        );

        model.addAttribute(
            "keyword",
            keyword
        );

        return "materials";
    }

    /**
     * 자재 등록 화면
     */
    @GetMapping("/materials/register")
    public String materialRegisterForm(
            Authentication authentication,
            Model model) {

        addLoginMember(authentication, model);

        model.addAttribute(
            "materialRegisterDTO",
            new MaterialRegisterDTO()
        );

        return "materialRegister";
    }

    /**
     * 자재 등록 처리
     */
    @PostMapping("/materials/register")
    public String registerMaterial(
            @Valid
            @ModelAttribute("materialRegisterDTO")
            MaterialRegisterDTO dto,
            BindingResult bindingResult,
            Authentication authentication,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            addLoginMember(authentication, model);
            return "materialRegister";
        }

        try {
            materialService.registerMaterial(dto);

        } catch (IllegalArgumentException e) {
            addLoginMember(authentication, model);
            model.addAttribute(
                "error",
                e.getMessage()
            );

            return "materialRegister";
        }

        redirectAttributes.addFlashAttribute(
            "message",
            "자재가 등록되었습니다."
        );

        return "redirect:/materials";
    }

    /**
     * 입고·출고 처리
     */
    @PostMapping("/materials/{matCode}/stock")
    public String processStock(
            @PathVariable String matCode,
            @Valid StockTransactionDTO dto,
            BindingResult bindingResult,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute(
                "error",
                bindingResult
                    .getAllErrors()
                    .get(0)
                    .getDefaultMessage()
            );

            return "redirect:/materials";
        }

        try {
            boolean belowSafetyStock =
                    materialService.processStock(
                        matCode,
                        dto,
                        authentication.getName()
                    );

            if (belowSafetyStock) {
                redirectAttributes.addFlashAttribute(
                    "warning",
                    "안전 재고 미만입니다. "
                    + "발주서 생성 여부를 확인해 주세요."
                );

            } else {
                redirectAttributes.addFlashAttribute(
                    "message",
                    "입출고 처리가 완료되었습니다."
                );
            }

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );
        }

        return "redirect:/materials";
    }

    /**
     * 발주서 목록
     */
    @GetMapping("/purchase-orders")
    public String purchaseOrderList(
            Authentication authentication,
            Model model) {

        addLoginMember(authentication, model);

        model.addAttribute(
            "purchaseOrders",
            materialService.getPurchaseOrders()
        );

        return "purchaseOrders";
    }

    private void addLoginMember(
            Authentication authentication,
            Model model) {

        EmployeeEntity loginMember =
                memberRepository.findByEmpId(
                    authentication.getName()
                );

        model.addAttribute(
            "dashboard",
            loginMember
        );
    }
    
    /**
     * 발주하기
     */
    @PostMapping("/purchase-orders/{orderId}/order")
    public String placePurchaseOrder(
            @PathVariable Long orderId,
            RedirectAttributes redirectAttributes) {

        try {
            materialService.placePurchaseOrder(
                orderId
            );

            redirectAttributes.addFlashAttribute(
                "message",
                "발주 처리가 완료되었습니다."
            );

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );
        }

        return "redirect:/purchase-orders";
    }
    
    /**
     * 발주서 작성 화면
     */
    @GetMapping("/purchase-orders/register")
    public String purchaseOrderRegisterForm(
            Authentication authentication,
            Model model) {

        addLoginMember(authentication, model);

        model.addAttribute(
            "purchaseOrderRegisterDTO",
            new PurchaseOrderRegisterDTO()
        );

        model.addAttribute(
            "materials",
            materialService.getAllMaterials()
        );

        return "purchaseOrderRegister";
    }
    
    /**
     * 발주서 등록 처리
     */
    @PostMapping("/purchase-orders/register")
    public String registerPurchaseOrder(
            @Valid
            @ModelAttribute("purchaseOrderRegisterDTO")
            PurchaseOrderRegisterDTO dto,
            BindingResult bindingResult,
            Authentication authentication,
            Model model,
            RedirectAttributes redirectAttributes) {

        /*
         * DTO 검증 실패
         */
        if (bindingResult.hasErrors()) {

            addLoginMember(authentication, model);

            model.addAttribute(
                "materials",
                materialService.getAllMaterials()
            );

            return "purchaseOrderRegister";
        }

        try {
            materialService.registerPurchaseOrder(
                dto,
                authentication.getName()
            );

        } catch (IllegalArgumentException e) {

            addLoginMember(authentication, model);

            /*
             * 오류 후 페이지를 다시 출력할 때도
             * 자재 선택 목록이 필요함
             */
            model.addAttribute(
                "materials",
                materialService.getAllMaterials()
            );

            model.addAttribute(
                "error",
                e.getMessage()
            );

            return "purchaseOrderRegister";
        }

        redirectAttributes.addFlashAttribute(
            "message",
            "발주서가 작성되었습니다."
        );

        return "redirect:/purchase-orders";
    }
 
    /**
     * 발주 자재 입고 완료
     */
    @PostMapping("/purchase-orders/{orderId}/complete")
    public String completePurchaseOrder(
            @PathVariable Long orderId,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        try {
            materialService.completePurchaseOrder(
                orderId,
                authentication.getName()
            );

            redirectAttributes.addFlashAttribute(
                "message",
                "입고가 완료되어 현재 재고에 반영되었습니다."
            );

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );
        }

        return "redirect:/purchase-orders";
    }
    
    /**
     * 발주 확인 화면
     */
    @GetMapping("/purchase-orders/{orderId}/order")
    public String purchaseOrderForm(
            @PathVariable Long orderId,
            Authentication authentication,
            Model model) {

        addLoginMember(authentication, model);

        PurchaseOrderEntity purchaseOrder =
                materialService.getPurchaseOrder(
                    orderId
                );

        model.addAttribute(
            "purchaseOrder",
            purchaseOrder
        );

        return "purchaseOrderForm";
    }
    
}