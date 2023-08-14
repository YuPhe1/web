<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	span {
		width: 90px;
		justify-content: center;
	}
	#image {
		border-radius: 50%;
		border: 2px solid gray;
		cursor:pointer;
	}
</style>
<div class="row justify-content-center my-5">
	<div class="col-md-8 col-lg-6">
		<h1 class="text-center mb-5">회원정보</h1>
		<form name="frm" class="card p-3" method="post" action="/user/update" enctype="multipart/form-data">
			<div class="row">
				<div class="col-md-3 mb-3 text-center">
					<c:if test="${vo.photo==null || vo.photo==''}">
						<img name="photo" src="http://via.placeholder.com/100x100" width="80%" id="image">
					</c:if>
					<c:if test="${vo.photo!=null && vo.photo!=''}">
						<img name="photo" src="${vo.photo}" width="80%" id="image">
					</c:if>
					<input name="oldImage" value="${vo.photo}" type="hidden">
					<input type="file" name="photo" style="display:none"  accept="image/*">
				</div>
				<div class="col">
					<div class="input-group mb-3">
						<span class="input-group-text">아 이 디</span>
						<input name="uid" class="form-control" value="${vo.uid}" readonly>
					</div>
					<div class="input-group mb-3">
						<span class="input-group-text">회 원 명</span>
						<input name="uname" class="form-control" value="${vo.uname}">
					</div>
				</div>
			</div>
			<div class="input-group mb-3">
						<span class="input-group-text">전화번호</span>
						<input name="phone" class="form-control" value="${vo.phone}">
			</div>	
			<div class="input-group mb-3">
				<span class="input-group-text">주소1</span>
				<input name="address1" class="form-control" value="${vo.address1}">
				<button id="btn-search" class="btn btn-secondary" type="button">주소검색</button>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소2</span>
				<input name="address2" class="form-control" value="${vo.address2}">
			</div>
			<div class="text-center my-3">
				<button class="btn btn-primary px-5">정보수정</button>
			</div>
		</form>
	</div>
</div>
<script>
	
	// 주소검색 버튼을 누른경우
	$("#btn-search").on("click", function(){
		new daum.Postcode({
			oncomplete: function(data){
				console.log(data);
				if(data.buildingName != ""){
					$(frm.address1).val(data.address + " " + data.buildingName);
				} else {
					$(frm.address1).val(data.address);
				}
				
			}
		}).open();
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const uname=$(frm.uname).val();
		if (uname == ""){
			alert("이름 입력하세요!");
			$(frm.uname).focus();
		} else {
			if(confirm("회원정보를 수정하실래요?")){
				frm.submit();
			}
		}
	});

	
	// 이미지 파일을 선택한 경우
	$(frm.photo).on("change", function(e){
		$("#image").attr("src", URL.createObjectURL(e.target.files[0]));
	});
	
	// 이미지를 클릭한 경우
	$("#image").on("click", function(){
		$(frm.photo).click();
	})	
	
</script>