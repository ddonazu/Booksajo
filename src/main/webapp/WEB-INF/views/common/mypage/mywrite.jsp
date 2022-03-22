<%@ page language="java" contentType="text/html; charset=UTF=8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- 글쓰기에디터 js -->
<link rel="stylesheet" type="text/css"
	href="resources/css/mypage/mywrite.css">
<script
	src="https://cdn.ckeditor.com/ckeditor5/32.0.0/classic/ckeditor.js"></script>

<h3>MYWRITE</h3>

<h4>글귀 등록하기</h4>

방법: 1. 책을 검색할수있게한다 (유저가 구매한 책 중에 선택할수있게 한다) 2. 클릭해서 해당책 선택 3. 게시판형태로 안에
추가되는 부분은 책의 1)몇 페이지인지 어느 파트인지 2)몇째 줄 3)맘에드는 글귀 적기란 4) 글귀 대한 개인 감상 이렇게
표시한 게시판 형태로 글귀를 등록할수있게한다. 게시판형태를 좀 보기편하게 보여줄수있도록 한다. 4. 삭제 . 추가 . 제거가
가능해야함..


<%
	String userId = (String) session.getAttribute("userid");
	System.out.println("userID:" + userId);
%>

<div id="mywrite">
	<form action="memewrite" method="post">
		<table class="table">
			<thead>
				<tr>
					<th scope="col" class="th_title">글 귀 제목</th>
					<td colspan="3" class="td_title"><input type="text"
						name="cTitle" class="input_title" placeholder="제목을 입력하세요." /></td>
				</tr>

				<!-- 로그인페이지 참고 -->
				<tr>
					<th scope="col" class="th_book">책</th>
					<td colspan="3" class="td_book"><input type="text"
						name="cBook" class="input_book" placeholder="책 제목을 입력하세요." /> <input
						type="button" value="찾아보기" /></td>
				</tr>

				<tr>
					<th scope="col" class="th_page">페이지</th>
					<td class="td_page"><input type="text" name="cPage"
						class="input_page" placeholder="글귀 가 포함된 페이지를 입력하세요." /></td>
					<th scope="col" class="th_line">라인 수</th>
					<td class="td_line"><input type="text" name="cLine"
						class="input_line" placeholder="글귀가 포함된 해당 을 입력하세요." /></td>
				</tr>

				<tr>
					<th scope="col" class="th_content">글 귀</th>
					<td colspan="3" class="td_content"><textarea name="cContent"
							id="textarea" class="input_content" placeholder="맘에드는 글 귀를 입력하세요"></textarea></td>
				</tr>

				<tr>
					<th scope="col" class="th_content">나의 메모</th>
					<td colspan="3" class="td_content"><textarea name="cMemo"
							id="textarea" class="input_content" placeholder="메모를 입력하세요"></textarea></td>
				</tr>

			</thead>
		</table>

		<div class="btn">
			<input type="submit" value="입력" name="<%=userId%>" 
				style="color: black;" /><input type="hidden" value="<%=userId%>" name="userId" /> <a href="mywrite" style="color: black;">목록</a>
			&nbsp;&nbsp;
			<!-- 틀린이유: 네임에다가 넣어서 보내는게 아니라 벨류에 담아서 보내줘야함.. 네임에다가 코드블락 넣어주면 값을 전달 못함.. -->
		</div>
	</form>
</div>


<!-- 페이지 고유 js include -->
<!-- <script src="resources/js/board.js"></script> -->

<!-- 글쓰기에디터 js -->
<script src="resources/js/ckeditor.js"></script>