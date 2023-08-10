<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#total, #orderTotal {
	font-size: 20px;
}
</style>   
 
<div class="row my-5" id="page_cart">
	<div class="col">
		<h1 class="text-center mb-5">장바구니</h1>
		<div id="div_cart"></div>
		
	</div>
</div>
<jsp:include page="order.jsp"/>


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
			<td><input type="checkbox" class="chk" goods="{{toString @this}}"></td>
			<td class="gid">{{gid}}</td>
			<td><img src="{{image}}" width="50px"></td>
			<td class="text-truncate" style="max-width:200px">{{title}}</td>
			<td>{{sum price 1}}</td>
			<td><input class="qnt" value={{qnt}} size=5 oninput="isNumber(this)">&nbsp;
				<button class="btn btn-secondary btn-sm btn-update">수정</button>
			</td>
			<td>{{sum price qnt}}</td>
			<td><button class="btn btn-danger btn-sm" gid="{{gid}}">삭제</button></td>
		</tr>
	{{/each}}
		<tr>
			<td colspan="8" class="text-end" id="total"><b>총합계: </b><span id="sum">0</span></td>
		</tr>
	</table>
	<div class="text-center">
		<button class="btn btn-primary px-5 mt-3" id="btn-order">주문하기</button>
	</div>
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
	
	Handlebars.registerHelper("toString", function(goods) {
		return JSON.stringify(goods);
});
</script>
<script>
	getList();

	const uid = "${user.uid}"
	
	$("#div_cart").on("click",  "#btn-order", function(){
		if(uid == ""){ // 로그인이 안된경우
			location.href = "/user/login?target=/cart/list";
		} else { // 로그인이 된경우
			const chk = $("#div_cart .chk:checked").length;
			if(chk == 0){
				alert("주문할 상품을 선택하세요!");
			} else {
				let data =[];
				$("#div_cart .chk:checked").each(function(){
					const goods = $(this).attr("goods");
					data.push(JSON.parse(goods));
				});
				getOrder(data);
				$("#page_order").show();
				$("#page_cart").hide();
			}
		}
	});
	
	// 각 행의 체크박스를 클릭한 경우
	$("#div_cart").on("click", ".chk", function(){
		const all = $("#div_cart .chk").length;
		const chk = $("#div_cart .chk:checked").length;
		if(all == chk){
			$("#div_cart #all").prop("checked", true);
		} else {
			$("#div_cart #all").prop("checked", false);
		}
		getSum();
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
		getSum();
	});
	
	function getSum(){
		let sum = 0;
		$("#div_cart .chk:checked").each(function(){
			const tr = $(this).parent().parent();
			const price  = tr.attr("price");
			const qnt = tr.find(".qnt").val();
			sum += price*qnt;
		});
		$("#sum").html("<b>" + sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원</b>");
	}
	
	$("#div_cart").on("click", ".btn-update", function(){
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
				if(data.length != 0){
					const temp = Handlebars.compile($("#temp_cart").html());
					$("#div_cart").html(temp(data));
				} else {
					$("#div_cart").html("<h4 class='text-center'>담은 상품이 없습니다.</h4>");
				}
			}
		});
	}
</script>