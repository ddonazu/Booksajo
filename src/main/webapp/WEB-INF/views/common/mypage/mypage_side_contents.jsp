<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/lib/jquery/jquery-3.6.0.min.js"></script>
    <script src="resources/lib/bootstrap/js/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="resources/lib/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/css/mypage_side.css">


<%
	String userId = (String) session.getAttribute("userid");
	System.out.println("userID:" + userId);
//코드 블락으로 jsp에서 컨트롤러로 못전달하네.. 꼭 폼으로 보내줘야하나봄...네임 만들어서 벨류로 보내줘야함
%>

<script>

var sessionId = '<%=userId%>';

</script>


<ul class="nav flex-column" id="side">
  <li class="nav-item" id="hr" style="font-style: sans-serif; font-weight: bold;">
    <a class="nav-link disabled" style="font:bold; font-size: large; text-align: center; color: black;" >마이룸</a>
  </li>
<hr />  
  <li class="nav-item">
    <a class="nav-link" href="mycollection">문장수집</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="mylog">나의 독서기록</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="mywrite">문장수집 글쓰기 ＞</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="mystatistics">나의 통계</a>
  </li>
</ul>
