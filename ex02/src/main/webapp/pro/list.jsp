<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row my-4">
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
					<td class="table-info">${vo.pcode}</td>
					<td><a href="/pro/read?code=${vo.pcode}">${vo.pname}</a></td>
					<td><fmt:formatNumber value="${vo.price}" pattern="#,###원" /></td>
					<td><fmt:formatDate value="${vo.rdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
		</table>
		<div class="text-center">
			<button id="prev" class="btn btn-info">이전</button>
			<span id="page" class="mx-2"></span>
			<button id="next" class="btn btn-info">다음</button>
		</div>
	</div>
</div>
<script>
	let page="${page}";
	let last="${last}";
	$("#page").html("<b>" +page+ " / " + last + "</b>");
	
	if(page==1) $("#prev").attr("disabled", true);
	else $("#prev").attr("disabled", false);
	
	if(page==last) $("#next").attr("disabled", true);
	else $("#next").attr("disabled", false);
	
	$("#prev").on("click", function(){
		page--;
		location.href="/pro/list?page=" + page;
	});
	
	$("#next").on("click", function(){
		page++;
		location.href="/pro/list?page=" + page;
	});
</script>
