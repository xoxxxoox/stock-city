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
                    background-color: #0f385c;
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
                    text-decoration: none; /* 링크 밑줄 제거 */
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
                }

                p.regist-text {
                    font-size: 20px;
                    color: #ffffff;
                    margin-top: -150%;
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
                    margin-right: 90px;
                    max-width: 100%;
                    margin-top: -30px;
                    margin-bottom: 200px;
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
                    border-radius: 10px; /* 둥글게 */
                    border: 1px solid #ccc; /* 테두리 추가 */
                    width: 220px;
                }

                .form-submit {
                    padding: 10px;
                    width: 80px;
                    margin-left: 100%;
                    cursor: pointer;
                    border: none;
                    border-radius: 20px;
                    color: #000000;
                }

                .form-cancel {
                    padding: 10px;
                    width: 80px;
                    margin-left: 60%;
                    cursor: pointer;
                    border: none;
                    border-radius: 20px;
                    color: #000000;
                }

                .form-submit:hover,
                .form-cancel:hover {
                    background-color: #0f385c;
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
                        <a href="/"><p>Stock City</p></a>
                    </div>
                </div>

                <!-- 오른쪽 영역 -->
                <div class="right">
                    <p id="errorMsg">${msg}</p>
                    <form class="form-container" action="/adminRegistProc" method="post">
                        <label class="form-label" for="aId">아이디</label>
                        <input class="form-input" type="text" name="aId" value="${param.aId}" required>

                        <label class="form-label" for="aPw">비밀번호</label>
                        <input class="form-input" type="password" name="aPw" value="${param.aPw}" required>

                        <label class="form-label" for="confirm">비밀번호 확인</label>
                        <input class="form-input" type="password" name="confirm" value="${param.confirm}" required>

                        <input class="form-submit" type="submit" value="생성">
                        <input class="form-cancel" type="button" onclick="window.location.href='/suadonghyunyeonjidongwoonsangwon@SC'" value="취소">
                    </form>
                    <!-- 하단 브랜드 로고 -->
                    <div class="brand-bottom">
                        <img src="/image/adminsc.png" alt="브랜드 로고">
                    </div>
                </div>
            </div>
        </body>

        </html>