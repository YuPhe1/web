<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">주문정보</h1>
		<div class="card p-3">
			<div class="row card-header p-3">
				<div class="col-lg-3">주문번호: ${vo.pid}</div>
				<div class="col-lg-3">주문자: ${vo.uname}(${vo.uid})</div>
				<div class="col-lg-3">전화번호: ${vo.rphone}</div>
				<div class="col-lg-3">주문일: ${vo.purDate}</div>
			</div>
			<div class="row p-3">
				<div class="col">주소: ${vo.raddress1} ${vo.raddress2}</div>
				<div class="col">총금액: <fmt:formatNumber value="${vo.purSum}" pattern="#,###원"/></div>
				<div class="col">주문상태:
					<c:out value="${vo.status==0 ? '결제대기중':''}"></c:out>
					<c:out value="${vo.status==1 ? '결제완료':''}"></c:out>
					<c:out value="${vo.status==2 ? '배송준비중':''}"></c:out>
					<c:out value="${vo.status==3 ? '배송중':''}"></c:out>
					<c:out value="${vo.status==4 ? '배송완료':''}"></c:out>
				</div>
			</div>
		</div>
		<h1 class="text-center my-5">주문상품</h1>
		<table class="table">
			<tr class="table-dark text-center">
				<th>상품번호</th>
				<th>이미지</th>
				<th>상품명</th>
				<th>가격</th>
				<th>수량</th>
				<th>총금액</th>
			</tr>
			<c:forEach items="${array}" var="gvo">
				<tr>
					<td class="text-center"><a href="/goods/read?gid=${gvo.gid}">${gvo.gid}</a></td>
					<td class="text-center"><img src="${gvo.image}" width="50px"></td>
					<td>${gvo.title}</td>
					<td class="text-end"><fmt:formatNumber value="${gvo.price}" pattern="#,###원"/></td>
					<td class="text-center">${gvo.qnt}</td>
					<td class="text-end"><fmt:formatNumber value="${gvo.price * gvo.qnt}" pattern="#,###원"/></td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="6" class="text-end" style="font-size: 20px"><b>총금액: <fmt:formatNumber value="${vo.purSum}" pattern="#,###원"/></b></td>
			</tr>
		</table>
	</div>
</div>