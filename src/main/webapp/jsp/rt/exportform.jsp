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

                .instruction-title {
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
            </style>
        </head>

        <body>
            <c:import url="/header" />
            <c:import url="/sider" />
            <div class="content-container class">

                <h1>R/T반출등록/조회</h1>
                <div class="button-box">
                    <button>조회</button>
                    <button onclick="location.href='/rt/exportwrite'">등록</button>
                </div>

                <div class="filter-main">
                    <div class="filter-section">
                        <label class="Instruction-period">지시기간</label>
                        <div class="table-row">
                            <div class="table-cell">
                                <input type="date" id="startDate" name="startDate">
                            </div>
                            <div class="date-separator">~</div>
                            <div class="table-cell">
                                <input type="date" id="endDate" name="endDate">
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

                <!--반출 조회/등록표-->
                <div class="title-main">
                    <label>
                        <반출 등록 조회>
                    </label>
                </div>

                <div class="table-container">
                    <ul class="instruction-list">
                        <li class="instruction-item header">
                            <div class="no">NO.</div>
                            <div class="store-re">지시매장</div>
                            <div class="prodNo">품번</div>
                            <div class="prodName">품명</div>
                            <div class="colorCode">색상</div>
                            <div class="size">사이즈</div>
                            <div class="re_quan">지시수량</div>
                            <div class="re_date">RT 지시일</div>
                            <div class="outDate">반출일</div>
                            <div class="processing" id="processingStatus">처리구분</div>
                        </li>
                        <c:choose>
                            <c:when test="${empty instructions}">
                                <li class="instruction-item" style="background-color: #fff;">
                                    <div class="instruction-title" style="color: #000;" colspan="13">조회된 정보가 없습니다.</div>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="instruction" items="${instructionDTOLists}">

                                    <li class="instruction-item">
                                        <div class="no">${instructio.no}</div>
                                        <div class="store-re">${instruction.store-re}</div>
                                        <div class="prodNo">${instruction.prodNo}</div>
                                        <div class="prodName">{$instruction.prodName}</div>
                                        <div class="colorCode">${instruction.colorCode}</div>
                                        <div class="size">${instruction.size}</div>
                                        <div class="re_quan">${instruction.re_quan}</div>
                                        <div class="re_date">${instruction.re_date}</div>
                                        <div class="confirmation">${instruction.confirmation}</div>
                                        <div class="order-date">${instruction.order-date}</div>
                                        <div class="outDate">${instruction.outDate}</div>
                                        <div class="processing">${instruction.processing}</div>

                                    </li>
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
                function addDateRange() {
                    const startDate = document.getElementById('startDate').value;
                    const endDate = document.getElementById('endDate').value;

                    // 날짜 범위에서 각 날짜에 대한 처리구분을 추가
                    for (let date = new Date(startDate); date <= new Date(endDate); date.setDate(date.getDate() + 1)) {
                        const newRow = document.createElement('div');
                        newRow.className = 'table-row';
                        const dateCell = document.createElement('div');
                        dateCell.className = 'table-cell';
                        const typeCell = document.createElement('div');
                        typeCell.className = 'table-cell';

                        dateCell.textContent = date.toISOString().split('T')[0];

                        newRow.appendChild(dateCell);
                        newRow.appendChild(typeCell);

                        document.getElementById('dataBody').appendChild(newRow);
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
                document.addEventListener('DOMContentLoaded', function () {   //매장 스크롤바ㅊ
                    const shopSelect = document.getElementById('shopSelect');

                    shopSelect.addEventListener('change', function () {
                        const selectedShop = shopSelect.value;
                        console.log('Selected Shop:', selectedShop);
                        // 여기서 선택된 매장 값을 서버로 전송하도록 구현할 수 있습니다.
                    });
                });
            </script>

        </body>

        </html>