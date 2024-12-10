<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<c:import url="/header" />
		<c:import url="/sider" />
		<link rel="stylesheet" href="/css/userInfo.css">

		<body>
			<div class="content-container">
				<div class="center">
					<div class="container">
						<h1 class="title">매장정보 수정</h1>
						<h4 class="error-msg">${msg}</h4>
						<table>
							<tr>
								<td>
									<c:choose>
										<c:when test="${sessionScope.accountId == 'root'}">
											<form action="/updateProc" method="post">
												<input type="hidden" name="no" value="${sessionScope.no}">
												<input class="input-field" type="text" name="id" value="${sessionScope.id}" readonly="readonly"><br>
												<input class="input-field" type="password" name="pw" placeholder="비밀번호"><br>
												<input class="input-field" type="password" name="confirm" placeholder="비밀번호 확인"><br>
												<input class="input-field" type="text" name="company" value="${sessionScope.company}" readonly="readonly"><br>
												<input class="input-field" type="email" name="email" value="${sessionScope.email}" placeholder="이메일"><br>
												<input class="updateBtn" type="submit" value="수정">
												<input class="cancel-updateBtn" type="button" onclick="window.location.href='/userInfo?id=${sessionScope.id}'" value="취소"><br>
											</form>
										</c:when>
										<c:otherwise>
											<form action="/updateProc" method="post">
												<input type="hidden" name="no" value="${sessionScope.no}">
												<input class="input-field" type="text" name="id" value="${sessionScope.id}" readonly="readonly"><br>
												<input class="input-field" type="password" name="pw" placeholder="비밀번호"><br>
												<input class="input-field" type="password" name="confirm" placeholder="비밀번호 확인"><br>
												<input class="input-field" type="text" name="company" value="${sessionScope.company}" readonly="readonly"><br>
												<input class="input-field" type="email" name="email" value="${sessionScope.email}" placeholder="이메일"><br>
												<input class="input-field" type="text" name="name" placeholder="지점 이름" required><br>
												<input class="input-field" type="text" name="tel" placeholder="전화번호" required><br>
												<input class="input-field" type="text" name="address" placeholder="매장 주소" required><br>
												<input class="updateBtn" type="submit" value="수정">
												<input class="cancel-updateBtn" type="button" onclick="window.location.href='/userInfo?id=${sessionScope.id}'" value="취소"><br>
											</form>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</body>