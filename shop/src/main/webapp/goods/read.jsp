<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	#heart {
		font-size: 1.5rem;
		color: red;
		cursor: pointer;
	}
	#fnt {
		font-size: 0.5rem;
	}
	#review {
		font-size: 1.5rem;
	}
</style>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">상품정보</h1>
		<div class="row">
			<div class="col-md-5 m-2 text-center">
				<img src="${vo.image}" width="90%" style="border: 1px solid lightgrey;">				
			</div>
			<div class="col card m-2 p-3">
				<h5>상품코드: ${vo.gid}</h5>
				<h5>상품이름: ${vo.title}</h5>
				<hr>
				<div class="my-2">상품가격: <fmt:formatNumber value="${vo.price}" pattern ="#,###원"/></div>
				<div class="my-2">제조사: ${vo.maker}</div>
				<div class="my-2">상품등록일: ${vo.regDate}</div>
				<hr>
				<div class="row">
					<div class="col">
						<button class="btn btn-primary" id="btn-cart" gid="${vo.gid}">장바구니</button>
					</div>
					<div class="col text-end" id="count">
						<i id="heart" class="bi bi-suit-heart"></i>
						<span id="fcnt"></span>
						<i class="bi bi-chat-square-dots-fill"></i>
						<span id="rcnt"></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<ul class="nav nav-tabs" id="myTab" role="tablist">
	<li class="nav-item" role="presentation">
		<button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#detail-tab-pane" type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true">상세설명</button>
	</li>
	<li class="nav-item" role="presentation">
		<button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#review-tab-pane" type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">고객리뷰</button>
	</li>
</ul>
<div class="tab-content" id="myTabContent">
	<div class="tab-pane fade show active" id="detail-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">상세설명...</div>
	<div class="tab-pane fade" id="review-tab-pane" role="tabpanel" aria-labelledby="profile-tab" tabindex="0">
		<jsp:include page="review.jsp"/>
	</div>
</div>
<script>

	$("#count").on("click", ".bi-suit-heart", function(){
		if(uid==""){
			location.href="/user/login?target=/goods/read?gid="+gid;
		} else {
			if(confirm("좋아요! 추가하실래요?")){
				// 좋아요 추가
				$.ajax({
					type:"get",
					url:"/favorite/insert",
					data:{gid:gid, uid:uid},
					success:function(){
						getFavorite();
					}
				});
			}
		}
	});

	$("#count").on("click", ".bi-suit-heart-fill", function(){
		if(confirm("좋아요!를 삭제하실래요?")){
			// 좋아요 삭제
			$.ajax({
				type:"get",
				url:"/favorite/delete",
				data:{gid, uid},
				success:function(){
					getFavorite();
				}
			});
		}
		
	});
	getFavorite();

	function getFavorite(){
		$.ajax({
			type:"get",
			url:"/favorite/read",
			data:{gid, uid},
			dataType:"json",
			success:function(data){
				if(data.ucnt == 1){
					$("#heart").removeClass("bi-suit-heart").addClass("bi-suit-heart-fill");
				} else {
					$("#heart").removeClass("bi-suit-heart-fill").addClass("bi-suit-heart");
				}
				$("#fcnt").html(data.fcnt);
			}
		});
	}

	$("#btn-cart").on("click", function(){
		const gid = $(this).attr("gid");
		$.ajax({
			type:"get",
			url:"/cart/insert",
			data:{gid:gid},
			success: function(){
				if(confirm("계속 쇼핑하실래요?")){
					location.href="/";
				} else {
					location.href="/cart/list"
				}
			}
		});
	});
</script>