<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row justify-content-center my-5">
	<div class="col-md-8">
		<h1 class="text-center mb-5">상품등록</h1>
		<form name="frm1" class="card p-3">
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon1">상품이름</span>
				<input class="form-control" name="pname">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text" id="basic-addon1">상품가격</span>
				<input class="form-control" name="price">
			</div>
			<div class="text-center mb-2">
				<input type="submit" class="btn btn-primary" value="상품등록">
				<input type="reset" class="btn btn-secondary" value="등록취소">
			</div>
		</form>
	</div>
</div>
<hr>

<script>
$(frm1).on("submit", function(e){
	e.preventDefault();
	const name = $(frm1.pname).val();
	const price = $(frm1.price).val();
	if(name == ""){
		alert("이름을 입력하세요!");
		$(frm1.pname).focus();
	} else if(price == ""){
		alert("가격을 입력하세요!");
		$(frm1.price).focus();
	} else if(price.replace(/[0-9]/g, '')){
		alert("가격을 숫자로 입력하세요");
		$(frm1.price).val("");
		$(frm1.price).focus();
	} else {
		if(confirm("상품을 등록하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"/pro/insert",
				data:{pname:name, price:price},
				success:function(){
					alert("등록완료!");
					getTotal();
					$(frm1.pname).val("");
					$(frm1.price).val("");
				}
			})
		}
	}
});

</script>