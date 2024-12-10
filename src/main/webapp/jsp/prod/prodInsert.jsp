<%@ page language="java" contentType="text/html; charset=UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8">

      <title>상품 개별 등록</title>

      <link rel="stylesheet" href="/css/prodInsert.css">

      <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    </head>

    <body>
      <c:import url="/header" />
      <c:import url="/sider" />
      <div class="content-container">
        <h2 class="inventory-title">상품 등록</h2>
        <form action="prodInsertProc" method="post">
          <table class="white-bg">
            <tr>
              <th>상품명</th>
              <td colspan="2"><input type="text" name="prodName" value="${prodName}" placeholder="공백 제외 한글, 영문"
                  required></td>
            </tr>
            <tr>
              <th>브랜드 코드</th>
              <td class="baranCode">
                <div class="container">
                  <select name="brandCode" id="brandCode" required>
                    <option value="null"></option> <!-- 초기값으로 null 추가 -->
                    <c:choose>
                      <c:when test="${empty brandCodes}">
                        <option value="nobrandCode">등록된 브랜드코드가 없습니다</option>
                      </c:when>
                      <c:otherwise>
                        <c:forEach var="brandCode" items="${brandCodes}">
                          <option value="${brandCode.brandCode}">${brandCode.brandCode}</option>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>
                  </select>
                  <button class="insert-button" type="button" onclick="openModal('brandModal')">브랜드코드
                    등록</button>
            <tr>
              <th>카테고리</th>
              <td>
                <div class="container">
                  <select name="cateGroup" id="cateGroup" required>
                    <option value="null">카테고리 그룹</option> <!-- 초기값으로 null 추가 -->
                    <c:choose>
                      <c:when test="${empty cateGroups}">
                        <option value="nocateGroup">등록된 카테고리 그룹이 없습니다</option>
                      </c:when>
                      <c:otherwise>
                        <c:forEach var="cateGroup" items="${cateGroups}">
                          <option value="${cateGroup.cateGroup}">${cateGroup.cateGroup}</option>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>
                  </select>
                  <button class="insert-button" type="button" onclick="openModal('cateModal')">카테고리
                    등록</button>
                </div>

                <div class="container">
                  <select name="cateCode" id="cateCode" required>
                    <option value="null">카테고리 코드</option> <!-- 초기값으로 null 추가 -->
                    <c:choose>
                      <c:when test="${empty cateCodes}">
                        <option value="nocateCode">등록된 카테고리 코드가 없습니다</option>
                      </c:when>
                      <c:otherwise>
                        <c:forEach var="cateCode" items="${cateCodes}">
                          <option value="${cateCode.cateCode}">${cateCode.cateCode}</option>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>
                  </select>
                </div>
              </td>
            </tr>
            <tr>
              <th>색상</th>
              <td class="colorCode" colspan="2">
                <div class="container">
                  <select name="colorCode" id="colorCode" required>
                    <option value="null"></option> <!-- 초기값으로 null 추가 -->
                    <c:choose>
                      <c:when test="${empty colorCodes}">
                        <option value="nocolor">등록된 색상코드가 없습니다</option>
                      </c:when>
                      <c:otherwise>
                        <c:forEach var="colorCode" items="${colorCodes}">
                          <option value="${colorCode.colorCode}">${colorCode.colorCode}</option>
                        </c:forEach>
                      </c:otherwise>
                    </c:choose>
                  </select>
                  <button class="insert-button" type="button" onclick="openModal(`colorModal`)">색상코드
                    등록</button>
                </div>
              </td>
            </tr>
            <tr>
              <th>사이즈</th>
              <td><select id="size" name="size" required>
                  <option value="null"></option> <!-- 초기값으로 null 추가 -->
                  <option value="FREE">FREE</option>
                  <option value="S">S</option>
                  <option value="M">M</option>
                  <option value="L">L</option>
                  <option value="XL">XL</option>
              </td>
            </tr>
            <tr>
              <th>입고가격</th>
              <td><input type="number" name="incomePrice" value="${incomePrice}" placeholder="숫자만 입력" required></td>
            </tr>
            <tr>
              <th>판매가격</th>
              <td><input type="number" name="sellPrice" value="${sellPrice}" placeholder="숫자만 입력" required></td>
            </tr>
            <tr>
              <th>입고수량</th>
              <td><input type="number" name="quan" value="${quan}" placeholder="숫자만 입력" required></td>
            </tr>
            <tr>
              <th>상세설명</th>
              <td><textarea name="prodCon" value="${prodCon}" rows="10" cols="100" required></textarea>
              </td>
            </tr>
          </table>
          <div class="button-container">
            <input type="submit" value="등록">
            <button class="cancel" type="button" onclick="window.location.href='/'">취소</button>
          </div>
        </form>
      </div>

      <!-- 브랜드코드  모달 창 -->
      <div id="brandModal" class="modal">
        <div class="modal-content">
          <div class="form-container">
            <h2 style="text-align: center;">브랜드코드 등록</h2><br>
            <form id="modalForm" action="brandInsert" method="post">
              <!-- 브랜드 코드 입력 -->
              <label for="addBrandCode"></label>
              <input type="text" id="addBrandCode" name="brandCode" value="${brandCode}" placeholder="브랜드코드명을 입력하세요."
                required>
              <!-- 브랜드 설명 입력 -->
              <label for="brandDescription"></label>
              <textarea id="brandDescription" name="brandDescription" rows="4" value="${brandDescription}"
                placeholder="브랜드에 대한 설명을 입력하세요"></textarea>
              <div class="button-container">
                <input type="submit" class="form-container button" value="등록"></input>
                <button type="button" class="form-container button" onclick="closeModal(`brandModal`)">취소</button>
              </div>
              <!-- 등록 버튼 -->
            </form>

          </div>
        </div>
      </div>


      <!-- 카테고리  모달 창 -->
      <div id="cateModal" class="modal">
        <div class="modal-content">
          <div class="form-container">
            <h2 style="text-align: center;">카테고리 등록</h2><br>
            <form id="modalForm" action="cateInsert" method="post">
              <!-- 카테고리 그룹 입력 -->
              <label for="addCateGroup"></label>
              <input type="text" id="addCateGroup" name="cateGroup" value="${cateGroup}" placeholder="카테고리그룹명을 입력하세요."
                required>
              <!-- 카테고리 코드 입력 -->
              <label for="addCateCode"></label>
              <input type="text" id="addCateCode" name="cateCode" value="${cateCode}" placeholder="카테고리코드명을 입력하세요."
                required>
              <!-- 카테고리 네임 입력 -->
              <label for="addCateName"></label>
              <input type="text" id="addCateName" name="cateName" value="${cateName}" placeholder="카테고리명을 입력하세요."
                required>
              <input type="submit" class="form-container button" value="등록"></input>
              <button type="button" class="form-container button" onclick="closeModal(`cateModal`)">취소</button>
          </div>
          <!-- 등록 버튼 -->
          </form>

        </div>
      </div>
      </div>


      <!-- 컬러코드 모달 창 -->
      <div id="colorModal" class="modal">
        <div class="modal-content">
          <div class="form-container">
            <h2 style="text-align: center;">컬러코드 등록</h2><br>
            <form id="modalForm" action="colorInsert" method="post">
              <!-- 컬러 코드 입력 -->
              <label for="addColorCode"></label>
              <input type="text" id="addColorCode" name="ColorCode" value="${colorCode}" placeholder="컬러코드를 입력하세요."
                required>
              <label for="addColorName"></label>
              <input type="text" id="addColorName" name="ColorName" value="${colorName}" placeholder="컬러명을 입력하세요."
                required>
              <input type="submit" class="form-container button" value="등록"></input>
              <button type="button" class="form-container button" onclick="closeModal(`colorModal`)">취소</button>
          </div>
          <!-- 등록 버튼 -->
          </form>
        </div>
      </div>
      </div>

      <script src="/js/prodInsert.js"></script>

    </body>

    </html>