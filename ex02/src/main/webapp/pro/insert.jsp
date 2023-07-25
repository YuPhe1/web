<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row my-5 justify-content-center">
	<div class="col-md-6">
		<h1 class="text-center mb-5">상품등록</h1>
		<form class="card p-3" method="post">
			<div class="input-group my-2">
				<span class="input-group-text">상품이름</span>
				<input class="form-control" name="name">
			</div>
			<div class="input-group my-2">
				<span class="input-group-text">상품가격</span>
				<input class="form-control" name="price">
			</div>
			<div class="text-center mt-4">
				<input type="submit" value="상품등록" class="btn btn-outline-primary">
				<input type="reset" value="등록취소" class="btn btn-outline-secondary">
			</div>
		</form>
	</div>
</div>