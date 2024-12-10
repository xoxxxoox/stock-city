<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>매장 등록</title>
            <!-- 다음 우편번호 서비스 스크립트 -->
            <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
            <style>
                /* 기본 설정 */
                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 0;
                }

                /* 폼 컨테이너 스타일 */
                .container {
                    max-width: 400px;
                    margin: 20px auto;
                    padding: 20px;
                    border: 1px solid #3498db;
                    border-radius: 10px;
                    background-color: #fff;
                }

                /* 폼 정렬 */
                form {
                    text-align: center;
                }

                /* 라벨 스타일 */
                label {
                    display: block;
                    margin-bottom: 8px;
                }

                /* 입력 필드 스타일 */
                input,
                select {
                    width: 100%;
                    padding: 10px;
                    margin-bottom: 16px;
                    box-sizing: border-box;
                }

                /* 우편번호 관련 스타일 */
                .postcode-container {
                    display: flex;
                    gap: 8px;
                    align-items: center;
                }

                #postcode,
                #address {
                    flex: 1;
                }

                #postcode-btn {
                    flex: 0;
                    cursor: pointer;
                    background: none;
                    border: none;
                }

                #postcode-img {
                    width: 40px;
                    height: 40px;
                    padding: 0;
                    margin: 0;
                }

                /* 전화번호 관련 스타일 */
                .phone-container {
                    display: flex;
                    gap: 8px;
                    align-items: center;
                }

                #region-code,
                #middle-number,
                #last-number {
                    flex: 1;
                }

                /* 버튼 스타일 */
                button {
                    background-color: #3498db;
                    color: #fff;
                    padding: 10px 15px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                }

                /* 오류 메시지 스타일 */
                .error {
                    border: 1px solid red;
                }
            </style>
        </head>

        <body>
            <c:import url="/header" />
            <div class="container">
                <h2 style="text-align: center;">지점 등록</h2>

                <!-- 폼 시작 -->
                <form id="storeForm" action="/store/registProc" method="post" onsubmit="return validateForm()">
                    <!-- 지점 이름 입력 -->
                    <label for="storeName">지점 이름</label>
                    <input type="text" id="storeName" name="storeName">

                    <!-- 지점 주소 입력 -->
                    <label for="storeLocation">지점 주소</label>
                    <div class="postcode-container">
                        <input type="text" name="postcode" id="postcode" placeholder="우편번호" readonly>
                        <button type="button" id="postcode-btn" onclick="execDaumPostcode()">
                            <img src="/image/postcode-btn.jpg" id="postcode-img" />
                        </button>
                    </div>
                    <input type="text" name="address" id="address" placeholder="주소" readonly><br>
                    <input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"><br>

                    <!-- 전화번호 입력 -->
                    <label for="storeTel">전화번호</label>
                    <div class="phone-container">
                        <!-- 국번 선택 -->
                        <select id="region-code" name="regionCode">
                            <option value="02">서울 (02)</option>
                            <option value="031">경기 (031)</option>
                            <option value="032">인천 (032)</option>
                            <option value="051">부산 (051)</option>
                            <option value="053">대구 (053)</option>
                            <option value="042">대전 (042)</option>
                            <option value="062">광주 (062)</option>
                            <option value="052">울산 (052)</option>
                            <option value="044">세종 (044)</option>
                            <option value="033">강원 (033)</option>
                            <option value="043">충북 (043)</option>
                            <option value="041">충남 (041)</option>
                            <option value="063">전북 (063)</option>
                            <option value="061">전남 (061)</option>
                            <option value="054">경북 (054)</option>
                            <option value="055">경남 (055)</option>
                            <option value="064">제주 (064)</option>
                        </select>
                        <!-- 중간 번호 입력 -->
                        <input type="text" id="middle-number" name="middleNumber" placeholder="1234" maxlength="4">
                        <!-- 끝 번호 입력 -->
                        <input type="text" id="last-number" name="lastNumber" placeholder="5678" maxlength="4">
                    </div>

                    <br>
                    <!-- 등록 버튼 -->
                    <button type="submit">등록</button>
                </form>
                <!-- 폼 종료 -->
            </div>

            <!-- 스크립트 시작 -->
            <script>
                // 다음 우편번호 서비스 호출 함수
                function execDaumPostcode() {
                    new daum.Postcode({
                        oncomplete: function (data) {
                            var addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
                            document.getElementById('postcode').value = data.zonecode;
                            document.getElementById('address').value = addr;
                            document.getElementById('detailAddress').focus();
                        }
                    }).open();
                }

                // 폼 유효성 검사 함수
                function validateForm() {
                    // 이전 오류 표시 제거
                    resetBorders();

                    // 필수 필드 검사
                    var storeName = document.getElementById('storeName').value.trim();
                    var postcode = document.getElementById('postcode').value.trim();
                    var address = document.getElementById('address').value.trim();
                    var detailAddress = document.getElementById('detailAddress').value.trim();
                    var middleNumber = document.getElementById('middle-number').value.trim();
                    var lastNumber = document.getElementById('last-number').value.trim();

                    if (storeName === "") {
                        markAsError('storeName');
                        return false;
                    }

                    // 우편번호와 주소 동시에 검사
                    if (postcode === "" && address === "") {
                        markAsError('postcode');
                        markAsError('address');
                        return false;
                    }

                    // 중간 번호 숫자 여부 검사
                    if (!isNumeric(middleNumber)) {
                        markAsError('middle-number');
                        clearValue('middle-number');
                        return false;
                    }

                    // 끝 번호 숫자 여부 검사
                    if (!isNumeric(lastNumber)) {
                        markAsError('last-number');
                        clearValue('last-number');
                        return false;
                    }

                    // 값 포맷팅 후 설정
                    formatAndSetValues();

                    // 폼이 유효하면 제출
                    return true;
                }

                // 숫자 여부 확인 함수
                function isNumeric(value) {
                    return /^\d+$/.test(value);
                }

                // 오류 표시 제거 함수
                function resetBorders() {
                    var inputs = document.getElementsByTagName('input');
                    for (var i = 0; i < inputs.length; i++) {
                        inputs[i].classList.remove('error');
                    }
                }

                // 오류 표시 함수
                function markAsError(elementId) {
                    document.getElementById(elementId).classList.add('error');
                }

                // 값 지우기 함수
                function clearValue(elementId) {
                    document.getElementById(elementId).value = "";
                }

                // 값 포맷팅 함수
                function formatAndSetValues() {
                    var postcode = document.getElementById('postcode').value.trim();
                    var address = document.getElementById('address').value.trim();
                    var detailAddress = document.getElementById('detailAddress').value.trim();
                    var middleNumber = document.getElementById('middle-number').value.trim();
                    var lastNumber = document.getElementById('last-number').value.trim();

                    // 우편번호, 주소, 상세주소 합치기
                    var fullAddress = postcode + "//" + address + "//" + detailAddress;
                    document.getElementById('address').value = fullAddress;

                    // 전화번호 포맷팅
                    var formattedPhoneNumber = middleNumber + '-' + lastNumber.slice(0, 4) + '-' + lastNumber.slice(4);
                    document.getElementById('last-number').value = formattedPhoneNumber;
                }
            </script>
            <!-- 스크립트 종료 -->
        </body>

        </html>