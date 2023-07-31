<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/pro/insert.jsp"/>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품목록</h1>
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
			<td>삭제</td>
			<td>수정</td>
		</tr>
		{{#each .}}
		<tr>
			<td class="code">{{pcode}}</td>
			<td><input value="{{pname}}" class="name"></td>
			<td><input value="{{price}}" class="price"><span class="fprice text-end">{{fprice}}</span></td>
			<td>{{fdate}}</td>
			<td><button class="btn btn-danger btn-sm" pcode="{{pcode}}">삭제</button></td>
			<td><button class="btn btn-success btn-sm" pcode="{{pcode}}">수정</button></td>
		</tr>
		{{/each}}
	</table>
</script>
<script>

	let qpage = 1;
	let query = $(frm.query).val();
	
	// 가격 수정중 표시
	$("#div_pro").on("keyup", ".price", function(){
		let price = $(this).val();
		let td = $(this).parent();
		if(price.replace(/[0-9]/g, '')){
			td.find(".fprice").html('<span style="color:red">숫자로 입력하세요</span>');
		} else {
			td.find(".fprice").html(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
		}
	})
	
	// 수정버튼을 클릭한 경우
	$("#div_pro").on("click", ".btn-success", function(){
		const row = $(this).parent().parent();
		const pcode = row.find(".code").html();
		const pname = row.find(".name").val();
		const price = row.find(".price").val();
		if(pname == ""){
			alert("이름을 입력하세요!");
			row.find(".name").focus();
		} else if(price == ""){
			alert("가격을 입력하세요!");
			row.find(".price").focus();
		} else if(price.replace(/[0-9]/g, '')){
			alert("가격을 숫자로 입력하세요");
			row.find(".price").val("");
			row.find(".price").focus();
		} else {
			if(confirm("상품을 수정하시겠습니까?")){
				$.ajax({
					type:"post",
					url:"/pro/update",
					data:{pcode:pcode, pname:pname, price:price},
					success:function(){
						alert("수정완료!");
						getList(qpage);
					}
				})
			}
		}
	});
	
	// 삭제버튼을 클릭한 경우
	$("#div_pro").on("click", ".btn-danger", function(){
		const code = $(this).attr("pcode");
		const name = $(this).parent().parent().find(".name").text();
		if(confirm(code+"번 "+ name + " 상품을 삭제하실래요?")){
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{pcode:code},
				success:function(){
					alert("삭제가 완료되었습니다.");
					getTotal();
				}
			});
		}
	});
	
	// 검색한경우
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
	
	// 전체 상품의 개수
	function getTotal(){
		$.ajax({
			type:"get",
			url:"/pro/total",
			data:{query:query},
			success:function(data){
				// alert(data);
				$("#total").html(data);
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