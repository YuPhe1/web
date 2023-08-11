<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="row my-5">
	<div class="col">
		<h3 class="text-center mb-5">고객리뷰</h3>	
		<form name="frm">
			<c:if test="${user!=null}">		
				<textarea rows="3" class="form-control mb-3" placeholder="리뷰내용을 입력하세요!" name="content"></textarea>
				<div class="text-center">
					<button class="btn btn-secondary px-4">글쓰기</button>
				</div>
			</c:if>	
		</form>
		<c:if test="${user==null}">
				<div class="text-center">
				<button class="btn btn-secondary w-50" id="btn-review">리뷰작성</button>
			</div>
		</c:if>
		<div id="div_review"></div>
	</div>
</div>
<script id="temp_review" type="x-handlebars-template">
	{{#each .}}
		<div class="row my-3">
			<div class="col-md-1">
				<image src="{{getImage photo}}" width="50px">
				<div>{{uid}}</div>
			</div>
			<div class="col">
				<div>{{revDate}}</div>
				<div>{{content}}</div>
			</div>
		</div>
		<hr>
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
	const uid = "${user.uid}";
	const gid = "${vo.gid}";
	getList();
	$("#btn-review").on("click", function(){
		location.href = "/user/login?target=/goods/read?gid="+gid;
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		const content = $(frm.content).val();
		if(content == ''){
			alert("리뷰 내용을 입력하세요");
			$(frm.content).focus();
		}else {
			$.ajax({
				type:"post",
				url:"/review/insert",
				data:{uid, gid, content},
				success:function(){
					alert("리뷰가 저장되었습니다.");
					$(frm.content).val("");
					getList();
				}
			});
		}
	});
	
	function getList(){
		$.ajax({
			type:"get",
			url:"/review/list.json",
			data:{gid:gid},
			dataType:"json",
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_review").html());
				const html = $("#div_review").html(temp(data));
			}
		});
	}
</script>