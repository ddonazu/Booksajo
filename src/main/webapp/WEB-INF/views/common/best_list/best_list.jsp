<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/css/main_page/best_list.css" />
<title>Insert title here</title>
<style>
#content {
	width: 100%;
	margin: 0 auto;
	float: none;
}
</style>

<script>
$(function(){
	var categoryList = document.location.href.split("&");
	

})

</script>

</head>
<body>
	<div class="contents">
		<div class="category">
			<table>
				<tr>
					<td><span>메뉴</span></td>
				</tr>
				<tr>
					<td><a href="bestList?page=1&category=all">전체 베스트 셀러</a></td>
				</tr>
				<tr>
					<td><a href="bestList?page=1&category=m">월간 베스트 셀러</a></td>
				</tr>
				<tr>
					<td><a href="bestList?page=1&category=y">연간 베스트 셀러</a></td>
				</tr>
			</table>
		</div>
		<div class="contents_top">
			<h1>${title } 베스트 셀러</h1>
		</div>
		<div class="book_list_area">
			<ul class="book_list">
				<c:forEach items="${list }" var="list">
					<li>
<!-- 						<div class="rank"> -->
<%-- 							<span>${list.rank }</span> --%>
<!-- 						</div> -->
	                    <div class="book_thumbnail">
	                            <a href="search_detail?isbn=${list.isbn }" >
	                                <img src=${list.thumbnail } alt="">
	                            </a>
	                    </div>
	                    <div class="title">
	                        <a href="search_detail?isbn=${list.isbn }" >
	                            <strong>${list.title }</strong>
							</a>
							<span>저자: ${list.authors }</span>
	                        <span>출판사: ${list.publisher }</span>
 	                        <span>출판연도: ${list.pub_year }</span>

						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="page_area">
			<div class="paging">
				<a href="bestList?page=1&category=${category }"><img src="resources/img/btn_prev_on.gif" alt="" /></a>
				<c:choose>
					<c:when test="${searchVO.page eq 1}">
						<a href="bestList?page=${searchVO.page }&category=${category }"><img src="resources/img/btn_prev.gif" alt="" /></a>
					</c:when>
					<c:otherwise>
						<a href="bestList?page=${searchVO.page - 1 }&category=${category }"><img src="resources/img/btn_prev.gif" alt="" /></a>
					</c:otherwise>
				</c:choose>
				&nbsp;&nbsp;
				
				<c:forEach begin="${searchVO.pageStart }" end="${searchVO.pageEnd }" var="i">
					<c:choose>
						<c:when test="${i eq searchVO.page }">
							<span style="color:red; font-weight: bold;">${i }</span>&nbsp;&nbsp;&nbsp;&nbsp; 
						</c:when>
						<c:otherwise>
							<a href="bestList?page=${i }&category=${category }" style="text-decoration: none">${i } </a>&nbsp;&nbsp;
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<c:choose>
					<c:when test="${searchVO.totPage eq searchVO.page }">
						<a href="bestList?page=${searchVO.page }&category=${category }"><img src="resources/img/btn_next.gif" alt="" /></a>
					</c:when>
					<c:otherwise>
						<a href="bestList?page=${searchVO.page + 1 }&category=${category }"><img src="resources/img/btn_next.gif" alt="" /></a>
					</c:otherwise>
				</c:choose>
				<a href="bestList?page=${searchVO.totPage }&category=${category }"><img src="resources/img/btn_next_on.gif" alt="" /></a>
			</div>
			
		</div>
	</div>
</body>
</html>