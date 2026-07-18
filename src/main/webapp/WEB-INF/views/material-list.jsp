<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="material-container">

    <!-- 페이지 제목 -->
    <div class="page-title-area">
        <div>
            <h1>자재 관리</h1>
            <p>자재의 현재 재고와 입출고 내역을 관리합니다.</p>
        </div>

        <div class="title-buttons">
            <a class="btn primary"
               href="${pageContext.request.contextPath}/materials/register">
                신규 자재 등록
            </a>

            <a class="btn secondary"
               href="${pageContext.request.contextPath}/purchase-orders">
                발주서 목록
            </a>
        </div>
    </div>

    <!-- 성공 메시지 -->
    <c:if test="${not empty message}">
        <div class="alert success">
            ${message}
        </div>
    </c:if>

    <!-- 오류 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert error">
            ${error}
        </div>
    </c:if>

    <!-- 안전 재고 경고 -->
    <c:if test="${not empty warning}">
        <div class="alert warning">
            ${warning}
        </div>

        <script>
            alert('${warning}');
        </script>
    </c:if>

    <!-- 검색 -->
    <form class="search-form"
          method="get"
          action="${pageContext.request.contextPath}/materials">

        <input type="text"
               name="keyword"
               value="${keyword}"
               placeholder="자재 코드 또는 자재명 검색">

        <button type="submit"
                class="btn primary">
            검색
        </button>

        <a class="btn reset"
           href="${pageContext.request.contextPath}/materials">
            초기화
        </a>
    </form>

    <!-- ==================================== -->
    <!-- 자재 목록 -->
    <!-- ==================================== -->

    <div class="section-header">
        <h2>자재 현황</h2>

        <c:if test="${not empty materialPage}">
            <span class="result-count">
                총 ${materialPage.totalElements}건
            </span>
        </c:if>
    </div>

    <div class="table-wrapper">
        <table class="material-table">
            <thead>
                <tr>
                    <th>자재 코드</th>
                    <th>자재명</th>
                    <th>현재 재고</th>
                    <th>안전 재고</th>
                    <th>상태</th>
                    <th>입출고 처리</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="material"
                           items="${materials}">

                    <tr class="${material.currentStock
                                < material.safetyStock
                                ? 'low-stock-row' : ''}">

                        <td>${material.matCode}</td>
                        <td>${material.matName}</td>
                        <td>${material.currentStock}</td>
                        <td>${material.safetyStock}</td>

                        <td>
                            <c:choose>
                                <c:when test="${material.currentStock
                                                < material.safetyStock}">

                                    <span class="stock-status low">
                                        재고 부족
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="stock-status normal">
                                        정상
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <form class="stock-form"
                                  method="post"
                                  action="${pageContext.request.contextPath}/materials/${material.matCode}/stock">

                                <select name="type"
                                        required>

                                    <option value="IN">
                                        입고
                                    </option>

                                    <option value="OUT">
                                        출고
                                    </option>
                                </select>

                                <input type="number"
                                       name="quantity"
                                       min="1"
                                       placeholder="수량"
                                       required>

                                <button type="submit"
                                        class="btn process">
                                    처리
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty materials}">
                    <tr>
                        <td colspan="6"
                            class="empty-data">
                            조회된 자재가 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 자재 목록 페이징 -->
    <c:if test="${not empty materialPage
                  and materialPage.totalPages > 1}">

        <div class="pagination">

            <!-- 처음 -->
            <c:if test="${not materialPage.first}">
                <c:url var="materialFirstUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="0"/>

                    <c:param name="historyPage"
                             value="${historyPage.number}"/>
                </c:url>

                <a href="${materialFirstUrl}">
                    처음
                </a>
            </c:if>

            <!-- 이전 -->
            <c:if test="${not materialPage.first}">
                <c:url var="materialPreviousUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.number - 1}"/>

                    <c:param name="historyPage"
                             value="${historyPage.number}"/>
                </c:url>

                <a href="${materialPreviousUrl}">
                    이전
                </a>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach var="pageNumber"
                       begin="0"
                       end="${materialPage.totalPages - 1}">

                <c:url var="materialPageUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${pageNumber}"/>

                    <c:param name="historyPage"
                             value="${historyPage.number}"/>
                </c:url>

                <a href="${materialPageUrl}"
                   class="${pageNumber == materialPage.number
                            ? 'active' : ''}">

                    ${pageNumber + 1}
                </a>
            </c:forEach>

            <!-- 다음 -->
            <c:if test="${not materialPage.last}">
                <c:url var="materialNextUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.number + 1}"/>

                    <c:param name="historyPage"
                             value="${historyPage.number}"/>
                </c:url>

                <a href="${materialNextUrl}">
                    다음
                </a>
            </c:if>

            <!-- 마지막 -->
            <c:if test="${not materialPage.last}">
                <c:url var="materialLastUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.totalPages - 1}"/>

                    <c:param name="historyPage"
                             value="${historyPage.number}"/>
                </c:url>

                <a href="${materialLastUrl}">
                    마지막
                </a>
            </c:if>
        </div>
    </c:if>

    <!-- ==================================== -->
    <!-- 입출고 내역 -->
    <!-- ==================================== -->

    <div class="section-header history-header">
        <h2>입출고 내역</h2>

        <c:if test="${not empty historyPage}">
            <span class="result-count">
                총 ${historyPage.totalElements}건
            </span>
        </c:if>
    </div>

    <div class="table-wrapper">
        <table class="material-table">
            <thead>
                <tr>
                    <th>이력 번호</th>
                    <th>자재 코드</th>
                    <th>자재명</th>
                    <th>처리 사원</th>
                    <th>구분</th>
                    <th>수량</th>
                    <th>변경 전</th>
                    <th>변경 후</th>
                    <th>처리 일자</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="history"
                           items="${histories}">

                    <tr>
                        <td>${history.historyId}</td>

                        <td>
                            ${history.material.matCode}
                        </td>

                        <td>
                            ${history.material.matName}
                        </td>

                        <td>
                            ${history.employee.empName}
                            (${history.employee.empId})
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${history.type == 'IN'}">
                                    <span class="history-type in">
                                        입고
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="history-type out">
                                        출고
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${history.quantity}</td>

                        <td>
                            <c:choose>
                                <c:when test="${not empty history.stockBefore}">
                                    ${history.stockBefore}
                                </c:when>

                                <c:otherwise>
                                    -
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${not empty history.stockAfter}">
                                    ${history.stockAfter}
                                </c:when>

                                <c:otherwise>
                                    -
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${history.regDate}</td>
                    </tr>
                </c:forEach>

                <c:if test="${empty histories}">
                    <tr>
                        <td colspan="9"
                            class="empty-data">
                            입출고 내역이 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- 입출고 이력 페이징 -->
    <c:if test="${not empty historyPage
                  and historyPage.totalPages > 1}">

        <div class="pagination">

            <!-- 처음 -->
            <c:if test="${not historyPage.first}">
                <c:url var="historyFirstUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.number}"/>

                    <c:param name="historyPage"
                             value="0"/>
                </c:url>

                <a href="${historyFirstUrl}">
                    처음
                </a>
            </c:if>

            <!-- 이전 -->
            <c:if test="${not historyPage.first}">
                <c:url var="historyPreviousUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.number}"/>

                    <c:param name="historyPage"
                             value="${historyPage.number - 1}"/>
                </c:url>

                <a href="${historyPreviousUrl}">
                    이전
                </a>
            </c:if>

            <!-- 페이지 번호 -->
            <c:forEach var="pageNumber"
                       begin="0"
                       end="${historyPage.totalPages - 1}">

                <c:url var="historyPageUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.number}"/>

                    <c:param name="historyPage"
                             value="${pageNumber}"/>
                </c:url>

                <a href="${historyPageUrl}"
                   class="${pageNumber == historyPage.number
                            ? 'active' : ''}">

                    ${pageNumber + 1}
                </a>
            </c:forEach>

            <!-- 다음 -->
            <c:if test="${not historyPage.last}">
                <c:url var="historyNextUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.number}"/>

                    <c:param name="historyPage"
                             value="${historyPage.number + 1}"/>
                </c:url>

                <a href="${historyNextUrl}">
                    다음
                </a>
            </c:if>

            <!-- 마지막 -->
            <c:if test="${not historyPage.last}">
                <c:url var="historyLastUrl"
                       value="/materials">

                    <c:param name="keyword"
                             value="${keyword}"/>

                    <c:param name="materialPage"
                             value="${materialPage.number}"/>

                    <c:param name="historyPage"
                             value="${historyPage.totalPages - 1}"/>
                </c:url>

                <a href="${historyLastUrl}">
                    마지막
                </a>
            </c:if>
        </div>
    </c:if>
</div>