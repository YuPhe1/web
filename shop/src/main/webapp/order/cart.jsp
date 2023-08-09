<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#total {
	font-size: 20px;
}
</style>   
 
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">장바구니</h1>
		<div id="div_cart"></div>
		<div class="text-center">
			<button class="btn btn-primary px-5" id="btn-order">주문하기</button>
		</div>
	</div>
</div>

<script id="temp_cart" type="text/x-handlebars-template">
	
	<table class="table">
		<tr class="table-dark">
			<th><input type="checkbox" id="all"></th>
			<th>상품번호</th>
			<th>이미지</th>
			<th>상품이름</th>
			<th>가격</th>
			<th class="text-center">수량</th>	
			<th class="text-center">합계</th>	
			<th>삭제</th>
		</tr>
	{{#each .}}
		<tr class="tr" price={{price}}>
			<td><input type="checkbox" class="chk"></td>
			<td class="gid">{{gid}}</td>
			<td><img src="{{image}}" width="50px"></td>
			<td>{{title}}</td>
			<td>{{sum price 1}}</td>
			<td><input class="qnt" value={{qnt}} size=5 oninput="isNumber(this)">&nbsp;
				<button class="btn btn-secondary btn-sm">수정</button>
			</td>
			<td>{{sum price qnt}}</td>
			<td><button class="btn btn-danger btn-sm" gid="{{gid}}">삭제</button></td>
		</tr>
	{{/each}}
		<tr>
			<td colspan="8" class="text-end" id="total"><b>총합계: </b><span id="sum">0</span></td>
		</tr>
	</table>
</script>
<script>
	/* let total = 0; */
	
	Handlebars.registerHelper("sum", function(price, qnt){
		return (price*qnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	})
	/*Handlebars.registerHelper("setTotal", function(){
		total = 0;
	})
	
	Handlebars.registerHelper("getTotal", function(price, qnt){
		total += price*qnt;
	})
	
	Handlebars.registerHelper("fmtTotal", function(){
		return total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	}) */
</script>
<script>
	getList();

	// 각 행의 체크박스를 클릭한 경우
	$("#div_cart").on("click", ".chk", function(){
		const all = $("#div_cart .chk").length;
		const chk = $("#div_cart .chk:checked").length;
		if(all == chk){
			$("#div_cart #all").prop("checked", true);
		} else {
			$("#div_cart #all").prop("checked", false);
		}
	});
	
	// 전체 선택을 체크한 경우
	$("#div_cart").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", true);
			});
		} else {
			$("#div_cart .chk").each(function(){
				$(this).prop("checked", false);
			});
		}
	});
	
	function getSum(){
		let sum = 0;
		$("#div_cart .tr").each(function(){
			const price  = $(this).attr("price");
			const qnt = $(this).find(".qnt").val();
			sum += price*qnt;
		});
		$("#sum").html("<b>" + sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원</b>");
	}
	
	$("#div_cart").on("click", ".btn-secondary", function(){
		const row = $(this).parent().parent();
		const gid = row.find(".gid").text();
		const qnt = row.find(".qnt").val();
		if(confirm(gid+" 상품의 수량을 " + qnt + "개로 변경하실래요?")){
			$.ajax({
				type:"get",
				url:"/cart/update",
				data:{gid:gid, qnt:qnt},
				success:function(){
					getList();
				}
			});
		}
	});
	function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}
	
	$("#div_cart").on("click", ".btn-danger", function(){
		const gid = $(this).attr("gid");
		if(confirm(gid+"번 상품을 삭제하실래요?")){
			$.ajax({
				type:"get",
				url:"/cart/delete",
				data:{gid:gid},
				success:function(){
					alert("상품을 삭제했습니다.");
					getList();
				}
			});
		}
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/cart/list.json",
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_cart").html());
				$("#div_cart").html(temp(data));
				getSum();
			}
		});
	}
</script>