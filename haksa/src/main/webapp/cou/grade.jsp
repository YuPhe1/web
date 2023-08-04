<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	<div class="col">
		<h1 class="text-center mb-5">점수입력</h1>
		<div class="card p-3">
			<div class="row">
				<div class="col">강의번호:${vo.lcode}</div>
				<div class="col">강의명:${vo.lname}</div>
				<div class="col">강의교수:${vo.pname}</div>
				<div class="col">강의시수:${vo.hours}</div>
				<div class="col">수강인원:${vo.persons}/${vo.capacity}</div>
			</div>
		</div>
		<hr>
		<div id="div_grade"></div>
	</div>
</div>

<script id="temp_grade" type="text/x-handlebars-template">
	<table class="table">
		<tr>
			<td>학번<td>
			<td>이름<td>
			<td>학과<td>
			<td>수강신청일<td>
			<td>점수<td>
			<td>수정</td>
		</tr>
	{{#each .}}
		<tr>
			<td class="scode">{{scode}}<td>
			<td>{{sname}}<td>
			<td>{{dept}}<td>
			<td>{{edate}}<td>
			<td width="100"><input class="grade" value="{{grade}}" oninput="isNumber(this)"><td>
			<td><button class="btn btn-primary btn-sm">수정</button></td>
		</tr>
	{{/each}}
	</table>
</script>
<script>
	const lcode = "${vo.lcode}"
	getList();
	
	$("#div_grade").on("click", ".btn-primary", function(){
		const row =$(this).parent().parent();
		const scode = row.find(".scode").text();
		const grade = row.find(".grade").val();
		if(confirm(scode+"학생의 점수를 " + grade+"로 수정하실래요?")){
			$.ajax({
				type: "post",
				url: "/grade/update",
				data: {lcode:lcode, scode:scode, grade:grade},
				success: function() {
					// console.log(data);
					alert("점수가 수정되었습니다.");
					getList();
				}
			});
		}
	})
	
	// 숫자인 경우에만 입력
	function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}
	
	function getList(page) {
		$.ajax({
			type: "get",
			url: "/cou/grade.json",
			data: {lcode:lcode},
			dataType: "json",
			success: function(data) {
				// console.log(data);
				const temp = Handlebars.compile($("#temp_grade").html());
				const html = temp(data);
				$("#div_grade").html(html);
			}
		});
	}
</script>