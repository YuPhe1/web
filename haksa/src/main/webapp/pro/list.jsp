<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-4">교수목록</h1>
		<div class="row justify-content-end">
			<div class="col">
				<span>검색수: </span> <span id="total"></span>
			</div>
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group mb-3">
					<select name="key" class="form-select" aria-label="Default select example">
						<option value="pcode">교수번호</option>
						<option value="pname" selected>교수이름</option>
						<option value="dept">교수학과</option>
						<option value="title">교수직급</option>
					</select>&nbsp;
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_pro"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_pro" type="text/x-handlebars-tempate">
	<table class="table table-striped">
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
			<td>{{pname}}</td>
			<td>{{dept}}</td>
			<td>{{hiredate}}</td>
			<td>{{title}}</td>
			<td class="text-end">{{fsalary}}</td>
		</tr>
	{{/each}}
	</table>
</script>
<script src="/js/script.js"></script>
<script>
	let query = $(frm.query).val();
	let key = $(frm.key).val();
	let url = "pro";
	$(frm).on("submit", function(e){
		e.preventDefault();
		query = $(frm.query).val();
		key = $(frm.key).val();
		getTotal();
	});
	getTotal();
</script>