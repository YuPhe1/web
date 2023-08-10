<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	<div class="col">
		<h1 class="text-center my-5">상품검색</h1>
		<div class="row mb-4">
			<form name="frm" class="col-4">
				<div class="input-group">
					<input name="query" class="form-control" value="한빛미디어">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_search"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_search" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-dark">
			<td>이미지</td>
			<td>제목</td>
			<td class="text-center">가격</td>
			<td class="text-center">브랜드</td>
			<td></td>
		</tr>
		{{#each items}}
		<tr goods="{{toString @this}}">
			<td><img src="{{image}}" width="50px"></td>
			<td class="title">{{{title}}}</td>
			<td class="text-end">{{formatPrice lprice}}</td>
			<td class="text-center">{{maker}}</td>
			<td><button class="btn btn-primary btn-sm btn-save">저장</button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>
	Handlebars.registerHelper("formatPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	})
	
	Handlebars.registerHelper("toString", function(goods) {
		return JSON.stringify(goods);
	});
</script>
<script>

	let page = 1;
	let query = "한빛미디어";
	
	getList();

	$("#div_search").on("click", ".btn-save", function(){
		const row = $(this).parent().parent();
		const goods = JSON.parse(row.attr("goods"));
		const title = row.find(".title").text();
		if(confirm(title + "상품을 저장하실래요?")){
			goods["title"] = title;
			// console.log(goods);
			$.ajax({
				type:"post",
				url:"/goods/append",
				data:goods,
				success:function(){
					alert("상품이 저장되었습니다.");
				}
			})
		}
	})
	
	// pagination
	$('#pagination').twbsPagination({
	    totalPages:10,	// 총 페이지 번호 수
	    visiblePages: 10,	// 하단에서 한번에 보여지는 페이지 번호 수
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
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		if(query==""){
			alert("검색어를 입력하세요!");
			$(frm.query).focus();
		} else {
			page = 1;
			getList();
		}
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/goods/search.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				//console.log(data);
				const temp = Handlebars.compile($("#temp_search").html());
				const html = temp(data);
				$("#div_search").html(html);
			}
		})
	}
</script>