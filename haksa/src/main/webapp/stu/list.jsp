<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-4">학생목록</h1>
		<div class="row justify-content-end">
			<div class="col">
				<span>검색수: </span> <span id="total"></span>
			</div>
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group mb-3">
					<select name="key" class="form-select" aria-label="Default select example">
						<option value="scode">학번</option>
						<option value="sname" selected>이름</option>
						<option value="dept">학과</option>
						<option value="year">학년</option>
						<option value="pname">전담교수이름</option>
					</select>&nbsp;
					<input name="query" placeholder="검색" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_stu"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_stu" type="text/x-handlebars-tempate">
	<table class="table table-striped">
		<tr class="table-dark">
			<td>학번</td>
			<td>이름</td>
			<td>학과</td>
			<td>학년</td>
			<td>생일</td>
			<td>전담교수번호</td>
			<td>전담교수</td>
		</tr>
	{{#each .}}
		<tr>
			<td>{{scode}}</td>
			<td>{{sname}}</td>
			<td>{{dept}}</td>
			<td>{{year}}학년</td>
			<td>{{birthday}}</td>
			<td>{{advisor}}</td>
			<td>{{pname}}</td>
		</tr>
	{{/each}}
	</table>
</script>
<script src="/js/script.js"></script>
<script>
	let query = $(frm.query).val();
	let key = $(frm.key).val();
	let url = "stu";

	getTotal();
</script>