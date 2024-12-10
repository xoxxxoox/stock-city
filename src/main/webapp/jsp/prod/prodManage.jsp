<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>상품 등록 조회</title>

      <link rel="stylesheet" href="/css/prodManage.css">

    </head>


    <body>
      <c:import url="/header" />
      <c:import url="/sider" />
      <div class="content-container class">

        <!-- <div class="left"> -->
        <h2 class="inventory-title">상품 조회</h2>
        <div class="center class">
          <div class="search-container class">
            <form id="searchForm" action="/prod/prodList" method="post">
              <table class="search-table">
                <tr>
                  <td>
                    <select name="cateGroup" id="cateGroup" class="searchOption">
                      <option value="">카테고리그룹</option> <!-- 초기값으로 null 추가 -->
                      <c:forEach var="cateGroup" items="${cateGroups}">
                        <option value="${cateGroup.cateGroup}">${cateGroup.cateGroup}</option>
                      </c:forEach>
                    </select>
                    <select name="cateCode" id="cateCode" class="searchOption">
                      <option value="">카테고리코드</option>
                      <c:forEach var="cateCode" items="${cateCodes}">
                        <option value="${cateCode.cateCode}">${cateCode.cateCode}</option>
                      </c:forEach>
                    </select>
                    <select name="colorCode" id="colorCode" class="searchOption">
                      <option value="">색상코드</option>
                      <c:forEach var="colorCode" items="${colorCodes}">
                        <option value="${colorCode.colorCode}">${colorCode.colorCode}</option>
                      </c:forEach>
                    </select>
                    <select class="searchOption" id="size" name="size">
                      <option value="">사이즈</option>
                      <option value="FREE">FREE</option>
                      <option value="S">S</option>
                      <option value="M">M</option>
                      <option value="L">L</option>
                      <option value="XL">XL</option>
                    </select>
                  </td>
                </tr>
                <tr>
                  <td>
                    <input type="text" id="prodNo" name="prodNo" placeholder="상품코드 입력를 입력하세요" value="${prodNo}"
                      class="txtProductNO">
                    <!-- <button type="button" onclick="searchProducts()">검색</button> -->
                    <input type="submit" class="search-button" value="검색">
                  </td>
                </tr>
              </table>
            </form>
          </div>
        </div>
        <div class="class">
          <table id="prodListTable" class="prodList-table">
            <tr>
              <td class="prodNo">상품코드</td>
              <td class="prodName">상품명</td>
              <td class="size">사이즈</td>
              <td class="colorCode">색상코드</td>
              <td class="quan">총수량</td>
            </tr>
            <c:choose>
              <c:when test="${not empty prods}">
                <c:forEach var="product" items="${prods}">
                  <tr>
                    <td class="prodNo" onclick="openModal('productModal',  '${product.prodNo}')">${product.prodNo}
                    </td>
                    <td class="prodName" onclick="openModal('productModal',  '${product.prodNo}')">${product.prodName}
                    </td>
                    <td class="size">${product.size}</td>
                    <td class="colorCode">${product.colorCode}</td>
                    <td class="quan">${product.quan}</td>
                  </tr>
                </c:forEach>
              </c:when>
              <c:otherwise>
                <!-- prod가 비어있는 경우 (검색 결과가 없는 경우) -->
                <tr class="no-data-row">
                  <td colspan="5">조회된 정보가 없습니다.</td>
                </tr>
              </c:otherwise>
            </c:choose>
          </table>
        </div>
      </div>


      <!-- 모달 창 -->
      <div id="productModal" class="modal">
        <div class="modal-content">
          <form id="modalForm">

          </form>
        </div>
      </div>
    </body>

    <script src="/js/prodManage.js"></script>

    </html>