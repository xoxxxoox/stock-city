<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>

        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>재고 관리 사이트</title>

        </head>

        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                /* 세로 배치 */
            }

            .main {
                display: flex;
                width: 95%;
                justify-content: flex-start;
                flex-wrap: wrap;
                /* flex 정렬 방법 시작 지점부터 차곡차곡 쌓이게 해줌 */
            }

            .container {
                width: 40%;
                border-radius: 10px;
                margin-top: 20px;
                margin-right: 20px;
                margin-left: 20px;

            }

            .notice-section,
            .exchange-section,
            .entry-section {
                width: 100%;
                border: 1px solid #fff;
                border-collapse: collapse;
                border-radius: 5px;
                background-color: #D7E1EC;
                /* 표의 백그라운드 색상 */
            }

            .instruction {
                padding: 12px;
                position: relative;

            }

            .instruction .instruction-label {
                display: flex;
                margin-top: 10px;
                flex-wrap: wrap;
            }

            .instruction .instruction-list .instruction-item {
                display: flex;
            }

            .instruction .instruction-list .instruction-item>div {
                background-color: #fff;
                color: black;
                font-weight: 400;
            }

            .export {
                padding: 12px;
                position: relative;
            }

            .export .export-label {
                display: flex;
                margin-top: 10px;
                flex-wrap: wrap;
            }

            .export .export-list .export-item {
                display: flex;
            }

            .export .export-list .export-item>div {
                background-color: #fff;
                color: black;
                font-weight: 400;
            }

            .entry {
                padding: 12px;

            }

            .entry .entry-label {
                display: flex;
                margin-top: 10px;
                flex-wrap: wrap;
            }


            .entry .entry-list .entry-item {
                display: flex;
            }

            .entry .entry-list .entry-item>div {
                background-color: #fff;
                color: black;
                font-weight: 400;
            }

            h2 {
                color: #333;
                margin-left: 10px;
                font-size: 18px;
                margin-bottom: 0;

            }

            .Date,
            .outDate,
            .writeDate,
            .inDate {
                margin-left: 1;
            }


            .Unprocessed {
                margin-right: 20px;
                margin-left: auto;
            }

            .file {
                margin-right: 20px;
                margin-left: auto;
            }

            .shop.title {
                flex: 1;
                /* 남은 공간을 모두 차지하도록 설정 */

            }

            .notice {
                padding: 12px;

            }

            .notice .notice-label {
                display: flex;
                margin-top: 10px;
                flex-wrap: wrap;
            }


            .notice .notice-list .notice-item {
                display: flex;
            }

            .notice .notice-list .notice-item>div {
                background-color: #fff;
                color: black;
                font-weight: 400;
            }



            .Date,
            .shop,
            .Unprocessed,
            .outDate,
            .inDate,
            .writeDate,
            .title {

                flex: 1;
                border: 1px solid #ddd;
                padding: 8px;
                background-color: #2895F4;
                color: #ffffff;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
                font-weight: bold;
                font-size: 14px;
                /* 글씨 두껍게 설정 */
            }

            .check,
            .file {
                flex: 0.5;
                /* 각 열의 너비를 조정하여 더 작게 만듭니다. */
                border: 1px solid #ddd;
                padding: 8px;
                background-color: #2895F4;
                color: #ffffff;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
                font-weight: bold;
                font-size: 14px;
            }



            .more-button {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-left: 87%;
                margin-bottom: -20px;
            }

            .more-button button {
                background-color: #D7E1EC;
                color: #2895F4;
                border: none;
                padding: 0px 5px;
                border-radius: 5px;
                cursor: pointer;
            }

            .checked .check::before {
                content: '●';
                color: gray;
                /* 확인한 상태일 때 회색 동그라미로 설정 */
            }

            .unchecked .check::before {
                content: '●';
                color: green;
                /* 확인하지 않은 상태일 때 초록색 동그라미로 설정 */
            }
        </style>

        <body>
            <c:import url="/header" />
            <c:import url="/sider" />
            <div class="content-container class">


                <div class="main">
                    <div class="container">
                        <div class="exchange-section">
                            <h2>R/T지시내역</h2>
                            <div class="more-button">
                                <button type="button"
                                    onclick="location.href='/instruction/instructionform'">more</button>
                            </div>
                            <div class="instruction">
                                <div class="instruction-label">
                                    <div class="Date">지시일자</div>
                                    <div class="shop">반입매장</div>
                                    <div class="Unprocessed">미처리수량</div>
                                </div>
                                <div class="instruction-list">
                                    <div class="instruction-item">
                                        <div class="Date">지시일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                    <div class="instruction-item">
                                        <div class="Date">지시일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                    <div class="instruction-item">
                                        <div class="Date">지시일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                    <div class="instruction-item">
                                        <div class="Date">지시일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="container">
                        <div class="exchange-section">
                            <h2>R/T반출내역</h2>
                            <div class="more-button">
                                <button type="button">more</button>
                            </div>
                            <div class=" export">
                                <div class="export-label">
                                    <div class="outDate">반출일자</div>
                                    <div class="shop">반입매장</div>
                                    <div class="Unprocessed">미처리수량</div>
                                </div>
                                <div class="export-list">
                                    <div class="export-item">
                                        <div class="outDate">반출일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>

                                    </div>

                                    <div class="export-item">
                                        <div class="outDate">반출일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>

                                    </div>
                                    <div class="export-item">
                                        <div class="outDate">반출일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>

                                    </div>
                                    <div class="export-item">
                                        <div class="outDate">반출일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="container">
                        <div class="entry-section">
                            <h2>R/T반입내역</h2>
                            <div class="more-button">
                                <button type="button">more</button>
                            </div>
                            <div class="entry">
                                <div class="entry-label">
                                    <div class="inDate">반입일자</div>
                                    <div class="shop">반입매장</div>
                                    <div class="Unprocessed">미처리수량</div>
                                </div>
                                <div class="entry-list">
                                    <div class="entry-item">
                                        <div class="inDate">반입일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                    <div class="entry-item">
                                        <div class="inDate">반입일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                    <div class="entry-item">
                                        <div class="inDate">반입일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                    <div class="entry-item">
                                        <div class="inDate">반입일자</div>
                                        <div class="shop">반입매장</div>
                                        <div class="Unprocessed">미처리수량</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>




                    <div class="container">
                        <div class="notice-section">
                            <h2>Notice</h2>
                            <div class="more-button">
                                <button type="button" onclick="location.href='/notice/noticeform'">more</button>
                            </div>
                            <div class="notice">
                                <div class="notice-label">
                                    <div class="writeDate">날짜</div>
                                    <div class="title">제목</div>
                                    <div class="check">확인</div>
                                </div>
                                <c:choose>
                                    <c:when test="${empty Notices}">
                                        <div class="notice-item">
                                            <div class="tr">
                                                <div class="td" colspan="10">등록된 데이터가 존재하지 않습니다.</div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="Notice" items="${Notices}">
                                            <div class="notice-list">
                                                <div class="notice-item ${notice.checked ? 'checked' : 'unchecked'}">
                                                    <div class="writeDate">${Notice.writeDate}</div>
                                                    <div class="title"
                                                        onclick="location.href='/notice/noticecontent?no=${Notice.no}'">
                                                        ${Notice.title}
                                                    </div>
                                                    <div class="check checked">${Notice.checked}</div>

                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /notice/content 에서 가져온 내용 표시 -->

            </div>
            </div>

            <script>
                function toggleCheckedState(noticeItem) {
                    // 확인된 경우 checked 클래스를 제거하고, 확인되지 않은 경우 checked 클래스를 추가하여 초록색 동그라미를 표시/숨김
                    if (noticeItem.classList.contains('checked')) {
                        noticeItem.classList.remove('checked');
                        noticeItem.classList.add('unchecked');
                    } else {
                        noticeItem.classList.remove('unchecked');
                        noticeItem.classList.add('checked');
                    }
                }
            </script>


        </body>

        </html>