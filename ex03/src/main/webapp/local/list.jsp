<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-5">지역검색</h1>
		<div class="row justify-content-end mb-3">
			<form class="col-6 col-md-3" name="frm">
				<div class="input-group">
					<select class="form-select me-2" name="city">
						<option>서울</option>
						<option selected="selected">인천</option>
						<option>경기</option>
						<option>부산</option>
					</select>
					<input class="form-control" name="query" value="버거킹">
					<button class="btn btn-info px-3">검색</button>
				</div>
			</form>
		</div>
		<div id="div_local"></div>
		<div class="text-center">
			<button id="prev" class="btn btn-info px-3">이전</button>
			<span id="page" class="mx-3">1/100</span>
			<button id="next" class="btn btn-info px-3">다음</button>
		</div>
		<div id="map" style="width:100%;height:400px;display:none" class="card"></div>
	</div>
</div>
<!-- 지역검색 목록 템플릿 -->
<script id="temp_local" type="text/x-handlebars-template">
	<table class="table table-striped">
		<tr>
			<td>
				<input type="checkbox" class="me-3" id="all">
				<button class="btn btn-primary btn-sm" id="btn-save">선택저장</button>
			</td>
			<td>id</td>
			<td>이름</td>
			<td>주소</td>
			<td>전화번호</td>
			<td>지도</td>
		</tr>
		{{#each documents}}
		<tr class="local" local="{{toString @this}}">
			<td><input type="checkbox" class="chk"></td>
			<td>{{id}}</td>
			<td class="place">{{place_name}}</td>
			<td>{{address_name}}</td>
			<td class="phone">{{phone}}</td>
			<td><button class="btn btn-success btn-sm" index="{{@index}}" x={{x}} y="{{y}}" add="{{address_name}}" phone="{{phone}}">위치</button></td>
		</tr>
		<!-- Modal -->
	
		<div class="modal fade" id="modal{{@index}}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
   			<div class="modal-dialog">
        		<div class="modal-content">
            		<div class="modal-header">
                		<h1 class="modal-title fs-5" id="staticBackdropLabel">{{place_name}}</h1>
                		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            		</div>
            		<div class="modal-body card m-3">
                		<div id="map{{@index}}"></div>
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
	Handlebars.registerHelper("toString", function(local) {
		return JSON.stringify(local);
	});
</script>
<script>
	let page = 1;
	let size = 5;
	let query = $(frm.city).val() + " " + $(frm.query).val(); 
	
	getList();

	// 선택 저장버튼을 클릭했을 떄
	$("#div_local").on("click", "#btn-save", function() {
		let chk = $("#div_local .chk:checked").length;
		if(chk==0){
			alert("저장할 항목을 선택하세요!");
		} else {
			if(!confirm(chk + "개 항목을 저장하실래요?")) return;
			$("#div_local .chk:checked").each(function(){
				let tr = $(this).parent().parent();
				let data = JSON.parse(tr.attr("local"));
				// console.log(data);
				$.ajax({
					type:"post",
					url:"/local/insert",
					data: data,
					success:function(){}
				});
			});
			alert("선택된 항목이 저장되었습니다.");
			$("#div_local #all").prop("checked", false);
			$("#div_local .chk").prop("checked", false);
		}
	});
	
	// 전체 체크박스를 클릭했을 때
	$("#div_local").on("click", "#all", function(){
		if($(this).is(":checked")){
			$("#div_local .local .chk").prop("checked", true);
		} else {
			$("#div_local .local .chk").prop("checked", false);
		}
	});
	
	// 각 행의 체크박스를 클릭했슬 때
	$("#div_local").on("click", ".local .chk", function(){
		let all = $("#div_local .local .chk").length;
		let chk = $("#div_local .local .chk:checked").length;
		if(all == chk){
			$("#div_local #all").prop("checked", true);
		} else {
			$("#div_local #all").prop("checked", false);
		}
	});
	$("#div_local").on("click", ".btn-success", function(){
		const index = $(this).attr("index");
		const x = $(this).attr("x");
		const y = $(this).attr("y");
		var container = document.getElementById('map'+index);
		var options = {
			center: new kakao.maps.LatLng(y, x),
			level: 3
		};
	    
		var map = new kakao.maps.Map(container, options);
		// 마커가 표시될 위치입니다
		
		container.style.width = '100%';
	    container.style.height = '400px'; 
	    
		var markerPosition  = new kakao.maps.LatLng(y, x); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map)	
		
		let row = $(this).parent().parent();
		let place = row.find(".place").text();
		let phone = row.find(".phone").text();
		
		var str ="<div style='padding:5px;font-size:12px;'>";
        str += place + "<br>" + phone;
        str +="</div>";
        var info=new kakao.maps.InfoWindow({ content:str });

        kakao.maps.event.addListener(marker, "mouseover", function(){ 
        	info.open(map, marker); 
        });
        kakao.maps.event.addListener(marker, "mouseout", function(){
        	info.close(map, marker); 
        });
        
		$("#modal"+index).modal("show");// 닫은때는 hide
		 
		$("#modal"+index).on('shown.bs.modal', function(){
			setTimeout(function(){
				map.relayout();
				map.setCenter(markerPosition);
			}, 0);	
		});
		 
	});
	
	// frm submit 될때
	$(frm).on("submit", function(e){
		e.preventDefault();
		if($(frm.query).val() != ""){
			query = $(frm.city).val() + " " + $(frm.query).val();
			page = 1;
			getList();
		} else {
			alert("검색어를 입력해주세요");
			$(frm.query).focus();
		}
	});
	
	// 이전 버튼이 눌렸을 떄
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	// 다음 버튼이 눌렸을 떄
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	function getList() {
		$.ajax({
			type:"get",
			url:"https://dapi.kakao.com/v2/local/search/keyword.json",
			headers:{"Authorization":"KakaoAK 77d097a28d8f55eaba328191513327fe"},
			dataType:"json",
			data:{query:query, size:size, page:page},
			success:function(data){
				// console.log(data);
				const temp = Handlebars.compile($("#temp_local").html());
				const html = temp(data);
				$("#div_local").html(html);
				
				const last = Math.ceil(data.meta.pageable_count / size);
				
				if(page==1) $("#prev").attr("disabled", true);
				else $("#prev").attr("disabled", false);
				
				if(data.meta.is_end) $("#next").attr("disabled", true);
				else $("#next").attr("disabled", false);
				
				$("#page").html("<b>"+ page + " / "+ last +"</b>");
			}
		})
	}
</script>