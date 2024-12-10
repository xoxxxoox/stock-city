<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<c:import url="/header" />
			<link rel="stylesheet" href="/css/userInfo.css">

			<div class="content-container">
				<div class="info-wrapper">
					<div class="header-section">
						<div class="page-name-box">
							<div class="site-name">Stock City |</div>
							<div class="page-name">고객사 정보</div>
						</div>
					</div>
					<h4 class="error-msg">${msg}</h4>
					<c:choose>
						<c:when test="${empty joins}">
							<h1> 등록된 데이터가 존재하지 않습니다. </h1>
						</c:when>
						<c:otherwise>
							<table class="tableLine">
								<thead>
									<tr>
										<th class="th">아이디</th>
										<th class="th">회사명</th>
										<th class="th">사업자등록번호</th>
										<th class="th">이메일</th>
										<th class="th">승인 날짜</th>
										<th class="th">계정 상태</th>
										<th class="th">상태 변경</th>
										<th class="th">매장 수</th>
										<th class="th">매장 추가</th>
										<th class="th">삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="joins" items="${joins}">
										<tr>
											<td class="td">${joins.id}</td>
											<td class="td">${joins.company}</td>
											<td class="td">${joins.businessNo}</td>
											<td class="td">${joins.email}</td>
											<td class="td">${joins.regDate}</td>
											<td class="td">${joins.registStatus}</td>
											<c:choose>
												<c:when test="${joins.registStatus == 'denied'}">
													<td class="td">
														<a href="/verifyProc?email=${joins.email}" style="text-decoration: none; font-size: 0;">
															<img src="/image/submit.png" style="width: 79px;">
														</a>
													</td>
												</c:when>
												<c:when
													test="${joins.registStatus == 'approve' or joins.registStatus == 'active'}">
													<td class="td">
														<a href="/adminStatusInactiveModify?dbName=${joins.dbName}" style="text-decoration: none; font-size: 0;">
															<img src="/image/on.png" style="width: 50px;">
														</a>
													</td>
												</c:when>
												<c:otherwise>
													<td class="td">
														<a href="/adminStatusActiveModify?dbName=${joins.dbName}" style="text-decoration: none; font-size: 0;">
															<img src="/image/off.png" style="width: 50px;">
														</a>
													</td>
												</c:otherwise>
											</c:choose>
											<td class="td">${joins.adCount}</td>
											<td class="td">
												<form action="/createSubAccounts" method="post">
													<input type="hidden" name="mainId" value="${joins.id}">
													<input type="hidden" name="mainEmail" value="${joins.email}">
													<input type="hidden" name="adCount" value="${joins.adCount}">
													<input type="hidden" name="dbName" value="${joins.dbName}"> <!-- second DB for문을 돌리기 위한 값 -->
													<input type="number" name="editAccount" placeholder="추가" required min="1" style="width: 52px; padding: 4px; border: 1px solid #ccc; border-radius: 20px; box-sizing: border-box;">
								
													<button type="submit" style="border: none; background-color: transparent;">
														<img src="/image/userAdd.png" style="width: 30px; margin-bottom: -10px;">
													</button>
												</form>
											</td>
											<td class="td">
												<a href="/adminRootDelete?dbName=${joins.dbName}&id=${joins.id}" style="text-decoration: none; font-size: 0;">
													<img src="/image/tresh.png" style="width: 20px;">
												</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
