<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-4">교수목록</h1>
		<div class="row">
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group mb-3">
					<select name="key" class="form-select">
						<option value="pcode">교수번호</option>
						<option value="pname" selected>교수이름</option>
						<option value="dept">교수학과</option>
						<option value="title">교수직급</option>
					</select>&nbsp; <input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
			<div class="col text-end">
				<button class="btn btn-primary" id="btn_insert">교수등록</button>
			</div>
		</div>
		<div id="div_pro"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>
<!-- 교수등록Modal -->
<div class="modal fade" id="insert" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">교수등록</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<jsp:include page="/pro/insert.jsp" />
			</div>
		</div>
	</div>
</div>

<script id="temp_pro" type="text/x-handlebars-tempate">
	<table class="table">
		<tr class="table-dark">
			<td>교수번호</td>
			<td>이름</td>
			<td>학과</td>
			<td>고용일</td>
			<td>직급</td>
			<td class="text-end">급여</td>
		</tr>
	{{#each .}}
		<tr>
			<td>{{pcode}}</td>
			<td><a href="/pro/update?pcode={{pcode}}">{{pname}}</a></td>
			<td>{{dept}}</td>
			<td>{{hiredate}}</td>
			<td>{{title}}</td>
			<td class="text-end">{{fsalary}}</td>
		</tr>
	{{/each}}
	</table>
</script>
<script src="/js/list.js"></script>
<script>
	let url = "pro";
	getTotal();

	$("#btn_insert").on("click", function() {
		$("#insert").modal("show");
	})
	
</script>