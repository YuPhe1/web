<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">주문목록</h1>
			<div class="row">
			<div class="col-md-2 mb-4">
				<select class="form-select status" id="sel-status">
					<option value="0">결제대기중</option>
					<option value="1">결제완료</option>
					<option value="2">배송준비중</option>
					<option value="3">배송중</option>
					<option value="4">배송완료</option>
					<option value="" selected>모든구매</option>
				</select>
			</div>
			<div class="col-md-6"></div>
			<form name="frm" class="col-md-4 text-end">
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
			</div>
		<div id="div_purchase"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_purchase" type="x-handlebars-template">
	<table class="table">
		<tr class="table-dark text-center">
			<th>주문번호</th>
			<th>주문자</th>
			<th>전화번호</th>
			<th>배송지</th>
			<th>가격</th>
			<th>주문일</th>
			<th colspan="2">주문상태</th>
		</td>
		{{#each .}}
			<tr class="text-center">
				<td class="pid"><a href="/purchase/read?pid={{pid}}">{{pid}}</a></td>
				<td>{{uname}}({{uid}})</td>
				<td>{{rphone}}</td>
				<td class="text-start text-truncate" style="max-width:150px">{{raddress1}}</td>
				<td class="text-end">{{formatPrice purSum}}</td>
				<td>{{purDate}}</td>
				<td>
					<select class="form-select status">
						<option value="0" {{select status 0}}>결제대기중</option>
						<option value="1" {{select status 1}}>결제완료</option>
						<option value="2" {{select status 2}}>배송준비중</option>
						<option value="3" {{select status 3}}>배송중</option>
						<option value="4" {{select status 4}}>배송완료</option>

					</select>
				</td>
				<td><button class="btn btn-secondary btn-sm btn-update">상태변경</button></td>
			</tr>
		{{/each}}
	</table>
</script>
<script>
	Handlebars.registerHelper("formatPrice", function(price){
		return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	})
	
	Handlebars.registerHelper("select", function(status, value){
		if(status==value) return "selected";
	})
</script>
<script>
	let page = 1;
	let key = $(frm.key).val();
	let query = $(frm.query).val();
	let query2 = $("#sel-status").val();
	getTotal();
	
	console.log(query2);
	// 상태sel을 바꿨을 때
	$("#sel-status").on("change", function(){
		query2 = $(this).val();
		getTotal();
	});
	// 상태변경버튼 클릭
	$("#div_purchase").on("click", ".btn-update", function(){
		const tr = $(this).parent().parent();
		const pid = tr.find(".pid").text();
		const status = tr.find(".status").val();
		//alert(pid + "..." + status);
		if(confirm("상태를 변경하실래요?")){
			// 상태변경
			$.ajax({
				type:"post",
				url:"/purchase/update",
				data:{pid, status},
				success:function(){
					alert("상태가 변경되었습니다.");
					getList();
				}
			})
		}
	});
	
	
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
		first: '<<', // 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev: '<', // 이전 페이지 버튼에 쓰여있는 텍스트
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
			data:{page:page, query:query, key:key, query2:query2},
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
			data: { query: query, key: key, query2:query2},
			success: function(data) {
				//console.log(data);
				if (data != 0) {
					const totalPages = Math.ceil(data / 5);
					$("#pagination").twbsPagination("changeTotalPages",
						totalPages, 1);
				} else {
					$("#div_purchase").html("<h3 class='text-center'>검색 결과가 없습니다.</h3>");
				}
				if(data > 5){
					$("#pagination").show();
				} else {
					$("#pagination").hide();
				}
			}
		});
	}
</script>