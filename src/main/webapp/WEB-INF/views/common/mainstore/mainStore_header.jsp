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

<link rel="stylesheet" type="text/css" href="resources/css/mainstore_page/mainStore_header.css">




<head>
<header>
<div id="header_wrap">
		<div class="header_inner">
			<div class="logo_00">
				<a href="http://localhost:9007/booksajo/index" target="_balnk"><img src="resources/img/logo3.png" alt="" /></a>
			</div>
			
			<nav>
			<div class="top1">
			<h3><a class="dropdown-toggle" data-toggle="dropdown" role="button" href="" aria-expanded="false" onmouseover="drop(1);">매장안내</a>
					<ul class="dropdown-menu">
						<li style="font-size: 12px;"><a href="mainStore1" data-ga-label="">광화문점</a></li>
						<li style="font-size: 12px;"><a href="mainStore2" data-ga-label="">영등포점</a></li>					
						<li style="font-size: 12px;"><a href="mainStore3" data-ga-label="">강남점</a></li>
					</ul>
			</h3>
			</div>
			</nav>
			
			<ul class="gnb" style="list-style: none;">
				<li><a href="http://localhost:9007/booksajo/index" class="a">북사조 홈</a></li>
				<li><a href="http://localhost:9007/booksajo/login" class="a">로그인</a></li>  <!-- 로그아웃 버튼이 활성화 안되잖아 다른거 넣을까말까 -->
				<li><a href="http://localhost:9007/booksajo/noticeList" class="a">공지사항</a></li>
			</ul>
		</div>
	</div>
</header>
</head>


<script src="resources/js/mainStore_header.js"></script>