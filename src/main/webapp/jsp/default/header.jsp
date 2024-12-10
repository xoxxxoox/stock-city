<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html>

        <head>
            <link rel="icon" href="/image/sc.png">
            <title>Stock City</title>
            <link rel="stylesheet" href="/css/header.css">
            <script>
                // DOMContentLoaded 이벤트가 발생하면 실행되는 함수
                document.addEventListener("DOMContentLoaded", function () {
                    // navbar의 li 요소들을 모두 선택
                    var navbars = document.querySelectorAll('.navbar > li, .navbar > ul');
                    // 모든 subList 요소를 선택
                    var allSubLists = document.querySelectorAll('.subList');

                    // 각 navbar에 대해 이벤트 리스너 추가
                    navbars.forEach(function (navbar) {
                        // 마우스 오버 이벤트에 대한 처리
                        navbar.addEventListener('mouseover', function () {
                            allSubLists.forEach(function (subList) {
                                // subList의 높이를 가져와서 적용
                                var height = subList.scrollHeight;
                                subList.style.height = height + 'px';
                            });
                        });

                        // 마우스 아웃 이벤트에 대한 처리
                        navbar.addEventListener('mouseout', function () {
                            // 모든 subList를 감추도록 설정
                            allSubLists.forEach(function (subList) {
                                // subList의 높이를 0으로 설정하여 감춤
                                subList.style.height = '0';
                            });
                        });
                    });
                });
            </script>
        </head>

        <body>
            <!-- 네비게이션 바 및 하위 메뉴 구조 -->
            <ul class="navbar">
                <div class="exception-container">
                    <a href="/main/mainform" style="text-decoration: none; font-size: 0;">
                        <img src="/image/white_logo.png" style="margin-right: 250px; width: 80px; height: auto;">
                    </a>
                </div>
                <li class="liStyle">
                    <a href="#">상품관리</a>
                    <ul class="subList">
                        <c:choose>
                            <c:when test="${sessionScope.accountId eq 'root' }">
                                <li class="liStyle"><a href="/prod/prodInsert">상품등록</a></li>
                                <li class="liStyle"><a href="/prod/prodManage">등록상품관리</a></li>
                                <li class="liStyle"><a href="/prod/stockStatus">매장별 재고 현황</a></li>
                                <li class="liStyle"><a href="/prod/cateInsert">카테고리 등록</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="liStyle"><a href="/prod/prodManage">등록상품관리</a></li>
                                <li class="liStyle"><a href="/prod/stockStatus">매장별 재고 현황</a></li>
                                <li class="liStyle"><a href="/prod/cateInsert">카테고리 등록</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
                <li class="liStyle">
                    <a href="#">입출고등록</a>
                    <ul class="subList">
                        <c:choose>
                            <c:when test="${sessionScope.accountId == 'store'}">
                                <li class="liStyle"><a href="/storing">입고</a></li>
                                <li class="liStyle"><a href="/ioCheck">입출고내역조회</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                            </c:when>
                            <c:when test="${sessionScope.accountId == 'root'}">
                                <li class="liStyle"><a href="/unstoring">출고</a></li>
                                <li class="liStyle"><a href="/ioCheck">입출고내역조회</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                            </c:when>
                            <c:when test="${sessionScope.aId != null}">
                                <li class="liStyle"><a href="/storing">입고</a></li>
                                <li class="liStyle"><a href="/unstoring">출고</a></li>
                                <li class="liStyle"><a href="/ioCheck">입출고내역조회</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                            </c:when>
                        </c:choose>
                    </ul>
                </li>
                <li class="liStyle">
                    <a href="#">게시판</a>
                    <ul class="subList">
                        <c:choose>
                            <c:when test="${sessionScope.accountId eq 'root' }">
                                <li class="liStyle"><a href="/notice/noticecontent">공지사항</a></li>
                                <li class="liStyle"><a href="/notice/noticewrite">게시글 쓰기</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="liStyle"><a href="/notice/noticecontent">공지사항</a></li>
                                <li class="liStyle"><a href="/notice/noticewrite">게시글 쓰기</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
                <li class="liStyle">
                    <a href="#">RT</a>
                    <ul class="subList">
                        <c:choose>
                            <c:when test="${sessionScope.accountId eq 'root' }">
                                <li class="liStyle"><a href="/instruction/instructionform">지시 등록/조회</a></li>
                                <li class="liStyle"><a href="/rt/entryform">반입 조회</a></li>
                                <li class="liStyle"><a href="/rt/exportform">반출 등록/조회</a></li>
                                <li class="liStyle"><a href="#">&nbsp</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="liStyle"><a href="/instruction/instructionform">지시 등록/조회</a></li>
                                <li class="liStyle"><a href="/rt/entryform">반입 조회</a></li>
                                <li class="liStyle"><a href="/rt/exportform">반출 등록/조회</a></li>
                                <li class="liStyle"><a href="#">&nbsp<a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </li>
                <div class="exception-container">
                    <c:choose>
                        <c:when test="${sessionScope.accountId == 'root'}">
                            <a href="${context}/manageInfo"
                                style="margin-left: 180px; margin-right: 10px; font-size: 12px;">MANAGE</a>
                            <a href="/userInfo?id=${sessionScope.id}"
                                style="margin-right: 10px; font-size: 12px;">MYPAGE</a>
                            <a href="${context}/logout" style="font-size: 12px;">LOGOUT</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/userInfo?id=${sessionScope.id}"
                                style="margin-left: 240px; margin-right: 10px; font-size: 12px;">MYPAGE</a>
                            <a href="${context}/logout" style="font-size: 12px;">LOGOUT</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </ul>
        </body>

        </html>