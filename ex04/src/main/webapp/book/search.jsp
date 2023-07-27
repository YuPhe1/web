<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#div_book img {
		cursor: pointer;
	}
</style>

<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">도서검색</h1>
		<div class="row justify-content-end mb-3">
			<form name="frm" class="col-6 col-md-4 col-lg-3">
				<div class="input-group">
					<input class="form-control" value="깜냥" name="query">
					<button class="btn btn-primary">검색</button>
				</div>
			</form>
		</div>
		<div id="div_book"></div>
		<div class="text-center">
			<button id="prev" class="btn btn-info">이전</button>
			<span id="page" class="mx-2"></span>
			<button id="next" class="btn btn-info">다음</button>
		</div>
	</div>
</div>
<!-- 도서목록 템플릿 -->
<script id="temp_book" type="text/x-handlebars-template">
	<table class="table table-striped">
		<tr class="table-dark">
			<td colspan="6">
				<input type="checkbox" id="all" class="me-3">
				<button class="btn btn-primary btn-sm" id="btn-save">선택한 항목 저장</button>
			</td>
		</tr>
		{{#each documents}}
		<tr>
			<td><input type="checkbox" class="chk" book="{{toString @this}}"></td>
			<td><img src="{{printImage thumbnail}}" width="50px" index="{{@index}}"></td>
			<td>{{title}}</td>
			<td>{{fmtPrice price}}</td>
			<td>{{authors}}</td>
		</tr>
		<!-- Modal -->
		<div class="modal fade" id="modal{{@index}}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  			<div class="modal-dialog modal-lg">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h1 class="modal-title fs-5" id="staticBackdropLabel">도서정보</h1>
        				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      				</div>
      				<div class="modal-body">
        				<div class="row">
							<div class="col-3 card p-3 mx-3">
								<img src="{{printImage thumbnail}}">
							</div>
							<div class="col">
								<h5>제목: {{title}}</h5>
								<h5>가격: {{fmtPrice price}}</h5>
								<h5>출판사: {{publisher}}</h5>
								<h5>저자: {{authors}}</h5>
								<h5><a href="{{url}}">사이트</a></h5>
							</div>
						</div>
						<hr>
						<p>{{contents}}</p>
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
      				</div>
    			</div>
  			</div>
		</div>
		{{/each}}
	</table>
</script>
<script>

	Handlebars.registerHelper("toString", function(obj) {
		return JSON.stringify(obj);
	});

	Handlebars.registerHelper("fmtPrice", function(price) {
	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원";
	});

	Handlebars.registerHelper("printImage", function(image){
        if(image){
            return image;
        } else {
            return "https://via.placeholder.com/120x174";
        }
    });

</script>
<script>
	let page = 1;
	let size = 3;
	let query = $(frm.query).val();
	
	// 저장을 눌렀을 떄
	$("#div_book").on("click", "#btn-save", function(){
		const chk = $("#div_book .chk:checked").length;
		if(chk == 0){
			alert("저장할 항목을 선택하세요!");
		} else {
			if(confirm("선택한 항목을 저장하실래요?")){
				$("#div_book .chk:checked").each(function(){
					const book = JSON.parse($(this).attr("book"));
					// console.log(book);
					$.ajax({
						type: "post",
						url: "/book/insert",
						data: book,
						success:function(){}
					});
				});
				alert("저장완료");
				$("#div_book .chk").prop("checked", false);
				$("#div_book #all").prop("checked", false);
			}else{
				alert("저장이 취소되었습니다.");
			}
		}
	});
	
	// 전체 체크박스를 클릭한 경우
	$("#div_book").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_book .chk").prop("checked", true);
		} else {
			$("#div_book .chk").prop("checked", false);
		}
	});
	
	// 각 행의 체크박스를 클릭한 경우
	$("#div_book").on("click", ".chk", function(){
		let all = $("#div_book .chk").length;
		let chk = $("#div_book .chk:checked").length;
		if(all == chk){
			$("#div_book #all").prop("checked", true);
		} else {
			$("#div_book #all").prop("checked", false);
		}
	});
	
	// 각 행의 이미지를 클릭한 경우
	$("#div_book").on("click", "img", function(){
		let index = $(this).attr("index");
		$("#modal" + index).modal("show");
	});
	
	// 검색할 때
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		query = $(frm.query).val();
		getList();
	});
	
	// 이전버튼 클릭
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	// 다음버튼 클릭
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	getList();
	
	function getList(){
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v3/search/book",
			data:{query:query, size:size, page:page},
			headers:{"Authorization":"KakaoAK 77d097a28d8f55eaba328191513327fe"},
			dataType:"json",
			success: function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_book").html());
				const html = temp(data);
				$("#div_book").html(html);
				
				let last = Math.ceil(data.meta.pageable_count / size);
				
				$("#page").html("<b> " + page + " / " + last + "</b>");
				if(page == 1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
				
				if(data.meta.is_end) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false);
			}
		});
	}
</script>