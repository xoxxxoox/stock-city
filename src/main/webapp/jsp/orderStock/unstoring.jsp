<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>출고</title>
                <link rel="stylesheet" href="/css/prodManage.css">
            </head>

            <body>
                <c:import url="/header" />
                <c:import url="/sider" />
                <div class="content-container class">
                    <h2 class="inventory-title">상품 조회</h2>
                    <div class="center class">
                        <div class="search-container class">
                            <form action="/searchUnstoring" method="post">
                                <table class="search-table">
                                    <tr>
                                        <td>
                                            <select name="cateGroup" class="searchOption">
                                                <option value="">카테고리그룹</option> <!-- 초기값으로 null 추가 -->
                                                <c:forEach var="cateGroup" items="${cateGroups}">
                                                    <option value="${cateGroup.cateGroup}">${cateGroup.cateGroup}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <select name="cateCode" class="searchOption">
                                                <option value="">카테고리코드</option>
                                                <c:forEach var="cateCode" items="${cateCodes}">
                                                    <option value="${cateCode.cateCode}">${cateCode.cateCode}</option>
                                                </c:forEach>
                                            </select>
                                            <select name="colorCode" class="searchOption">
                                                <option value="">색상코드</option>
                                                <c:forEach var="colorCode" items="${colorCodes}">
                                                    <option value="${colorCode.colorCode}">${colorCode.colorCode}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <select class="searchOption" name="size">
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
                                            <input type="text" name="prodNo" placeholder="상품코드 입력를 입력하세요"
                                                value="${prodNo}" style="width: 413px; height: 26px; margin-top: 5px;">
                                            <input type="submit" value="검색"
                                                style="padding: 4px 5px; border: none; background-color: #2895F4; color: white; border-radius: 4px; cursor: pointer;">
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="content-container">
                    <h2 class="inventory-title">상품 출고</h2>
                    <form id="unstoringForm" action="/unstoringProc" method="post">
                        <div class="class">
                            <table class="prodList-table">
                                <tr>
                                    <td><input type="checkbox" id="selectAllCheckbox"
                                            onclick="toggleCheckboxes(this)" /></td>
                                    <td>상품코드</td>
                                    <td>상품명</td>
                                    <td>사이즈</td>
                                    <td>색상코드</td>
                                    <td>총수량</td>
                                    <td>출고 수량</td>
                                    <td>수령 매장</td>
                                </tr>
                                <c:choose>
                                    <c:when test="${not empty prods}">
                                        <c:forEach var="product" items="${prods}" varStatus="loop">
                                            <tr>
                                                <td><input type="checkbox" name="selectedProducts"
                                                        value="${product.prodNo}" /></td>
                                                <td>${product.prodNo}</td>
                                                <td>${product.prodName}</td>
                                                <td>${product.size}</td>
                                                <td>${product.colorCode}</td>
                                                <td>${product.quan}</td>
                                                <td>
                                                    <input type="number" style="width: 100px;" name="respQuan"
                                                        required min="1" placeholder="출고 수량">
                                                </td>
                                                <td>
                                                    <select name="storeName"> <!-- 서버로 전송하기 위해 필요 -->
                                                        <c:choose>
                                                            <c:when test="${empty storeNames}">
                                                                <option value="noStoreName">등록된 매장이 없습니다.</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="">매장 선택</option>
                                                                <c:forEach var="storeName" items="${storeNames}">
                                                                    <option value="${storeName}">${storeName}</option>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </select>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:when test="${empty prods and empty msg}">
                                        <!-- prod가 비어있는 경우 (검색 결과가 없는 경우) -->
                                        <tr class="no-data-row-storing">
                                            <td colspan="8">조회된 정보가 없습니다.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- storeName이 null인 경우 -->
                                        <tr class="no-data-row-storing">
                                            <td colspan="8" style="color: red; font-weight: bold;">${msg}</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                        </div>
                        <div class="button-container">
                            <input type="button" value="출고" onclick="submitForm()">
                            <button class="cancel" type="button"
                                onclick="window.location.href='/main/mainform'">취소</button>
                        </div>
                    </form>
                </div>
            </body>

            <script>
                function submitForm() {
                    var form = document.getElementById("unstoringForm");
                    var checkboxes = document.getElementsByName("selectedProducts");

                    // 폼 데이터를 저장할 새로운 FormData 객체 생성
                    var formData = new FormData(form);

                    // // 선택된 상품들의 정보를 저장할 배열
                    // var selectedProducts = [];

                    // 체크박스를 반복하며 선택된 것들을 FormData에 추가
                    for (var i = 0; i < checkboxes.length; i++) {
                        if (checkboxes[i].checked) {
                            var prodNo = checkboxes[i].value;
                            var respQuanInput = document.querySelector('input[name="respQuan"][value="' + prodNo + '"]');
                            var selectedStoreInput = document.querySelector('select[name="storeName"][value="' + prodNo + '"]');

                            if (respQuanInput && selectedStoreInput) {
                                var respQuan = respQuanInput.value;
                                var selectedStore = selectedStoreInput.value;

                                // 요청 수량이 null이 아닌 경우에만 FormData에 추가
                                if (respQuan !== null && respQuan !== "" && selectedStore !== null && selectedStore !== "") {
                                    formData.append("selectedProducts", prodNo + ":" + respQuan + ":" + selectedStore);
                                }
                            }
                        }
                    }

                    // 최소 한 개 이상의 상품이 선택되었는지 확인
                    if (formData.getAll("selectedProducts").length === 0) {
                        alert("하나 이상의 상품을 선택해주세요.");
                        return;
                    }

                    // FormData를 폼 데이터로 설정
                    form.formData = formData;

                    // 폼 제출
                    form.submit();
                }

                // 모든 체크박스 선택/해제하는 함수
                function toggleCheckboxes(checkbox) {
                    var checkboxes = document.getElementsByName("selectedProducts");

                    for (var i = 0; i < checkboxes.length; i++) {
                        checkboxes[i].checked = checkbox.checked;
                    }
                }
            </script>

            </html>