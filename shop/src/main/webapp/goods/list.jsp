<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.goods {
		cursor: pointer;
	}
	.goods:hover {
		background: lightgray;
	}
</style>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<div class="row mb-4 justify-content-end">
			<div class="col">
				<a href="/goods/insert">
					<button class="btn btn-primary">상품등록</button>
				</a>
			</div>
			<form name="frm" class="col-4">
				<div class="input-group">
					<input name="query" class="form-control" value="">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_goods"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_goods" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-dark">
			<td>상품번호</td>
			<td>이미지</td>
			<td>제목</td>
			<td class="text-center">가격</td>
			<td class="text-center">브랜드</td>
			<td></td>
		</tr>
		{{#each .}}
		<tr class="goods" gid={{gid}}>
			<td class="gid">{{gid}}</td>
			<td><img class="image" src="{{image}}" width="50px"></td>
			<td>{{title}}</td>
			<td class="text-end">{{formatPrice price}}</td>
			<td class="text-center">{{maker}}</td>
			<td><button class="btn btn-danger btn-sm btn-delete">삭제</button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	Handlebars.registerHelper("formatPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	})
</script>
<script>
	let page = 1;
	let query=$(frm.query).val();
	
	$("#div_goods").on("click", ".goods td:not(:last-child)", function(){
		const gid = $(this).parent().attr("gid");
		location.href="/goods/update?gid=" + gid;
	});
	
	getTotal();
	
	$("#div_goods").on("click", ".btn-delete", function(){
		const row = $(this).parent().parent();
		const gid = row.find(".gid").text();
		const image = row.find(".image").attr("src");
		if(confirm("해당 상품을 삭제하실래요?")){
			$.ajax({
				type:"post",
				url:"/goods/delete",
				data:{gid:gid, image:image},
				success:function(){
					alert("상품이 삭제되었습니다.");
					getTotal();
				}
			})
		}
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getTotal();
	});
	
	// pagination
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 5,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, curPage) {
	    	page = curPage;
	    	getList();
	    }
	});
	
	// 전체 상품의 개수
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/goods/total",
			data:{query:query},
			success:function(data){
				// alert(data);
				$("#total").html(data);
				if(data != 0) {
					const totalPages= Math.ceil(data/6);
		    		$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
				} else {
					$("#div_goods").html("<h3 class='text-center'>검색 결과가 없습니다.</h3>");
				}
				if(data > 6){
					$("#pagination").show();
				} else {
					$("#pagination").hide();
				}
			}
		});
	}
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/goods/list.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_goods").html());
				const html = temp(data);
				$("#div_goods").html(html);
			}
		});
	}
</script>