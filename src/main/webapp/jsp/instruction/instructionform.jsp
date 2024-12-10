<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>R/T지시 등록조회 페이지</title>

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
                    flex-direction: row;
                    justify-content: flex-start;
                    gap: 10px;
                    /*사이 간격 조절*/
                    align-items: center;
                    flex-wrap: wrap;
                    /* 넘치면 넣어가게 해줌*/
                    background-color: #FFFFFF;
                    padding: 0px;
                    border: 1px solid #ddd;
                }

                .filter-section {
                    display: flex;
                }

                .table-row {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    width: 100%;
                }

                .table-cell {
                    text-align: left;
                    flex: 1;
                    margin-left: 4px;
                    box-sizing: border-box;
                    margin-right: 5px;
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

                .button-box button {
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

                .table-container2 {

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
                    /* 기존 스타일 유지하면서 배경 색상과 테두리 추가 */
                    display: flex;
                    justify-content: space-between;
                    padding: 8px;
                    margin-top: 5px;
                    background-color: #cadae7;
                    /* 배경 색상 변경 */
                    border: 1px solid #D3D3D3;
                    /* 테두리 추가 */
                    white-space: nowrap;
                    /* 텍스트 줄 바꿈 방지 */
                }

                .instruction-item>div {
                    /* 각 div 엘리먼트에 대한 스타일 */
                    flex: 1;
                    border-right: 1px solid #fff;
                    /* 각 엘리먼트 사이에 흰색 구분선 추가 */
                    padding: 0 8px;
                    /* 왼쪽 오른쪽으로 8px 간격 추가 */
                    box-sizing: border-box;
                    /* 패딩을 포함한 전체 크기 유지 */
                }

                .instruction-item>div:last-child {
                    border-right: none;
                    /* 마지막 엘리먼트의 오른쪽 구분선 제거 */
                }

                .instruction-list2 {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                    display: flex;
                    flex-direction: column;
                    width: 100%;
                    white-space: nowrap;
                    /* 텍스트 줄 바꿈 방지 */
                }

                .instruction-item2 header {
                    /* 기존 스타일 유지하면서 배경 색상과 테두리 추가 */
                    display: flex;
                    justify-content: space-between;
                    padding: 8px;
                    font-weight: bold;

                }

                .instruction-item2 {
                    /* 기존 스타일 유지하면서 배경 색상과 테두리 추가 */
                    display: flex;
                    justify-content: space-between;
                    padding: 8px;
                    margin-top: 5px;
                    background-color: #cadae7;
                    /* 배경 색상 변경 */
                    border: 1px solid #D3D3D3;
                    /* 테두리 추가 */
                    white-space: nowrap;
                    /* 텍스트 줄 바꿈 방지 */
                }

                /* 추가된 스타일 */
                .instruction-item2 div {
                    /* 각 div 엘리먼트에 대한 스타일 */
                    flex: 1;
                    border-right: 1px solid #fff;
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
                    flex: 1;
                    font-weight: bold;
                    text-align: center;
                    /* 텍스트를 가운데 정렬 */
                    color: #fff;
                    /* 흰색으로 변경 */
                }

                .instruction-title2 {
                    flex: 1;
                    font-weight: bold;
                    text-align: center;
                    /* 텍스트를 가운데 정렬 */
                    color: #fff;
                    /* 흰색으로 변경 */
                }


                .vi {
                    flex: 1;
                    text-align: center;
                    margin-top: 10px;
                    /* 아래에 간격 추가 */
                }

                .confirmed {
                    color: green;
                    font-weight: bold;
                }

                .scrollable {
                    overflow-x: auto;
                }

                .prodNo {
                    max-width: 175px;
                    overflow: auto;
                }
            </style>
        </head>

        <body>
            <c:import url="/header" />
            <c:import url="/sider" />
            <div class="content-container class">


                <h1>R/T지시요청/조회</h1>
                <div class="button-box">
                    <button onclick="getInstructionData()">조회</button>
                    <button onclick="location.href='/instruction/instructionwrite'">등록</button>
                </div>


                <div class="filter-main">
                    <div class="filter-section">
                        <label class="Instruction-period">지시기간</label>
                        <div class="table-row">
                            <!-- <div class="date-separator">~</div> -->
                            <div class="table-cell">
                                <input type="date" id="regDate" name="regDate" onchange="handleDateChange()">

                            </div>
                        </div>
                    </div>

                    <div class="filter-section">
                        <label class="Processing">처리구분</label>
                        <div class="table-row">
                            <div class="table-Processing">
                                <input type="radio" name="status" value="미처리">
                                <label for="미확정">미확정</label>
                            </div>
                            <div class="table-Processing">
                                <input type="radio" name="status" value="처리">
                                <label for="확정">확정</label>
                            </div>
                            <div class="table-Processing">
                                <input type="radio" name="status" value="불이행">
                                <label for="불이행">불이행</label>
                            </div>
                        </div>
                    </div>

                    <div class="filter-section">
                        <label class="shop">매장</label>
                        <div class="table-row">
                            <div class="table-cell">
                                <select name="shop" id="shopSelect">
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!--지시 요청 조회표-->

                <div class="title-main">
                    <label>
                        <지시요청조회>
                    </label>
                </div>

                <div class="table-container">
                    <ul class="instruction-list">
                        <li class="instruction-item header">
                            <div class="prodNo">품번</div>
                            <div class="prodName">품명</div>
                            <div class="colorCode">색상</div>
                            <div class="size">사이즈</div>
                            <div class="storeName">지시매장</div>
                            <div class="quan">지시수량</div>
                            <div class="regDate">RT 지시일</div>
                            <!-- <div class="processing" id="processingStatus">처리구분</div> -->
                        </li>
                        <c:choose>
                            <c:when test="${not empty prods}">
                                <c:forEach var="product" items="${prods}">
                                    <li class="instruction-item"
                                        style="background-color: #fff; border-bottom: 1px solid black;">
                                        <div class="prodNo">${product.prodNo}</div>
                                        <div class="prodName">${product.prodName}</div>
                                        <div class="colorCode">${product.colorCode}</div>
                                        <div class="size">${product.size}</div>
                                        <div class="storeName">${product.respStore}</div>
                                        <div class="quan">${product.respQuan}</div>
                                        <div class="regDate" style="border-right: none;">${product.respDate}</div>
                                        <!-- <div class="confirmation">${product.confirmation}</div> -->
                                        <!-- <div class="processing">${product.processing}</div> -->
                                    </li>
                                </c:forEach>
                                <!-- <li>
            <div class="vi" colspan="13">${result}</div>
        </li> -->
                            </c:when>
                            <c:otherwise>
                                <li class="instruction-item" style="background-color: #fff;">
                                    <div class="instruction-title" style="color: #000;" colspan="13">조회된 정보가 없습니다.</div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>


                <!--타매장 요청-->

                <div class="title-bottem">
                    <label>
                        <타 매장 지시요청>
                    </label>
                </div>


                <div class="table-container2">
                    <ul class="instruction-list2">
                        <li class="instruction-item2 header">
                            <div class="storeName">요청매장</div>
                            <div class="prodNo">품번</div>
                            <div class="prodName">품명</div>
                            <div class="colorCode">색상</div>
                            <div class="size">사이즈</div>
                            <div class="quan">요청 수량</div>
                            <div class="regDate">RT 요청일</div>
                            <!-- <div class="confirmation">확정</div> -->
                        </li>
                        <c:choose>
                            <c:when test="${empty prods2}">
                                <li class="instruction-item2" style="background-color: #fff;">
                                    <div class="instruction-title2" style="color: #000;" colspan="13">조회된 정보가 없습니다.
                                    </div>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="product" items="${prods2}">
                                    <c:if test="${product.storeName eq sessionScope.storeName}">
                                        <li class="instruction-item2">
                                            <div class="storeName">${product.storeName}</div>
                                            <div class="prodNo">${product.prodNo}</div>
                                            <div class="prodName">${product.prodName}</div>
                                            <div class="colorCode">${product.colorCode}</div>
                                            <div class="size">${product.size}</div>
                                            <div class="quan">${product.quan}</div>
                                            <div class="regDate">${product.regDate}</div>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <li>
                                    <div class="vi" colspan="13">${result}</div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>


            <script>
                function handleDateChange() {
                    // 변경된 날짜 값 가져오기
                    const selectedDate = document.getElementById('regDate').value;

                    // 변경된 날짜 값 콘솔에 출력 (예시)
                    console.log('Selected date changed to:', selectedDate);

                    // 이후 원하는 작업 수행
                    // 예: 가져온 날짜 값을 서버로 전달하거나 다른 처리 수행
                }
                function addDateRange() {
                    const regDate = document.getElementById('regDate').value;


                    if (regDate) {
                        const newRow = document.createElement('div');
                        newRow.className = 'table-row';
                        const dateCell = document.createElement('div');
                        dateCell.className = 'table-cell';
                        const typeCell = document.createElement('div');
                        typeCell.className = 'table-cell';

                        dateCell.textContent = regDate;

                        const radioBtn1 = createRadioButton('미확정');
                        const radioBtn2 = createRadioButton('확정');
                        const radioBtn3 = createRadioButton('불이행');

                        typeCell.appendChild(radioBtn1);
                        typeCell.appendChild(radioBtn2);
                        typeCell.appendChild(radioBtn3);

                        newRow.appendChild(dateCell);
                        newRow.appendChild(typeCell);

                        document.getElementById('dataBody').appendChild(newRow);
                    } else {
                        console.log('Please select a date.');
                    }
                }

                // -지시시간
                document.addEventListener('DOMContentLoaded', function () {
                    const searchButton = document.querySelector('.button-box button:first-of-type');

                    searchButton.addEventListener('click', function () {
                        const startDate = document.getElementById('startDate').value;

                        // 시작 날짜를 컨트롤러로 전달
                        window.location.href = `/instruction/instructionform?startDate=${startDate}`;
                    });
                });


                function getInstructionData() {
                    // 선택한 날짜 가져오기
                    const selectedDate = document.getElementById('regDate').value;
                    console.log('Selected date changed to:', selectedDate);
                    // 만약 선택한 날짜가 존재하면
                    if (selectedDate) {
                        // 지시 날짜를 파라미터로하여 새로운 URL 생성
                        const url = '/instruction/instructionformSelect?regDate=' + selectedDate;

                        // 생성된 URL로 이동
                        window.location.href = url;
                    } else {
                        // 선택한 날짜가 없는 경우에 대한 처리
                        console.log('Please select a date.');
                    }
                }


                function createRadioButton(label) {
                    const radioBtn = document.createElement('input');
                    radioBtn.type = 'radio';
                    radioBtn.name = 'status';
                    radioBtn.value = label;

                    const labelElement = document.createElement('label');
                    labelElement.textContent = label;

                    const wrapper = document.createElement('div');
                    wrapper.appendChild(radioBtn);
                    wrapper.appendChild(labelElement);

                    return wrapper;
                }
                document.addEventListener('DOMContentLoaded', function () { //매장 스크롤바
                    const shopSelect = document.getElementById('shopSelect');

                    shopSelect.addEventListener('change', function () {
                        const selectedShop = shopSelect.value;
                        console.log('Selected Shop:', selectedShop);
                        // 여기서 선택된 매장 값을 서버로 전송하도록 구현할 수 있습니다.
                    });
                });
                // -확정 버튼 기능
                document.addEventListener('DOMContentLoaded', function () {
                    const confirmationButtons = document.querySelectorAll('.confirmation-btn');

                    confirmationButtons.forEach(function (button) {
                        button.addEventListener('click', function () {
                            const listItem = button.closest('.instruction-item');
                            const confirmationCell = listItem.querySelector('.confirmation');

                            // 현재 체크 상태에 따라 토글
                            if (confirmationCell.classList.contains('confirmed')) {
                                confirmationCell.classList.remove('confirmed');
                            } else {
                                confirmationCell.classList.add('confirmed');
                            }
                        });
                    });
                });
                // -처리구분 기능
                document.addEventListener('DOMContentLoaded', function () {
                    const confirmationButtons = document.querySelectorAll('.confirmation-btn');

                    confirmationButtons.forEach(function (button) {
                        button.addEventListener('click', function () {
                            const listItem = button.closest('.instruction-item');
                            const confirmationCell = listItem.querySelector('.confirmation');
                            const processingStatus = listItem.querySelector('#processingStatus');

                            // 현재 체크 상태에 따라 토글
                            if (confirmationCell.classList.contains('confirmed')) {
                                confirmationCell.classList.remove('confirmed');
                                processingStatus.textContent = '미확정';
                            } else {
                                confirmationCell.classList.add('confirmed');
                                processingStatus.textContent = '확정';
                            }
                        });
                    });
                });

                // - 스크롤
                // 모든 품번 요소를 선택합니다.
                const prodNoElements = document.querySelectorAll('.prodNo');

                // 각 품번 요소에 대해 처리합니다.
                prodNoElements.forEach(prodNoElement => {
                    // 텍스트 내용을 가져옵니다.
                    const textContent = prodNoElement.textContent.trim();

                    // 텍스트 내용의 길이가 7글자 이상인 경우
                    if (textContent.length >= 7) {
                        // 'scrollable' 클래스를 요소에 추가합니다.
                        prodNoElement.classList.add('scrollable');
                    }
                });


            </script>

        </body>

        </html>