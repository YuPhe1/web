<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">강좌수정</h1>
		<form name="frm_update" class="card p-3" method="post" action="/cou/update">
			<div class="input-group mb-3">
				<span class="input-group-text">강좌명</span>
				<input name="lcode" class="form-control" value="${vo.lcode}" readonly>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">강좌명</span>
				<input name="lname" class="form-control" value="${vo.lname}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">강의실</span>
				<input name="room" class="form-control" value="${vo.room}">
			</div>
				<div class="input-group mb-3">
				<span class="input-group-text">강의시수</span>
				<input name="hours" class="form-control" oninput="isNumber(this)" value="${vo.hours}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">최대인원</span>
				<input name="capacity" class="form-control" oninput="isNumber(this)" value="${vo.capacity}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">수강인원</span>
				<input name="persons" class="form-control" oninput="isNumber(this)" value="${vo.persons}">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">강의교수</span>
				<select name="instructor" class="form-select">
					<c:forEach items="${parray}" var="p">
						<option value="${p.pcode}" <c:out value="${vo.instructor == p.pcode ? 'selected' : ''}"/>>${p.pcode}:${p.pname}:${p.dept}</option>
					</c:forEach>
				</select>
			</div>
			<div class="text-center mt-3">
				<input type="submit" value="강좌수정" class="btn btn-primary">
				<input type="reset" value="수정취소" class="btn btn-secondary">
			</div>
		</form>
	</div>
</div>

<script>

	$(frm_update).on("submit", function(e){
		e.preventDefault();
		const lname=$(frm_update.lname).val();
		if(lname==""){
			alert("강의명 입력하세요!");
			$(frm_update.lname).focus();
		}else{
			if(confirm("새로운 강좌를 등록하실래요?")){
				frm_update.submit();
			}
		}
	});
	
	$(frm_update).on("reset", function(e){
		location.href ="/cou/list";
	});
	
	// 숫자인 경우에만 입력
	function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	};
</script>