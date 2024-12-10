<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
			<c:import url="/header" />
			<c:import url="/sider" />
			<link rel="stylesheet" href="/css/userInfo.css">

			<div class="content-container">
				<div class="info-wrapper">
					<div class="header-section">
						<div class="page-name-box">
							<div class="site-name">${sessionScope.company} |</div>
							<div class="page-name">매장 관리</div>
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
										<th class="th">이메일</th>
										<th class="th">승인 날짜</th>
										<th class="th">승인 상태</th>
										<th class="th">승인 변경</th>
										<th class="th">삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="joins" items="${joins}">
										<tr>
											<td class="td">${joins.id}</td>
											<td class="td">${joins.company}</td>
											<td class="td">${joins.email}</td>
											<td class="td">${joins.regDate}</td>
											<td class="td">${joins.registStatus}</td>
											<c:choose>
												<c:when test="${joins.registStatus == 'approve' or joins.registStatus == 'active'}">
													<td class="td">
														<a href="/statusModify?id=${joins.id}" style="text-decoration: none; font-size: 0;">
															<img src="/image/on.png" style="width: 50px;">
														</a>
													</td>
												</c:when>
												<c:otherwise>
													<td class="td">
														<a href="/statusModify?id=${joins.id}" style="text-decoration: none; font-size: 0;">
															<img src="/image/off.png" style="width: 50px;">
														</a>
													</td>
												</c:otherwise>
											</c:choose>
											<td class="td">
												<a href="/storeDelete?id=${joins.id}&adCount=${joins.adCount}&dbName=${joins.dbName}" style="text-decoration: none; font-size: 0;">
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