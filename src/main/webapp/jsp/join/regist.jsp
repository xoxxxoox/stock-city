<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="icon" href="/image/sc.png">
            <title>회원가입</title>

            <link rel="stylesheet"
                href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap">
            <style>
                /* 전체 페이지 설정 */
                html,
                body {
                    height: 100%;
                    margin: 0;
                    overflow: hidden;
                    font-family: 'Noto Sans KR', sans-serif;
                }

                /* 그리드 레이아웃 설정 */
                .grid {
                    display: flex;
                    height: 100vh;
                }

                .grid div {
                    flex: 1;
                    display: grid;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                /* 왼쪽 영역 설정 */
                .left {
                    background-color: #2895F4;
                    position: relative;
                }

                /* 브랜드 로고 설정 */
                .brand {
                    position: absolute;
                    top: 10px;
                    left: 10px;
                    display: flex;
                    align-items: center;
                }

                .brand a {
                    text-decoration: none;
                    /* 링크 밑줄 제거 */
                }

                .brand p {
                    margin: 0;
                    font-size: 30px;
                    font-weight: bold;
                    color: #ffffff;
                }

                h1.regist-text {
                    font-size: 30px;
                    font-weight: bold;
                    color: #ffffff;
                    text-align: left;
                }

                p.regist-text {
                    font-size: 20px;
                    color: #ffffff;
                    margin: -100px 0 50px 0;
                }

                /* 오른쪽 영역 설정 */
                .right {
                    background-color: #ffffff;
                    position: relative;
                }

                .right p {
                    text-align: center;
                    font-weight: bold;
                    color: red;
                }

                /* form-container 스타일 수정 */
                .form-container {
                    display: grid;
                    grid-template-columns: max-content auto;
                    gap: 10px;
                    text-align: center;
                    max-width: 100%;
                    margin: -30px 90px 120px 0;
                }

                .form-label {
                    text-align: right;
                    white-space: nowrap;
                    margin-top: 5%;
                }

                /* input 태그 스타일 추가 */
                .form-input {
                    padding: 8px;
                    margin-bottom: 8px;
                    box-sizing: border-box;
                    border-radius: 10px;
                    /* 둥글게 */
                    border: 1px solid #ccc;
                    /* 테두리 추가 */
                    width: 220px;
                }

                .form-submit {
                    padding: 10px;
                    width: 80%;
                    margin-left: 90%;
                    cursor: pointer;
                    border: none;
                    border-radius: 20px;
                    color: #000000;
                }

                .form-cancel {
                    padding: 10px;
                    width: 40%;
                    margin-left: 60%;
                    cursor: pointer;
                    border: none;
                    border-radius: 20px;
                    color: #000000;
                }

                .form-submit:hover,
                .form-cancel:hover {
                    background-color: #2895F4;
                    color: #ffffff;
                }

                .brand-bottom {
                    position: absolute;
                    bottom: 20px;
                    left: 50%;
                    transform: translateX(-50%);
                }

                .brand-bottom img {
                    width: 80px;
                    height: auto;
                }
            </style>
        </head>

        <body>
            <div class="grid">
                <!-- 왼쪽 영역 -->
                <div class="left">
                    <!-- 브랜드 로고 -->
                    <div class="brand">
                        <a href="/">
                            <p>Stock City</p>
                        </a>
                    </div>
                    <h1 class="regist-text">회원가입 유의사항</h1>
                    <p class="regist-text">
                        안녕하세요 Stock City입니다. 재고관리 프로그램입니다.<br><br>
                        회원 정보를 정확하게 입력해주세요.<br><br>
                        정보 누락으로 회원가입 신청이 거부될 수 있습니다.<br><br>
                        회원가입 승인 후 이메일로 아이디, 비밀번호가 발송됩니다.<br><br>
                        이용 약관 위반 사실이 확인될 경우, 서비스 이용이 제재됩니다.<br><br>
                        첫 로그인 시 우측 상단 <strong style="color: greenyellow;">MYPAGE</strong>에서 정보 수정 후 이용 부탁드립니다.
                    </p>
                </div>

                <!-- 오른쪽 영역 -->
                <div class="right">
                    <p id="errorMsg">${msg}</p>
                    <form class="form-container" action="/registProc" method="post">
                        <input type="hidden" name="id" value="">
                        <input type="hidden" name="pw" value="">

                        <label class="form-label" for="company">회사명</label>
                        <input class="form-input" type="text" name="company" value="${param.company}">

                        <label class="form-label" for="businessNo">사업자등록번호</label>
                        <input class="form-input" type="text" name="businessNo" value="${param.businessNo}">

                        <label class="form-label" for="email">이메일</label>
                        <input class="form-input" type="email" name="email" value="${param.email}">

                        <label class="form-label" for="adCount">운영 매장 개수</label>
                        <input class="form-input" type="text" name="adCount" value="${param.adCount}"
                            placeholder="30개 초과 시 관리자 문의">

                        <input class="form-submit" type="submit" value="가입">
                        <input class="form-cancel" type="button" onclick="window.location.href='/'" value="취소">
                    </form>
                    <!-- 하단 브랜드 로고 -->
                    <div class="brand-bottom">
                        <img src="/image/sc.png" alt="브랜드 로고">
                    </div>
                </div>
            </div>
            <script>
                // 에러 메시지를 표시하는 요소
                var errorMsg = document.getElementById('errorMsg');
                var companyInput = document.getElementsByName('company')[0];
                var businessNoInput = document.getElementsByName('businessNo')[0];
                var emailInput = document.getElementsByName('email')[0];
                var adCountInput = document.getElementsByName('adCount')[0];

                // ${msg}의 값에 따라 스타일을 동적으로 변경
                if (errorMsg.innerText === '회사명을 입력해주세요.' || errorMsg.innerText === '회사명은 영어로 시작 부탁드립니다.') {
                    companyInput.style.border = '2px solid red';
                } else if (errorMsg.innerText === '사업자등록번호를 입력해주세요.' || errorMsg.innerText === '존재하는 사업자등록번호입니다.') {
                    businessNoInput.style.border = '2px solid red';
                } else if (errorMsg.innerText === '이메일을 입력해주세요.' || errorMsg.innerText === '존재하는 이메일입니다.') {
                    emailInput.style.border = '2px solid red';
                } else if (errorMsg.innerText === '운영 매장 개수를 입력해주세요.' || errorMsg.innerText === '1개 이상 등록해주세요.' || errorMsg.innerText === '지점 31개 이상 등록은 문의 부탁드립니다.') {
                    adCountInput.style.border = '2px solid red';
                }
            </script>
        </body>

        </html>