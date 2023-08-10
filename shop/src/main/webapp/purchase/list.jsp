<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">주문목록</h1>
			<form name="frm" class="col-6 col-md-4 text-end">
				<div class="input-group mb-3">
					<select name="key" class="form-select">
						<option value="uid">회원아이디</option>
						<option value="uname" selected>회원이름</option>
						<option value="raddress1">배송지주소</option>
						<option value="rphone">회원전화</option>
					</select>&nbsp;
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		<div id="div_purchase"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_purchase" type="x-handlebars-template">
	<table class="table">
		<tr class="table-dark">
			<td>주문번호</td>
			<td>주문자</td>
			<td>전화번호</td>
			<td>배송지</td>
			<td>가격</td>
			<td>주문일</td>
		</td>
		{{#each .}}
			<tr>
				<td>{{pid}}</td>
				<td>{{uname}}</td>
				<td>{{rphone}}</td>
				<td>{{raddress1}}</td>
				<td>{{purSum}}</td>
				<td>{{purDate}}</td>
			</tr>
		{{/each}}
	</table>
</script>

<script>
	let page = 1;
	let key = $(frm.key).val();
	let query = $(frm.query).val();
	
	getTotal();
	
	$(frm).on("submit", function(e) {
		e.preventDefault();
		query = $(frm.query).val();
		key = $(frm.key).val();
		getTotal();
	});
	
	// pagination
	$('#pagination').twbsPagination({
		totalPages: 1, // 총 페이지 번호 수
		visiblePages: 7, // 하단에서 한번에 보여지는 페이지 번호 수
		startPage: 1, // 시작시 표시되는 현재 페이지
		initiateStartPageClick: false, // 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		first: '<', // 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev: '<<', // 이전 페이지 버튼에 쓰여있는 텍스트
		next: '>', // 다음 페이지 버튼에 쓰여있는 텍스트
		last: '>>', // 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick: function(event, curPage) {
			page = curPage;
			getList();
		}
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/purchase/list.json",
			data:{page:page, query:query, key:key},
			dataType:"json",
			success:function(data){
				const temp = Handlebars.compile($("#temp_purchase").html());
				$("#div_purchase").html(temp(data));
			}
		});	
	}
	
	// 전체 페이지 수
	function getTotal() {
		$.ajax({
			type: "get",
			url: "/purchase/total",
			data: { query: query, key: key },
			success: function(data) {
				console.log(data);
				if (data != 0) {
					const totalPages = Math.ceil(data / 5);
					$("#pagination").twbsPagination("changeTotalPages",
						totalPages, 1);
				} else {
					alert("검색내용이 없습니다!");
					$(frm.query).val("");
					query="";
					getTotal();
				}
			}
		});
	}
</script>