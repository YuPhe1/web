<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5" id="page_order" style="display:none;">
	<div class="col">
		<h1 class="text-center mb-5">주문하기</h1>
		<div id="div_order"></div>
		<h1 class="text-center my-5">주문정보</h1>
		<form name="frm" class="card p-3" method="post" action="/purchase/insert">
			<div class="input-group mb-3">
				<span class="input-group-text">주문자</span>
				<input class="form-control" name="uname" value="${user.uname}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주문자전화</span>
				<input class="form-control" name="phone" value="${user.phone}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">주소</span>
				<input class="form-control" name="address1" value="${user.address1}">
				<button id="btn-search" class="btn btn-secondary" type="button">주소검색</button>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">상세주소</span>
				<input class="form-control" name="address2" value="${user.address2}">
			</div>
			<input name="sum" type="hidden">
			<div class="text-center">
				<button class="btn btn-primary px-5">주문하기</button>
			</div>
		</form>
	</div>
</div>
<script id="temp_order" type="text/x-handlebars-template">	
	<table class="table">
		<tr class="table-dark">
			<th>상품번호</th>
			<th>이미지</th>
			<th>상품이름</th>
			<th class="text-center">가격</th>
			<th class="text-center">수량</th>	
			<th class="text-end">합계</th>	
		</tr>
		{{#each .}}
			<tr class="tr"gid="{{gid}}" price="{{price}}" qnt="{{qnt}}">
				<td class="gid">{{gid}}</td>
				<td><img src="{{image}}" width="50px"></td>
				<td class="text-truncate" style="max-width:200px">{{title}}</td>
				<td class="text-end">{{sum price 1}}</td>
				<td class="text-center">{{qnt}}</td>
				<td class="text-end">{{sum price qnt}}</td>
			</tr>
		{{/each}}
		<tr>
			<td colspan="6" class="text-end" id="orderTotal"><b>총합계: </b><span id="orderSum">0</span></td>
		</tr>
	</table>
	
</script>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(confirm("위 상품을 주문하실래요?")){
			$.ajax({
				type:"post",
				url:"/purchase/insert",
				data:{uid:"${user.uid}", address1:$(frm.address1).val(),
					address2:$(frm.address2).val(), phone:$(frm.phone).val(), 
					sum:$(frm.sum).val()},
				success: function(data){
					const pid = data;
					$("#div_order .tr").each(function(){
						const gid = $(this).attr("gid");
						const qnt = $(this).attr("qnt");
						const price = $(this).attr("price");
						$.ajax({
							type:"post",
							url:"/order/insert",
							data:{pid:pid, gid:gid, price:price, qnt:qnt},
							success:function(){
								$.ajax({
									type:"get",
									url:"/cart/delete",
									data:{gid:gid},
									success:function(){}
								});
							}
						});
					});
					alert("주문완료");
					location.href = "/";
				}
			});
		}
	})

	$("#btn-search").on("click", function(){
		new daum.Postcode({
			oncomplete: function(data){
				//console.log(data);
				if(data.buildingName != ""){
					$(frm.address1).val(data.address + " " + data.buildingName);
				} else {
					$(frm.address1).val(data.address);
				}
				$(frm.address2).val("");
			}
		}).open();
	});
	function getOrder(data){
		const temp = Handlebars.compile($("#temp_order").html());
		$("#div_order").html(temp(data));
		getOrderSum();
	}
	function getOrderSum(){
		let sum = 0;
		$("#div_order .tr").each(function(){
			const price  = $(this).attr("price");
			const qnt = $(this).attr("qnt");
			sum += price*qnt;
		});
		$(frm.sum).val(sum);
		$("#orderSum").html("<b>" + sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원</b>");
	}
</script>