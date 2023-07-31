<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
		<div class="row justify-content-end">
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group mb-3">
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_pro"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_pro" type="text/x-handlebars-template">
	<table class="table table-striped">
		<tr class="table-dark">
			<td>상품번호</td>
			<td>상품명</td>
			<td>가격</td>
			<td>등록일</td>
		</tr>
		{{#each .}}
		<tr>
			<td>{{pcode}}</td>
			<td>{{pname}}</td>
			<td>{{fprice}}</td>
			<td>{{fdate}}</td>
		</tr>
		{{/each}}
	</table>
</script>
<script>

	let query = $(frm.query).val();
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getTotal();
	});
	
	$('#pagination').twbsPagination({
	    totalPages:1,	// 총 페이지 번호 수
	    visiblePages: 7,	// 하단에서 한번에 보여지는 페이지 번호 수
	    startPage : 1, // 시작시 표시되는 현재 페이지
	    initiateStartPageClick: false,	// 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
	    first : '<<',	// 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
	    prev : '<',	// 이전 페이지 버튼에 쓰여있는 텍스트
	    next : '>',	// 다음 페이지 버튼에 쓰여있는 텍스트
	    last : '>>',	// 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
	    onPageClick: function (event, page) {
	    	getList(page);
	    }
	});
	
	function getList(page){
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			data:{page:page, query:query},
			dataType:"json",
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_pro").html());
				const html = temp(data);
				$("#div_pro").html(html);
			}
		});
	}
	
	getTotal();
	
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{query:query},
			success:function(data){
				// alert(data);
				if(data != 0) {
					const totalPages= Math.ceil(data/5);
					$("#div_pro").show();
					$("#pagination").show();
		    		$("#pagination").twbsPagination("changeTotalPages", totalPages, 1);
				} else {
					alert("검색 결과가 없습니다.");
					$(frm.query).val("");
					$("#div_pro").hide();
					$("#pagination").hide();
				}
			}
		});
	}
</script>