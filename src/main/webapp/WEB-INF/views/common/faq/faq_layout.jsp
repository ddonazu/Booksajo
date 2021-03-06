<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<!-- 512px이상일떄 적용되는 화면 -->
<style type="text/css" media="screen and (min-width:512px)">

#title{
float:left;
margin-top:25px;
width: 61%;
margin-left: 20%;
}

#container{
	width: 100%;
	margin-top: 260px;
	text-align: center;
	border: 0px solid #bcbcbc;
	background-color:white;
}


#sidebar-left{
	width: 11%;
	height: 100%;
	margin-left: 20%;
	margin-top: -46px;
	margin-bottom: 361px;
	padding-top:0px;
	float: left;
	background-color: #fff;
	border: 1.5px solid #a8afe5;
	border-collapse:collapse;
	font-size: 10px;
	z-index: -1;

}

#content{
	margin-top: -50px;
	margin-bottom: 104px;
	width:50%;
	margin-left: -90px;
	float: left;
/* 	border: 2px solid #bcbcbc; */
	height: 100%;
	z-index: -1;
	font-size: 13px;
	/* 사이드바 높이 없어지면서 메인부분이 높이가 너무 짧아짐 내용부분에 높이 추가하면댐 */ 
	
}

#footer{
	float:left;
    width: 100%;
    z-index: 0;
	background-color: #eee;
}


</style>


<!-- 가로 500px이하일떄 적용되는 화면 ==모바일로 화면으로 칭함-->
<style type="text/css" media="screen and (max-width:500px)">

#title{
float:left;
margin-top:25px;
width: 61%;
margin-left: 20%;
}

#container{
	width: 100%;
	margin-top: 260px;
	text-align: center;
	border: 0px solid #bcbcbc;
	background-color:white;
}


#sidebar-left{
	width: 400px;
	height: 100px;
	margin-left: 5px;
	margin-top: 5px;
	margin-bottom: 362px;
	padding-top:0px;
	display:inline-flex;
	background-color: #fff;
	border: 1.5px solid #a8afe5;
	border-collapse:collapse;
	font-size: 8px;
	z-index: -1;

}

#content{
	margin-top: -360px;
	width:50%;
	margin-left: 45px;
	float: left;
/* 	border: 2px solid #bcbcbc; */
	height: 510px;
	z-index: -1;
	font-size: 13px;
	/* 사이드바 높이 없어지면서 메인부분이 높이가 너무 짧아짐 내용부분에 높이 추가하면댐 */ 
	
}

#footer{
	float:left;
    width: 100%;
    z-index: 0;
	background-color: #eee;
}


</style>




</head>
<body style="height: 100%;">

	<!-- 영역없는거 안없애면 에러남. 타일설정 에러 ->서블렛 에러 -->
	
<div id="container">
 	
 	<div id="title">
 		<tiles:insertAttribute name="title" />
 	</div>

 	
 	<div id="header">
		<tiles:insertAttribute name="header" />
	</div>
 
 	<div id="sidebar-left">
		<tiles:insertAttribute name="side" />
	</div>

	<div id="content">
		<tiles:insertAttribute name="body" />
	</div>

	<div id="footer">
		<tiles:insertAttribute name="footer" />
	</div>
</div>



</body>
</html>