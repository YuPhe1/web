<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5 justify-content-center">
	<div class="col-md-8 col-lg-5 my-5">
		<h1 class="text-center mb-5">로그인</h1>
		<form name="frm" class="card p-3">
			<input name="uid" class="form-control mb-3" placeholder="아이디">
			<input name="upass" type="password" class="form-control mb-3" placeholder="비밀번호">
			<button class="btn btn-primary w-100">로그인</button>
			<div class="mt-3 row">
				<div class="col">
					<input type="checkbox" name="isLogin"> 로그인 상태유지
				</div>
				<div class="text-end col">
					<a href="/user/insert">회원가입</a>
				</div>
			</div>
		</form>
	</div>
</div>
<script>
	const target = "${target}";
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid = $(frm.uid).val();
		const upass = $(frm.upass).val();
		const isLogin = $(frm.isLogin).is(":checked");
		
		if(uid == ""){
			alert("아이디를 입력하세요");
			$(frm.uid).focus();
		} else if(upass == ""){
			alert("비밀번호를 입력하세요");
			$(frm.upass).focus();
		} else {
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid:uid, upass:upass, isLogin:isLogin},
				success:function(data){
					if(data == 0){
						alert("아이디를 확인하세요");
					} else if(data == 2){
						alert("비밀번호를 확인하세요");
					} else {
						//alert("로그인 성공");
						if(target == ""){
							location.href="/";
						}else{
							location.href=target;
						}
					}
				}
			});
		}
	});
</script>