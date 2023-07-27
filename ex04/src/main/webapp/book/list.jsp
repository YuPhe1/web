<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row my-5">
	<div class="col">
		<h1 class="text-center mb-3">도서목록</h1>
		<div id="book_list"></div>
		<div class="text-center">
			<button id="prev" class="btn btn-info">이전</button>
			<span id="page" class="mx-2"></span>
			<button id="next" class="btn btn-info">다음</button>
		</div>
	</div>
</div>
<script id="temp_list" type="text/x-handlebars-template">
	<table class="table table-striped">
	{{#each .}}
		<tr>
			<td><img src="{{printImage thumbnail}}" width="50px" index="{{@index}}"></td>
			<td>{{title}}</td>
			<td>{{fmtPrice price}}</td>
		</tr>
	{{/each}}
	</table>
</script>
<script>
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
	getList();
	function getList() {
		$.ajax({
			type:"get",
			url:"/book/list.json",
			dataType:"json",
			data:{page:page},
			success:function(data){
				console.log(data);
				
				const temp = Handlebars.compile($("#temp_list").html());
				const html = temp(data);
				$("#book_list").html(html);
			}
		});
	}
	
</script>