<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="resources/css/admin_page/admin_product_detail.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script src="resources/js/main.js"></script>
<title>관리자 페이지</title>
<style>
	#thumbnail {
		width: 180px;
		height: 220px;
		margin: 0 auto;
	}
	#image {
		max-width: 100%;
		max-height: 100%;
	}
</style>
<script>
$(function(){
	var bb = "${list.title}";
	console.log(bb);
	var aaa = '${list.contents}';
	console.log(aaa);
	$("#detail_contents").append(aaa);
	
});

</script>

</head>
<body>
	<h1>상품디테일</h1>
	
	<div class="contents_area">
		<div class="content_area">

			<table>
					<tr>
						<th rowspan="4" class="left">
							<div id="thumbnail" >
								<img src="${list.thumbnail }" id="image" alt="" />
							</div>
						</th>
						<th class="left">
							도서번호
						</th>
						<td>
							<span>${list.isbn }</span>
						</td>
						<th class="left">
							재고
						</th>
						<td>
							<span>${list.stock }</span>
						</td>
					</tr>
					<tr>
						<th class="left">
							제목
						</th>
						<td colspan="3">
							<span>${list.title }</span>
						</td>
						
					</tr>
					<tr>
						<th class="left">
							가격
						</th>
						<td colspan="3">
							<span>${list.price }</span>
						</td>
					</tr>
					<tr>
						<th class="left">
							키워드
						</th>
						<td colspan="3">
							<span>${list.keyword }</span>
						</td>
						
					</tr>
					<tr>
					
						<th class="left">
							카테고리
						</th>
						<td>
							<span>${list.class_major_ko }</span>
						</td>
						
						<th class="left">
							저자
						</th>
						<td colspan="2">
							<span>${list.authors }</span>
						</td>
					</tr>
					<tr>

						<th class="left">
							출판연도
						</th>
						<td>
							<span>${list.pub_year }</span>
						</td>
						
						<th class="left">
							출판사
						</th>
						<td colspan="2">
							<span>${list.publisher }</span>
						</td>
					</tr>
					<tr>
						<th colspan="5">
							내용
						</th>
					</tr>
					<tr>
						<td colspan="5">
							<div style="min-height: 300px; padding: 15px; ">
								${list.contents }
							</div>
						</td>
					</tr>				
					
				</table>
			<div id="buttons">
				<button type="button" onclick = "location.href = 'product_modify?isbn=${list.isbn}'">수정</button>
				<button type="button" onclick = "location.href = 'admin_product_delete?isbn=${list.isbn}'">삭제</button>
				<button type="button" onclick = "location.href = 'admin_product'">목록</button>
			</div>
		</div>
		
	</div>
</body>
</html>