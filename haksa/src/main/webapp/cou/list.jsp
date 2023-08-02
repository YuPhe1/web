<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-4">강좌목록</h1>
		<div class="row">
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group mb-3">
					<select name="key" class="form-select">
						<option value="lcode">강좌번호</option>
						<option value="lname" selected>강좌이름</option>
						<option value="room">강의실</option>
						<option value="pname">강의교수</option>
					</select>&nbsp;
					<input name="query" placeholder="검색어" class="form-control">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_cou"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>

<script id="temp_cou" type="text/x-handlebars-tempate">
	<table class="table">
		<tr class="table-dark">
			<td>강좌번호</td>
			<td>강좌이름</td>
			<td class="text-center">시수</td>
			<td class="text-center">강의실</td>
			<td class="text-center">강의교수번호</td>
			<td class="text-center">강의교수</td>
			<td class="text-center">수강인원/최대인원</td>
		</tr>
	{{#each .}}
		<tr>
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td class="text-center">{{hours}}</td>
			<td class="text-center">{{room}}</td>
			<td class="text-center">{{instructor}}</td>
			<td class="text-center">{{pname}}</td>
			<td class="text-center">{{persons}}/{{capacity}}</td>
		</tr>
	{{/each}}
	</table>
</script>
<script src="/js/list.js"></script>
<script>
	let url = "cou";
	getTotal();
</script>