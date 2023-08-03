<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-4">학생목록</h1>
		<div class="row">
			<form name="frm" class="col-6 col-md-4">
				<div class="input-group mb-3">
					<select name="key" class="form-select">
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
			<div class="col text-end">
				<button class="btn btn-primary" id="btn-insert">학생등록</button>
			</div>
		</div>
		<div id="div_stu"></div>
		<div id="pagination" class="pagination justify-content-center"></div>
	</div>
</div>
<!-- 학생등록 Modal -->
<div class="modal fade" id="modal-insert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="staticBackdropLabel">학생등록</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<jsp:include page="/stu/insert.jsp"/>
		    </div>
		 </div>
	</div>
</div>
<script id="temp_stu" type="text/x-handlebars-tempate">
	<table class="table">
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
		<tr class="stu" scode={{scode}}>
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
<script src="/js/list.js"></script>
<script>
	let url = "stu";

	getTotal();
	
	$("#div_stu").on("click", ".stu", function(){
		const scode= $(this).attr("scode");
		location.href="/stu/update?scode=" + scode;
	});
	
	$("#div_stu").on("mouseover", ".stu", function () {
        $(this).addClass('changeBackgroundColor');
    }).on("mouseout", ".stu", function () {
        $(this).removeClass('changeBackgroundColor');
    });
	 
	$("#btn-insert").on("click", function(){
		$("#modal-insert").modal("show");
	})
</script>