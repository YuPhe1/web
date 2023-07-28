<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class = "row">
	<div class="col">
		<h1 class="text-center my-5">상품등록</h1>
		<div class="row justify-content-center">
			<form name="frm2" class="card col-6 col-md-4 p-3">
				<div class="input-group input-group-lg mb-3">
					<span class="input-group-text" id="basic-addon1">상품이름</span>
					<input class="form-control" placeholder="상품명" name="pname">
				</div>
				<div class="input-group input-group-lg mb-3">
					<span class="input-group-text" id="basic-addon1">상품가격</span>
					<input class="form-control" placeholder="가격" name="price">
				</div>
				<div class="text-center mb-2">
					<input type="submit" class="btn btn-primary" value="상품등록">
					<input type="reset" class="btn btn-secondary" value="등록취소">
				</div>
			</form> 
		</div>
		<hr class="mt-5">
	</div>
</div>

<script>
$(frm2).on("submit", function(e) {
	e.preventDefault();
	const pname = $(frm2.pname).val();
	const price = $(frm2.price).val();
	
	if(pname==""){
		alert("상품이름을 입력하세요!");
		$(frm2.pname).focus();
	} else if(price==""){
		alert("상품가격을 입력하세요!");
		$(frm2.price).focus();
	} else if(price.replace(/[0-9]/g, '')) {
		alert("상품가격을 숫자로 입력하세요!");
		$(frm2.price).val("");
		$(frm2.price).focus();
	} else {
		if(confirm("새로운 상품을 등록하실래요?")){
			$.ajax({
				type:"post",
				url:"/pro/insert",
				data:{pname:pname, price:price},
				success:function(){
					alert("등록이 완료되었습니다.");
					$(frm2.pname).val("");
					$(frm2.price).val("");
					page = 1;
					query = "";
					getList();
				}
			});
		} else {
			alert("등록이 취소되었습니다.");	
		}
	}
});
</script>