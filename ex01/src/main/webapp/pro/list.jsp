<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row">
	<div class="col">
		<h1 class="text-center mb-4">상품목록</h1>
		<table class="table table-striped">
			<tr class="table table-dark">
				<td>상품코드</td>
				<td>상품이름</td>
				<td>상품가격</td>
				<td>상품날짜</td>
			</tr>
			<c:forEach items="${array}" var="vo">
				<tr>
					<td>${vo.pcode}</td>
					<td>${vo.pname}</td>
					<td><fmt:formatNumber value="${vo.price}" pattern="#,###" />원
					</td>
					<td><fmt:formatDate value="${vo.rdate}"
							pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
