/**
 * 
 */

	$(frm).on("submit", function(e){
		e.preventDefault();
		query = $(frm.query).val();
		key = $(frm.key).val();
		getTotal();
	});
	
 // pagination
	$('#pagination').twbsPagination({
		totalPages : 1, // 총 페이지 번호 수
		visiblePages : 7, // 하단에서 한번에 보여지는 페이지 번호 수
		startPage : 1, // 시작시 표시되는 현재 페이지
		initiateStartPageClick : false, // 플러그인이 시작시 페이지 버튼 클릭 여부 (default : true)
		first : '<i class="bi bi-chevron-double-left"></i>', // 페이지네이션 버튼중 처음으로 돌아가는 버튼에 쓰여 있는 텍스트
		prev : '<i class="bi bi-caret-left"></i>', // 이전 페이지 버튼에 쓰여있는 텍스트
		next : '<i class="bi bi-caret-right"></i>', // 다음 페이지 버튼에 쓰여있는 텍스트
		last : '<i class="bi bi-chevron-double-right"></i>', // 페이지네이션 버튼중 마지막으로 가는 버튼에 쓰여있는 텍스트
		onPageClick : function(event, page) {
			getList(page);
		}
	});

	// 목록 
	function getList(page) {
		$.ajax({
			type : "get",
			url : "/"+url+"/list.json",
			data : {page : page, query: query, key:key},
			dataType : "json",
			success : function(data) {
				// console.log(data);
				const temp = Handlebars.compile($("#temp_"+url).html());
				const html = temp(data);
				$("#div_"+url).html(html);
			}
		});
	}

	// 전체 교수 수
	function getTotal() {
		$.ajax({
			type : "get",
			url : "/"+url+"/total",
			data:{query:query, key:key},
			success : function(data) {
				// console.log(data);
				$("#total").html(data);
				if (data != 0) {
					const totalPages = Math.ceil(data / 5);
					$("#pagination").show();
					$("#pagination").twbsPagination("changeTotalPages",
							totalPages, 1);
				} else {
					$("#div_"+url).html("<h2 class='text-center'>검색 결과가 없습니다.</h2>");
					$("#pagination").hide();
				}
			}
		});
	}