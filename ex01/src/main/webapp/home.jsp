<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈페이지</title>
<!-- CSS only -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<!-- JavaScript Bundle with Popper -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
	crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Orbit&display=swap');
</style>
<style>
a {
	margin: 10px;
}

* {
	font-family: 'Orbit', sans-serif;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col mt-5">
				<div class="text-center">
					<a href="/">회사소개</a> <a href="/pro/list">상품목록</a> <a
						href="/stu/list">학생목록</a>
				</div>
				<hr>
				<jsp:include page="${pageName}" />
			</div>
		</div>
	</div>
</body>
</html>