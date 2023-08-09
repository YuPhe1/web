<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	span {
		width: 90px;
		justify-content: center;
	}
</style>
<div class="row justify-content-center my-5">
	<div class="col-md-8 col-lg-6">
		<h1 class="text-center mb-5">회원정보</h1>
		<form name="frm" class="card p-3">
			<div class="input-group mb-3">
				<span class="input-group-text">아 이 디</span>
				<input class="form-control" value="${vo.uid}" readonly>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">회 원 명</span>
				<input class="form-control" value="${vo.uname}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">전화번호</span>
				<input class="form-control" value="${vo.phone}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소1</span>
				<input class="form-control" value="${vo.address1}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소2</span>
				<input class="form-control" value="${vo.address2}">
			</div>
		</form>
	</div>
</div>