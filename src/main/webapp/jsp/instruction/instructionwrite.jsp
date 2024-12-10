<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>R/T지시등록</title>

            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 20px;
                }

                h1 {
                    text-align: left;
                    font-size: 30px;
                }


                .filter-main {
                    display: flex;

                    justify-content: flex-start;
                    gap: 10px;
                    /* 사이 간격 조절 */
                    align-items: flex-start;
                    /* 시작 부분을 정렬하여 똑바로 정렬 */
                    flex-wrap: wrap;
                    /* 넘치면 넣어가게 해줌 */
                    background-color: #FFFFFF;
                    padding: 0px;

                }

                .filter-section {
                    display: flex;
                    flex-direction: column;
                    /* 기존의 가로 방향을 세로로 변경 */
                }



                .table-Processing {
                    background-color: #fff;
                    padding: 5px;
                    margin-left: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    width: 100%;
                    box-sizing: border-box;
                }

                .table-Processing input[type="radio"] {
                    margin-right: 5px;
                }

                .table-Processing label {
                    width: 50px;
                }

                .table-row {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    width: 100%;
                }

                .table-cell {
                    text-align: center;
                    flex: 1;
                    margin-left: 4px;
                    box-sizing: border-box;
                    margin-right: 5px;
                }

                .table-cell.table-Processing {
                    background-color: #fff;
                    border: 1px solid #ddd;
                    padding: 5px;
                    margin-left: 10px;
                }

                .Instruction-period,
                .Processing,
                .shop {
                    background-color: #cadae7;
                    padding: 5px;
                    display: block;
                    text-align: center;
                    width: 100%;
                    border: 1px solid #D3D3D3;
                    /* 각 항목에 테두리 추가 */
                }

                .button-box {
                    display: flex;
                    justify-content: flex-end;
                    padding: 10px;
                    margin-right: 0%;
                    /* 수정된 부분: %로 변경 */
                }

                .button-box button,
                .button-box input[type="button"] {
                    color: #999;
                    font-family: 'Monument', 'Noto Sans KR', sans-serif;
                    border: solid 1px #ddd;
                    font-size: 13px;
                    padding: 4px 12px 5px;
                    line-height: 1.4;
                    border-radius: 5px;
                    text-align: left;
                    margin-left: 11px;
                    background-color: #f5f5f5;
                }

                .table-container {

                    margin-top: 20px;

                }

                .instruction-list {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                    display: flex;
                    flex-direction: column;
                    width: 100%;
                    white-space: nowrap;
                    /* 텍스트 줄 바꿈 방지 */
                }

                .instruction-item header {
                    /* 기존 스타일 유지하면서 배경 색상과 테두리 추가 */
                    display: flex;
                    justify-content: space-between;
                    padding: 8px;
                    font-weight: bold;

                }

                .instruction-item {
                    padding: 8px;
                    margin-top: 5px;
                    background-color: #cadae7;
                    /* 배경 색상 변경 */
                    border: 1px solid #D3D3D3;
                    /* 테두리 추가 */
                    white-space: nowrap;
                    /* 텍스트 줄 바꿈 방지 */
                    text-align: center;
                }

                /* 추가된 스타일 */
                .instruction-item div {
                    /* 각 div 엘리먼트에 대한 스타일 */
                    flex: 1;
                    border-right: 1px solid #fff;
                    /* 각 엘리먼트 사이에 흰색 구분선 추가 */
                    padding: 0 8px;
                    /* 왼쪽 오른쪽으로 8px 간격 추가 */
                    box-sizing: border-box;
                    /* 패딩을 포함한 전체 크기 유지 */
                }

                .instruction-item div:last-child {
                    border-right: none;
                    /* 마지막 엘리먼트의 오른쪽 구분선 제거 */
                }

                .instruction-item.header td {
                    border-right: 1px solid #fff;
                    /* 각 셀에 오른쪽에 흰색 테두리 추가 */
                }




                /* 삭제 버튼 스타일 */
                .delete {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }



                .instruction-item2 {
                    background-color: #fff;
                    display: flex;
                    justify-content: space-between;
                    padding: 8px;
                    margin-top: 5px;
                    border: 1px solid #D3D3D3;
                }

                .instruction-item2 div {
                    /* 각 div 엘리먼트에 대한 스타일 */
                    flex: 1;
                    border-right: 1px solid #060000;
                    /* 각 엘리먼트 사이에 흰색 구분선 추가 */
                    padding: 0 8px;
                    /* 왼쪽 오른쪽으로 8px 간격 추가 */
                    box-sizing: border-box;
                    /* 패딩을 포함한 전체 크기 유지 */
                }

                .instruction-item2 div:last-child {
                    border-right: none;
                    /* 마지막 엘리먼트의 오른쪽 구분선 제거 */
                }



                .instruction-title {
                    font-weight: bold;
                    text-align: center;
                }

                .vi {
                    flex: 1;
                    text-align: center;
                    margin-top: 10px;
                    /* 아래에 간격 추가 */
                }

                .filter-section .table-Processing button#button {
                    color: #999;
                    font-family: 'Monument', 'Noto Sans KR', sans-serif;
                    border: solid 1px #ddd;
                    font-size: 13px;
                    padding: 4px 12px 5px;
                    line-height: 1.4;
                    border-radius: 5px;
                    text-align: left;
                    margin-left: 11px;
                    background-color: #f5f5f5;

                }


                .pr-bu {
                    color: #fff;
                    font-family: 'Monument', 'Noto Sans KR', sans-serif;
                    border: solid 1px#3498db;
                    font-size: 13px;
                    padding: 4px 12px 5px;
                    line-height: 1.4;
                    border-radius: 5px;
                    text-align: left;
                    background-color: #3498db;

                }



                .instruction-item2 {
                    background-color: #fff;
                }


                .search-container {
                    width: 233%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    margin: 0 auto;
                    margin-bottom: 20px;
                    border: 2px solid #2895F4;
                    border-radius: 8px;
                    padding: 20px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

                }

                .instruction-item td:nth-child(2),
                .instruction-item td:nth-child(3),
                .instruction-item td:nth-child(4),
                .instruction-item td:nth-child(5),
                .instruction-item td:nth-child(6) {
                    max-width: 175px;
                    overflow: auto;
                }
            </style>
        </head>

        <body>
            <c:import url="/header" />
            <c:import url="/sider" />
            <div class="content-container class">
                <!--버튼-->

                <h1>R/T지시요청</h1>
                <div class="button-box">
                    <button>조회</button>
                    <button type="button" onclick="location.href='/instruction/instructionform'">목록</button>
                    <button class="cancel" type="button"
                        onclick="window.location.href='/instruction/instructionform'">취소</button>
                    <input type="button" value="마감처리" onclick="submitForm()" class="button">
                </div>



                <!--filter-main 중간표-->

                <div class="filter-main">
                    <div class="filter-section">
                        <div class="search-container class">
                            <form action="/searchInst" method="post">
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



                <!-- instruction-list 하단 표-->

                <div class="table-container">
                    <form id="unstoringForm" action="/instruction/instructionwriteProc" method="post">
                        <div class="instruction-list">
                            <table class="instruction-item header">

                                <tr>
                                    <td><input type="checkbox" id="selectAllCheckbox"
                                            onclick="toggleCheckboxes(this)" />
                                    </td>
                                    <td>상품코드</td>
                                    <td>상품명</td>
                                    <td>사이즈</td>
                                    <td>색상코드</td>
                                    <td>지시 수량</td>
                                    <td>지시 매장 재고</td>

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
                                                <td>
                                                    <input type="number" style="width: 100px;" name="respQuan"
                                                        placeholder="지시 수량">
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
                                        <tr class="instruction-item" style="background-color: #fff;">
                                            <td class="instruction-title" style="color: #000;" colspan="7">조회된 정보가 없습니다.
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- storeName이 null인 경우 -->
                                        <tr class="no-data-row-storing">
                                            <td colspan="7" style="color: red; font-weight: bold;">${msg}</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </table>
                        </div>

                    </form>
                </div>
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


        </body>

        </html>