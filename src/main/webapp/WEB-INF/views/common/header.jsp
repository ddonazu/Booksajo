<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<!-- 부트스트랩 css 사용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<head>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


<!-- 제이쿼리 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<link rel="stylesheet" media="screen and (min-width:512px)" href="resources/css/header_desk.css">
<link rel="stylesheet" media="screen and (max-width:500px)" href="resources/css/header_mobile.css">



<header class="header">
	<nav class="nav a1">
		<div class="top1">
			<ul class="nav justify-content-center">
				<li id="f"><a class="dropdown-toggle" data-toggle="dropdown" role="button" href="" aria-expanded="false" onmouseover="drop(1);">매장안내</a>
					<ul class="dropdown-menu">
						<li style="font-size: 12px;"><a href="mainStore1" data-ga-label="">광화문점</a></li>
						<li style="font-size: 12px;"><a href="mainStore2" data-ga-label="">영등포점</a></li>					
						<li style="font-size: 12px;"><a href="mainStore3" data-ga-label="">강남점</a></li>
					</ul>
				</li>
				<li id="f"><a href="#">회원혜택</a></li>
				<li id="f"><a href="#">Prestige Lounge</a></li>
			<%
		            Object userid=session.getAttribute("userid");
		            
		            
		            if(userid == null ){
            %>
				<li id="g"><a href="login">로그인</a></li>
				<li id="g"><a href="signIn">회원가입</a></li>
            <%}else if(userid != null){
               if ("admin".equals(userid)) {
            %>
            <li id="g"><a href="admin_home">관리자</a></li>
            <%} %>
            <li id="g"><a href="logout">로그아웃</a></li> 
				<li id="g"><a href="#">출석체크</a></li>
				<li id="g"><a href="mypage">MYPAGE</a></li>
            <%} %>
<!-- 				<li id="g"><a href="#">고객센터</a></li> -->
				<li id="g"><a href="#">주문배송</a></li>
				<li id="g"><a href="shoplist">장바구니<img src="resources/img/shopicon.png" width="20px;" height="20px;" alt="" /></a></li>
				<!-- <li id="g"><a href="shoplist"><img src="resources/img/shopicon.png" width="25px;" height="25px;" alt="" /></a> </li> -->
			</ul>
		</div>
	</nav>

<div id="a">
<a href="index"><img src="resources/img/logo2.png" class="logo2" width="170px" height="69px" alt="" width="30" height="24" id="img"></a>
</div>
<div id="b">
<form class="d-flex" action="search_table" method="post">
      <input placeholder="검색어를 입력하세요." class="form-control me-2" type="search"  name="searchInput" aria-label="Search" style="height: 40px; border-radius: 25px;">
      <button class="btn btn-outline-success" id="searchbutton" type="submit" style="height: 40px; width:50px; float: right; border: none;"  >
      <img src="resources/img/search_icon3.png" width="23px;"  height="23px;" />
      </button>
    </form>
</div>
<span id="c">여백</span>



  <ul class="nav justify-content-center a2">
  <!-- 부트스트랩의 1.형태요소이면서 2.클래스 이름이기도함 -->
    <li class="nav-item dropdown">
    <a class=""nav-link dropdown-toggle" data-toggle="dropdown" role="button" href="search" aria-expanded="false" onmouseover="drop(1);"><b>국내도서</b>
    </a>
    <ul class="dropdown-menu">
      <li><a href="search">카테고리1</a></li>
      <li><a href="search">카테고리2</a></li>
      <li><hr class="dropdown-divider"></li>
      <li><a class="dropdown-item" href="search">카테고리3</a></li>
    </ul>
       <li class="nav-item dropdown">
    <a class=""nav-link dropdown-toggle" data-toggle="dropdown" role="button" href="#" aria-expanded="false" onmouseover="drop(2);"><b>외국도서</b>
    </a>
    <ul class="dropdown-menu">
      <li><a href="#">카테고리1</a></li>
      <li><a href="#">카테고리2</a></li>
      <li><hr class="dropdown-divider"></li>
      <li><a class="dropdown-item" href="#">카테고리3</a></li>
    </ul>
    <li><a href="#">굿즈</a></li>
    <li><a href="#">중고장터</a></li>
    <li><a href="noticeList">공지사항</a></li>
  </ul>

</header>
</head>

<body>
<script src="resources/js/header.js"></script>