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
		<h1 class="text-center mb-5">회원가입</h1>
		<form name="frm" class="card p-3">
			<div class="input-group mb-3">
				<span class="input-group-text">아 이 디</span>
				<input class="form-control" name="uid">
				<button class="btn btn-secondary" type="button" id="btn-check">중복체크</button>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">비밀번호</span>
				<input class="form-control" name="upass">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">회 원 명</span>
				<input class="form-control" name="uname">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">전화번호</span>
				<input class="form-control" name="phone">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소1</span>
				<input class="form-control" name="address1">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소2</span>
				<input class="form-control" name="address2">
			</div>
			<div class="text-center">
				<button class="btn btn-primary">회원가입</button>
			</div>
		</form>
	</div>
</div>
<script>
	let check = false;
	
	$(frm.uid).on("change", function(){
		check=false;
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uid=$(frm.uid).val();
		const upass=$(frm.upass).val();
		const uname=$(frm.uname).val();
		if(uid==""){
			alert("아이디를 입력하세요!");
			$(frm.uid).focus();
		} else if(check==false){
			alert("아이디를 체크해주세요");
		} else if (upass == ""){
			alert("비밀번호를 입력하세요!");
			$(frm.upass).focus();
		} else if (uname == ""){
			alert("이름 입력하세요!");
			$(frm.uname).focus();
		} else {
			alert("회원가입");
		}
	});
	
	$("#btn-check").on("click", function(){
		const uid=$(frm.uid).val();
		if(uid == ""){
			alert("아이디를 입력하세요!");
		}else {
			$.ajax({
				type:"post",
				url:"/user/login",
				data:{uid:uid, upass:""},
				success:function(data){
					if(data == 0){
						alert("사용가능한 아이디입니다.");
						check=true;
					} else {
						alert("이미 사용중인 아이디입니다.");
						check=false;
					}
				}
			});
		}
	})
</script>