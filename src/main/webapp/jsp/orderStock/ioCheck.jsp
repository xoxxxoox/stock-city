<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>입고</title>
                <link rel="stylesheet" href="/css/prodManage.css">
            </head>

            <body>
                <c:import url="/header" />
                <c:import url="/sider" />
                <div class="content-container">
                    <h2 class="inventory-title">상품 입출고 조회</h2>

                    <!-- 라디오 버튼 폼 추가 -->
                    <form action="/ioCheck" method="get" style="text-align: right; margin-right: 2%;">
                        <label>
                            <a href="/csv/down" style="text-decoration: none; font-size: 0;">
                                <img src="/image/downloadBtn.png"
                                    style="margin: 0 20px -10px 0; width: 100px; height: auto;">
                            </a>
                        </label>
                        <label>
                            <input type="radio" name="radioButton" value="selectRequest"
                                ${fn:startsWith(param.radioButton, 'selectRequest' ) ? 'checked' : '' }> 입고
                        </label>
                        <label>
                            <input type="radio" name="radioButton" value="selectResponse"
                                ${fn:startsWith(param.radioButton, 'selectResponse' ) ? 'checked' : '' }> 출고
                        </label>
                        <input type="submit" value="조회"
                            style="background-color: #2895F4; color: white; border: none; border-radius: 6px; width: 4%; font-size: 16px; cursor: pointer;">
                    </form>

                    <div class="class">
                        <table class="prodList-table">
                            <tr>
                                <td>매장명</td>
                                <td>상품코드</td>
                                <td>수량</td>
                                <td>결재일</td>
                                <td>입출고 상태</td>
                            </tr>
                            <c:choose>
                                <c:when test="${not empty stocks and param.radioButton != null}">
                                    <c:forEach var="stock" items="${stocks}">
                                        <tr>
                                            <c:choose>
                                                <c:when
                                                    test="${(stock.orderStatus == '요청 승인' or stock.orderStatus == '요청 중' or stock.orderStatus == '요청 거절') and radioButton == 'selectRequest'}">
                                                    <td>${stock.reqStore}</td>
                                                    <td>${stock.prodNo}</td>
                                                    <td>${stock.reqQuan}</td>
                                                    <td>${stock.reqDate}</td>
                                                    <c:choose>
                                                        <c:when
                                                            test="${stock.orderStatus == '요청 중' and sessionScope.accountId == 'root'}">
                                                            <td>
                                                                <a href="/storingApprove?reqStore=${stock.reqStore}&prodNo=${stock.prodNo}&reqDate=${stock.reqDate}"
                                                                    style="text-decoration: none; margin: 0 10px 0 -10px;"><img src="/image/accept.png" style="height: 40px;"></a>
                                                                <a href="/storingDenied?reqStore=${stock.reqStore}&prodNo=${stock.prodNo}&reqDate=${stock.reqDate}"
                                                                    style="text-decoration: none; margin-right: -10px;"><img src="/image/reject.png" style="height: 43px;"></a>
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td>${stock.orderStatus}</td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:when
                                                    test="${stock.orderStatus == '출고' and radioButton == 'selectResponse'}">
                                                    <td>${stock.respStore}</td>
                                                    <td>${stock.prodNo}</td>
                                                    <td>${stock.respQuan}</td>
                                                    <td>${stock.respDate}</td>
                                                    <td>${stock.orderStatus}</td>
                                                </c:when>
                                            </c:choose>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="no-data-row-storing">
                                        <td colspan="5">조회된 정보가 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                </div>
            </body>

            </html>