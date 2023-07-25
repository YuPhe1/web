<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row">
	<div class="col">
		<h1 class="text-center my-5">상품정보</h1>
		<div class="card p-3">
			<h5>상품코드: ${p.pcode}</h5>
			<h5>상품명: ${p.pname}</h5>
			<h5>상품가격: <fmt:formatNumber value="${p.price}" pattern="#,###원" /></h5>
			<h5>상품등록일: <fmt:formatDate value="${p.rdate}" pattern="yyyy-MM-dd HH:mm:ss" /></h5>
		</div>
		<div class="text-center my-4">
			<button class="btn btn-primary">수정</button>
			<button class="btn btn-danger">삭제</button>
		</div>
	</div>
</div>

<script>
	const pcode = "${p.pcode}";
	//수정버튼을 클릭한 경우
	$(".btn-primary").on("click", function() {
		location.href = "/pro/update?code="+pcode;
	});

	// 삭제버튼을 클릭한경우
	$(".btn-danger").on("click", function() {
		if(confirm(pcode + "번 상품을 삭제하실래요?")){
			// 삭제로 이동
			location.href = "/pro/delete?code="+pcode;
		}
	});
</script>