<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>자주묻는 질문</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">


<link rel="stylesheet" media="screen and (min-width:512px)" href="resources/css/faq_page/faq_desk.css">
<link rel="stylesheet" media="screen and (max-width:500px)" href="resources/css/faq_page/faq_mobile.css">


<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<script>
  $( function() {
    $( "#accordion" ).accordion();
  } );
  </script>
</head>


<body>
	<div id="accordion" >
		<c:forEach items="${faqlist }" var="faqdto">

			<h3>${faqdto.f_title}</h3>
			<div style="padding: 5px; font-size: 13px;">
				<p>
					<c:if test="${faqdto.f_reply_content eq null }">
						<a href="faqreplyform?f_id=${faqdto.f_id}">[관리자 답변달기]</a>
					</c:if>
							${faqdto.f_reply_content }
					<c:if test="${faqdto.f_reply_writer eq 'master' }">
						<a href="faqdelete?f_id=${faqdto.f_id}">[삭제]</a>
					</c:if>
				</p>
			</div>
		</c:forEach>
	</div>
	<div id="bottomline" >
		<a href="http://localhost:9007/booksajo/index">[북사조 Home]</a> 
		<a href="faqwriteform">[FAQ쓰기]</a>
	</div>
</body>
</html>

