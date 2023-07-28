<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/pro/insert.jsp"/>
<div class="row">
	<div class="col">
		<h1 class="text-center my-5">상품목록</h1>
		<div class="row justify-content-end mb-3">
			<div class="col-6 col-md-8 col-lg-9">
				<span id="total" class="mx-4">총: 20건</span>
			</div>
			<form name="frm" class="col-6 col-md-4 col-lg-3">
				<div class="input-group">
					<input class="form-control" placeholder="검색어" name="query">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_pro"></div>
		<div id="pagebtn" class="text-center">
			<button id="prev" class="btn btn-outline-info">이전</button>
			<span id=page>1</span>
			<button id="next" class="btn btn-outline-info">다음</button>
		</div>
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
	{{#each items}}
		<tr>
			<td class="pcode">{{pcode}}</td>
			<td><input value="{{pname}}" class="pname"></td>
			<td><input value="{{price}}" class="price" size="10"><span class="fprice">{{fprice}}</span></td>
			<td>{{fdate}}</td>
			<td><button class="btn btn-danger btn-sm" pcode="{{pcode}}">삭제</button></td>
			<td><button class="btn btn-info btn-sm" pcode="{{pcode}}">수정</button></td>
		</tr>
	{{/each}}
	</table>
</script>
<script>
	let page = 1;
	let last = 0;
	let size = 5;
	let query = "";
	getList();
	
	$("#div_pro").on("keydown", ".price", function(){
		let price = $(this).val();
		let td = $(this).parent();
		td.find(".fprice").html(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
	})
	
	$("#div_pro").on("click", ".btn-info", function(){
		let tr = $(this).parent().parent();
		let pcode = tr.find(".pcode").text();
		let pname = tr.find(".pname").val();
		let price = tr.find(".price").val();
		if(pname==""){
			alert("상품이름을 입력하세요!");
			tr.find(".pname").focus();
		} else if(price==""){
			alert("상품가격을 입력하세요!");
			tr.find(".price").focus();
		} else if(price.replace(/[0-9]/g, '')) {
			alert("상품가격을 숫자로 입력하세요!");
			tr.find(".price").val("");
		} else {
			if(confirm("상품코드:"+pcode+"\n상품이름:"+pname+"\n상품가격:"+price+"\n수정하실래요?")){
				$.ajax({
					type:"post",
					url:"/pro/update",
					data:{pcode:pcode, pname:pname, price:price},
					success:function(){
						alert("수정이 완료되었습니다.");
						getList();
					}
				});
			} else {
				alert("수정이 취소되었습니다.");
				getList();
			}
		}
		
	});
	
	$("#div_pro").on("click", ".btn-danger", function(){
		let pcode = $(this).attr("pcode");
		if(confirm(pcode +"번 상품을 삭제하실래요?")){
			$.ajax({
				type:"post",
				url:"/pro/delete",
				data:{pcode:pcode},
				success:function(){
					alert("삭제완료되었습니다.");
					getList();
				}
			});
		} else {
			alert("삭제가 취소되었습니다.");
		}
	});
	// 상품 검색
	$(frm).on("submit", function(e) {
		e.preventDefault();
		query = $(frm.query).val();
		page = 1;
		getList();
	});
	// 이전 버튼
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	// 이전 버튼
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	function getList() {
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			dataType:"json",
			data:{page:page, size:size, query:query},
			success:function(data){
				// console.log(data);			
				const temp = Handlebars.compile($("#temp_pro").html());
				const html = temp(data);
				$("#div_pro").html(html);
				
				last = Math.ceil(data.total / size);
				
				$("#page").html("<b> " + page + " / " + last + "</b>");
				
				$("#total").html("총: " +data.total+"건");
				
				if(page == 1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
				
				if(page == last) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false);
				
				if(last == 0) $("#pagebtn").hide();
				else $("#pagebtn").show();
				
				// if(last == 0) $("#pagebtn").html("<h3>검색한 상품이 없습니다.</h3>");
			}
		});
	}
</script>