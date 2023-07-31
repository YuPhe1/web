<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">지역</h1>
		<div class="row justify-content-end">
			<div class="col">
				<span>검색수: </span>
				<span id="total"></span>
			</div>
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group mb-3">
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_local"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_local" type="text/x-handlebars-template">
	<table class="table table-striped">
		<tr class="table-dark">
			<td>id</td>
			<td>lid</td>
			<td>이름</td>
			<td>주소</td>
			<td>전화번호</td>
		</tr>
		{{#each .}}
		<tr>
			<td>{{id}}</td>
			<td>{{lid}}</td>
			<td>{{lname}}</td>
			<td>{{laddress}}</td>
			<td>{{lphone}}</td>
		</tr>
		{{/each}}
	</table>
</script>

<script>

	let qpage = 1;
	let query = $(frm.query).val();
	
	//검색한경우
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getTotal();
	});
	
	// pagination
	$('#pagination').twbsPagination({
	    totalPages:1,	// 총 페이지 번호 수
	    visiblePages: 7,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<i class="bi bi-chevron-double-left"></i>',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<i class="bi bi-caret-left"></i>',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '<i class="bi bi-caret-right"></i>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '<i class="bi bi-chevron-double-right"></i>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, page) {
	    	qpage = page;
	    	getList(page);
	    }
	});
	
	
	// 목록 출력
	function getList(page){
		$.ajax({
			type:"get",
			url:"/local/list.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_local").html());
				const html = temp(data);
				$("#div_local").html(html);
			}
		});
	}
	
	getTotal();
	
	// 전체 상품의 개수
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/local/total",
			data:{query:query},
			success:function(data){
				// alert(data);
				$("#total").html(data);
				if(data != 0) {
					const totalPages= Math.ceil(data/5);
					$("#div_local").show();
					$("#pagination").show();
		    		$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
				} else {
					alert("검색 결과가 없습니다.");
					$(frm.query).val("");
					$("#div_local").hide();
					$("#pagination").hide();
				}
			}
		});
	}
</script>