<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="tiles"
           uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <tiles:getAsString name="title"/>
    </title>

    <!-- 모든 화면에서 공통으로 사용하는 CSS -->

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/common.css">

    <!-- 페이지별 CSS -->
    <tiles:insertAttribute name="css"
                           ignore="true"/>
</head>

<body>

<div class="layout">

    <!-- 공통 사이드바 -->
    <tiles:insertAttribute name="sidebar"/>

    <!-- 화면 오른쪽 영역 -->
    <main class="main">

        <!-- 공통 상단 헤더 -->
        <tiles:insertAttribute name="header"/>

        <!-- 페이지별 본문 -->
        <tiles:insertAttribute name="body"/>

    </main>

</div>

<!-- 페이지별 JavaScript -->
<tiles:insertAttribute name="script"
                       ignore="true"/>

</body>
</html>