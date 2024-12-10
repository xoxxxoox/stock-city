<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>카테고리 등록</title>
            <link rel="stylesheet" href="/css/cateInsert.css">
        </head>

        <body>
            <c:import url="/header" />
            <c:import url="/sider" />
            <div class="content-container">
                <div class="container">
                    <!-- Left Form: Category Registration -->
                    <div class="form-container">
                        <h2 style="text-align: center;">카테고리 등록</h2>
                        <form id="categoryForm" action="cateInsert" method="post">
                            <!-- 카테고리 그룹 입력 -->
                            <label for="addCateGroup">카테고리 그룹</label>
                            <input type="text" id="addCateGroup" name="cateGroup" value="${cateGroup}">

                            <!-- 카테고리 코드 입력 -->
                            <label for="addCateCode">카테고리 코드</label>
                            <input type="text" id="addCateCode" name="cateCode" value="${cateCode}">

                            <!-- 카테고리 이름 입력 -->
                            <label for="cateName">카테고리 이름</label>
                            <input type="text" id="cateName" name="cateName" value="${cateName}">

                            <!-- 카테고리 설명 입력 -->
                            <label for="categoryDescription">카테고리 설명</label>
                            <textarea id="categoryDescription" name="categoryDescription" value="${categoryDescription}"
                                rows="4" placeholder="카테고리에 대한 설명을 입력하세요"></textarea>

                            <!-- 등록 버튼 -->
                            <button type="submit">등록</button>
                        </form>
                    </div>

                    <!-- Right Form: Size Registration -->
                    <div class="form-container">
                        <h2 style="text-align: center;">브랜드 등록</h2>
                        <form id="brandForm" action="brandInsert" method="post">
                            <!-- 브랜드 코드 입력 -->
                            <label for="addBrandCode">브랜드 코드</label>
                            <input type="text" id="brandCode" name="brandCode">

                            <!-- 브랜드 설명 입력 -->
                            <label for="brandDescription">브랜드 설명</label>
                            <textarea id="brandDescription" name="brandDescription" rows="4"
                                placeholder="브랜드에 대한 설명을 입력하세요"></textarea>

                            <!-- 등록 버튼 -->
                            <button type="submit">등록</button>
                        </form>
                    </div>

                    <!-- Right Form: Color Registration -->
                    <div class="form-container">
                        <h2 style="text-align: center;">색상 코드 등록</h2>
                        <form id="colorForm" action="colorInsert" method="post">
                            <!-- 색상 코드 입력 -->
                            <label for="addColorCode">색상 코드</label>
                            <input type="text" id="addColorCode" name="ColorCode">

                            <!-- 색상 이름 입력 -->
                            <label for="colorName">색상 이름</label>
                            <input type="text" id="colorName" name="colorName">

                            <!-- 등록 버튼 -->
                            <button type="submit">등록</button>
                        </form>
                    </div>
                </div>
            </div>
            <script src="/js/cateInsert.js"></script>
        </body>

        </html>