<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<script src="/js/jquery-3.6.0.js"></script>

<head>
	<title>회원 목록</title>
</head>

<body>
	<table>
		<tbody>
			<th>아이디</th>
			<th>이름</th>
			<th>생년월일</th>
			<th>휴대폰번호</th>
			<c:forEach var="item" items="${resultList}" varStatus="i">
				<tr>
					<td>${item.mberId}</td>
					<td>${item.name}</td>
					<td>${item.birth}</td>
					<td>${item.mobileTelNo}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>

</html>