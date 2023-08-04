<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">수강신청</h1>
		<div class="card p-3">
			<div class="row">
				<div class="col">학생번호: ${vo.scode}</div>
				<div class="col">학생이름: ${vo.sname}</div>
				<div class="col">학생학과: ${vo.dept}</div>
				<div class="col">지도교수: ${vo.pname} (${vo.advisor})</div>
			</div>
		</div>
		<hr>
		<div class="card p-3 mb-3">
			<div class="row">
				<div class="col" id="div_cou">
				</div>
				<div class="col-2 text-end ">
					<button class="btn btn-primary" id="btn-enroll">수강신청</button>
				</div>
			</div>
		</div>
		<h2 class="text-center mb-3">현재 수강중인 강의</h2>
		<div id="div_enroll">
		</div>
	</div>
</div>
<script id="temp_cou" type="text/x-handlebars-template">
	<select class="form-select" id="lcode">
		{{#each .}}
			<option value="{{lcode}}" {{dis persons capacity}}>{{lcode}}){{lname}}:{{instructor}} 강의실-{{room}} 수강인원-{{persons}}/{{capacity}}</option>
		{{/each}}
	</select>
</script>

<script id="temp_enroll" type="text/x-handlebars-template">
	<table class="table">
		<tr class="table-dark">
			<td>강의코드</td>
			<td>강의명</td>
			<td class="text-center">강의시수</td>
			<td class="text-center">강의실</td>
			<td class="text-center">점수</td>
			<td class="text-center">강의교수</td>
			<td class="text-center">신청일</td>
			<td class="text-center">수강인원/최대인원</td>
			<td class="text-center">수강취소</td>
		</tr>
		{{#each .}}
		<tr>
			<td>{{lcode}}</td>
			<td>{{lname}}</td>
			<td class="text-center">{{hours}}</td>
			<td class="text-center">{{room}}</td>
			<td class="text-center">{{grade}}</td>
			<td class="text-center">{{pname}}</td>
			<td class="text-center">{{edate}}</td>
			<td class="text-center">{{persons}}/{{capacity}}</td>
			<td class="text-center"><button class="btn btn-danger btn-sm" lcode={{lcode}}>수강취소</button></td>
		</tr>
		{{/each}}
	</table>
</script>

<script>
	Handlebars.registerHelper("dis", function(persons, capacity){
		if(persons >= capacity){
			return "disabled";
		}
	})
</script>
<script>
	const scode = "${vo.scode}";
	getList();
	getSelect();
	
	$("#div_enroll").on("click", ".btn-danger", function(){
		const lcode = $(this).attr("lcode");
		if(confirm(lcode+"강좌를 수강취소하실래요?")){
			$.ajax({
				type:"post",
				url:"/enroll/delete",
				data:{scode:scode, lcode:lcode},
				success:function(){
					alert("수강이 취소되었습니다.");
					getList();
					getSelect();
				}
			});
		}
	});
	
	$("#btn-enroll").on("click", function(){
		const lcode=$("#lcode").val();
		if(confirm(lcode + "강좌를 수강신청하실래요?")){
			$.ajax({
				type:"get",
				data:{scode:scode, lcode:lcode},
				url:"/enroll/insert",
				dataType:"json",
				success:function(data){
					if(data == 0){
						alert("수강신청이 완료되었습니다.");
						getList();
						getSelect();		
					} else if(data == -1){
						alert("정원이 꽉 찼습니다.");
						Location.href="/stu/enroll";
					} else {
						alert("이미 신청한 강의입니다.");
					}
				}
			});
		}
	})
	function getList(){
		$.ajax({
			type:"get",
			data:{scode:scode},
			url:"/stu/enroll.json",
			dataType:"json",
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_enroll").html());
				const html = temp(data);
				$("#div_enroll").html(html);
			}
		});	
	}
	
	function getSelect(){
		$.ajax({
			type:"get",
			url:"/cou/all.json",
			dataType:"json",
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_cou").html());
				const html = temp(data);
				$("#div_cou").html(html);
			}
		});	
	}
</script>