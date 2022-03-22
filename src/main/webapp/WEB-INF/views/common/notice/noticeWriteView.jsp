<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="resources/css/notice_page/noticeWrite_board.css">

<!-- 글쓰기에디터 js -->


<script src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>

<title>공지사항 글작성 | 고객센터 - 책사조</title>
<div class="notice_board">
	<h1 class="h1_notice">공지사항 글작성</h1>

	<form action="noticeWrite" method="get">
		<table class="table">
			<thead>
				<tr>
					<th scope="col" class="th_title">제목</th>
					<td><input type="text" class="td_title" name="nTitle"
						placeholder="제목을 입력하세요." /></td>
				</tr>

				<tr>
					<th scope="col" class="th_content">내용</th>
					<td><textarea class="td_content" name="nContent" id="textarea"
							style="resize: none" placeholder="내용을 입력하세요"></textarea></td>
				</tr>
			</thead>
		</table>

		<div class="btn">
			<input type="submit" value="입력" style="color: black; font-size: 13px;" /> <a
				href="noticeList" style="color: black; font-size: 13px;">목록</a> &nbsp;&nbsp;
		</div>
	</form>
</div>

<script src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
	
	
	
	