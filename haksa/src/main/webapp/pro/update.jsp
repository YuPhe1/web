<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5 justify-content-center">
	<div class="col card p-4">
		<h1 class="text-center mb-4">교수정보수정</h1>
		<form name="frm_update" method="post" action="/pro/update">
			<div class="input-group mb-2">
				<span class="input-group-text">교수번호</span>
				<input name="pcode" class="form-control" value="${vo.pcode}" readonly>
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수이름</span>
				<input name="pname" class="form-control" value="${vo.pname}">
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수학과</span>
				<select name="dept" class="form-select">
					<option value="전산" <c:out value="${vo.dept=='전산'? 'selected':''}"/>>전자계산학과</option>
					<option value="컴정" <c:out value="${vo.dept=='컴정'? 'selected':''}"/>>컴퓨터정보공학</option>
					<option value="전자" <c:out value="${vo.dept=='전자'? 'selected':''}"/>>전자공학</option>
					<option value="건축" <c:out value="${vo.dept=='건축'? 'selected':''}"/>>건축공학과</option>
				</select>
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수직급</span>&nbsp;
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="title" value="정교수" <c:out value="${vo.title=='정교수'? 'checked':''}"/>>
					<label class="form-check-label">정교수</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="title" value="부교수" <c:out value="${vo.title=='부교수'? 'checked':''}"/>>
					<label class="form-check-label">부교수</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="radio" name="title" value="조교수" <c:out value="${vo.title=='조교수'? 'checked':''}"/>>
					<label class="form-check-label">조교수</label>
				</div>
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">교수급여</span>
				<input name="salary" class="form-control" value="${vo.salary}">
			</div>
			<div class="input-group mb-2">
				<span class="input-group-text">임용일자</span>
				<input name="hiredate" class="form-control" type="date" value="${vo.hiredate}">
			</div>
			<div class="text-center mt-5">
				<input type="submit" value="교수수정" class="btn btn-primary">
				<input type="reset" value="수정취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>

<script>
	$(frm_update).on("submit", function(e){
		e.preventDefault();
		const pname=$(frm_update.pname).val();
		const salary=$(frm_update.salary).val();
		if(pname==""){
			alert("교수이름을 입력하세요!");
			$(frm_insert.pname).focus();
		}else if(salary.replace(/[0-9]/g, '')){
			alert("급여를 숫자로 입력하세요!");
			$(frm_insert.salary).val("");
			$(frm_insert.salary).focus();
		}else{
			if(confirm("수정하시겠습니까?")){
				frm_update.submit();		
			}
		}
	});
	$(frm_update).on("reset", function(e){
		location.href = "/pro/list";
	});
</script>