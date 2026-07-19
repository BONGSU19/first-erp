# 🏢 FirstERP

> 인사·근태·자재·발주·전자결재 업무를 통합 관리하는 Spring Boot 기반 ERP 웹 애플리케이션

<br>

## 📌 프로젝트 소개

FirstERP는 사내에서 발생하는 인사, 근태, 자재 및 전자결재 업무를 하나의 시스템에서 처리하기 위해 개발한 ERP 프로젝트입니다.

단순 CRUD를 넘어 자재 입출고 이력 관리, 안전재고 감지, 자동 발주, 권한별 접근 제어 등 실제 업무 흐름을 구현하는 데 집중했습니다.



<br>

## 🛠 기술 스택

| 구분 | 기술 |
|---|---|
| Backend | Java 17, Spring Boot 2.7.17, Spring MVC |
| Security | Spring Security, BCrypt |
| Database | Oracle XE |
| ORM | Spring Data JPA |
| Frontend | JSP, JSTL, HTML, CSS, JavaScript |
| Real-time | WebSocket, STOMP |
| Build | Gradle |
| Tools | Eclipse, SQL Developer, GitHub |

<br>

## ✨ 주요 기능

### 🔐 로그인 및 권한 관리

- 사원번호 기반 로그인
- BCrypt 비밀번호 암호화
- `USER`, `ADMIN` 권한 구분
- 최초 로그인 시 비밀번호 변경
- 관리자 기능 접근 제한

### 👥 인사 관리

- 신규 사원 계정 등록
- 부서 및 사원번호 검색
- 사원 정보와 권한 수정
- DTO 유효성 검사
- PRG 패턴을 통한 중복 등록 방지

### 🕐 근태 관리

- 출퇴근 시간 기록
- 접속 IP 주소 저장
- 중복 출근 및 잘못된 퇴근 처리 방지
- 사원 및 부서별 근태 조회

### 📦 자재 관리

- 자재 등록 및 검색
- 자재 입고·출고 처리
- 현재 재고보다 많은 출고 방지
- 변경 전·후 재고와 처리 사원 기록
- 안전재고 미만 자재 확인

### 🚚 자동 발주 관리

- 수동 발주서 생성
- 안전재고 미만 시 발주서 자동 생성
- 대기 중인 발주서 확인을 통한 중복 발주 방지
- 발주 대기·완료·취소 상태 관리

### 📄 전자결재

- 결재 문서 작성
- 기안자 및 결재자 지정
- 결재 승인·반려 처리
- 사용자별 결재 문서 접근 권한 검사
- WebSocket 기반 실시간 알림

<br>

## ⭐ 핵심 구현

### Entity 내부의 재고 변경 규칙

재고를 Service에서 직접 계산하지 않고 `MaterialEntity`가 자신의 재고를 검증하고 변경하도록 구현했습니다.

```java
material.increaseStock(quantity);
material.decreaseStock(quantity);
```

현재 재고보다 많은 수량을 출고하면 예외를 발생시켜 음수 재고를 방지합니다.

```java
if (currentStock < quantity) {
    throw new IllegalArgumentException(
        "현재 재고보다 많이 출고할 수 없습니다."
    );
}
```

### 안전재고 기반 자동 발주

```text
자재 출고
  → 재고 변경
  → 입출고 이력 저장
  → 안전재고 확인
  → 기존 대기 발주서 확인
  → 발주서 자동 생성
```

재고 변경, 이력 저장 및 자동 발주를 하나의 트랜잭션에서 처리해 데이터 일관성을 유지했습니다.

<br>

## 🗂️ 주요 테이블

| 테이블 | 역할 |
|---|---|
| `EMPLOYEE` | 사원 및 권한 관리 |
| `ATTENDANCE` | 출퇴근 기록 |
| `MATERIAL` | 자재 및 현재 재고 관리 |
| `MATERIAL_HISTORY` | 자재 입출고 이력 |
| `PURCHASE_ORDER` | 발주서 관리 |
| `APPROVAL` | 전자결재 관리 |

> ERD 이미지 추가

<br>

## 📸 주요 화면

### 메인 대시보드

> <img width="1899" height="914" alt="image" src="https://github.com/user-attachments/assets/6b23dc99-7098-4cf7-90a5-d75d4e0b1d40" />


### 인사 관리

> <img width="1655" height="631" alt="image" src="https://github.com/user-attachments/assets/bdaae699-3e7e-41d8-b113-750cb1489ccf" />
<img width="923" height="664" alt="image" src="https://github.com/user-attachments/assets/afc6b492-2266-43ea-97a8-ebe10c33dc69" />
<img width="939" height="616" alt="image" src="https://github.com/user-attachments/assets/af6c282c-071e-4a63-b933-e3e66eafa0e8" />


### 자재 입출고 및 이력 관리

> <img width="1623" height="832" alt="image" src="https://github.com/user-attachments/assets/6d043053-f3bd-4b19-a85b-5af00d91a32d" />


### 발주서 관리

> <img width="1619" height="656" alt="image" src="https://github.com/user-attachments/assets/1ae3bd23-65de-4765-9219-79bf8d6bd9c8" />


### 전자결재

><img width="1637" height="484" alt="image" src="https://github.com/user-attachments/assets/94540c6a-5ba9-42f3-8240-9a7c5ec52438" />


<br>

## 🔧 문제 해결

### JPA 연관관계 Repository 오류

`MaterialHistoryEntity`가 `MaterialEntity`를 객체로 참조하도록 변경하면서 Repository 메서드를 연관관계 구조에 맞게 수정했습니다.

```java
// 변경 전
findByMatCodeOrderByHistoryIdDesc(String matCode);

// 변경 후
findByMaterial_MatCodeOrderByHistoryIdDesc(String matCode);
```

### 중복 자동 발주 방지

안전재고 미만 상태에서 출고가 반복되더라도 같은 자재의 발주서가 중복 생성되지 않도록 기존 대기 발주서를 먼저 확인했습니다.

<br>

## 💭 회고

FirstERP를 개발하며 단순 CRUD뿐만 아니라 Entity의 책임, JPA 연관관계, 트랜잭션 및 업무 규칙 설계의 중요성을 배웠습니다.

특히 재고 변경 규칙을 Entity에 모으고, 재고 변경부터 이력 저장과 자동 발주까지 하나의 업무 흐름으로 연결하면서 계층별 역할을 구분하는 경험을 할 수 있었습니다.

<br>

