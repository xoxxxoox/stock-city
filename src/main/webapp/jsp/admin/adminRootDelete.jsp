<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:import url="/header" />
        <link rel="stylesheet" href="/css/deletestyle.css">

        <div class="content-container">
            <div class="header-section">
                <div class="page-name-box">
                    <div class="page-name">고객사 삭제</div>
                </div>
            </div>
            <div class="center">
                <div class="container">
                    <h1 class="error-msg">정말 삭제하시겠습니까?</h1>
                    <h4 class="error-msg">${msg}</h4>
                    <table class="form-container">
                        <tr>
                            <td>
                                <form action="/adminRootDeleteProc" method="post">
                                    <input class="input-field" type="text" name="id" value="${param.id}"
                                        readonly="readonly"><br>
                                    <input type="hidden" name="dbName" value="${param.dbName}">
                                    <input class="button" type="submit" value="삭제"
                                        style="border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px;">
                                    <input class="cancel-button" type="button" value="취소"
                                        style="border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; border-bottom-width: 0px;"
                                        onclick="location.href='/adminInfo?id=${sessionScope.id}'">
                                </form>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>