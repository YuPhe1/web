<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">회원목록</h1>
			<form name="frm" class="col-6 col-md-4 text-end">
				<div class="input-group mb-3">
					<select name="key" class="form-select">
						<option value="uid">아이디</option>
						<option value="uname" selected>회원이름</option>
						<option value="address1">회원주소</option>
						<option value="phone">회원전화</option>
					</select>&nbsp;
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		<div id="div_user"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_user" type="text/x-handlebars-tempate">
	{{#each .}}
		<div class="card p-3 mb-2">
			<div class="row">	
				<div class="col-md-2 col-2 text-center">
					<img src="{{getImage photo}}" width="80%">
				</div>
				<div class="col">
					<div>{{uname}} ({{uid}})</div>
					<div>{{address1}} {{address2}}</div>
					<div>{{phone}}</div>
				</div>
			</div>
		</div>
	{{/each}}
</script>
<script>
Handlebars.registerHelper("getImage", function(thum){
    if(thum){
        return thum;
    } else {
        return "https://via.placeholder.com/100x100"
    }
});

</script>
<script>
	let page = 1;
	let query = $(frm.query).val();
	let key = $(frm.key).val();
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
		first: '<i class="bi bi-chevron-double-left"></i>', // 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev: '<i class="bi bi-caret-left"></i>', // 이전 페이지 버튼에 쓰여있는 텍스트
		next: '<i class="bi bi-caret-right"></i>', // 다음 페이지 버튼에 쓰여있는 텍스트
		last: '<i class="bi bi-chevron-double-right"></i>', // 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick: function(event, page) {
			getList(page);
		}
	});

	// 목록 
	function getList(page) {
		$.ajax({
			type: "get",
			url: "/user/list.json",
			data: { page: page, query: query, key: key },
			dataType: "json",
			success: function(data) {
				// console.log(data);
				const temp = Handlebars.compile($("#temp_user").html());
				const html = temp(data);
				$("#div_user").html(html);
			}
		});
	}

	// 전체 페이지 수
	function getTotal() {
		$.ajax({
			type: "get",
			url: "/user/total",
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