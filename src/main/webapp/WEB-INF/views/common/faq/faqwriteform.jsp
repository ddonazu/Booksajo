<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/css/faq/faq.css" />
<title>FAQ 작성</title>
</head>
<body>
<!-- 	<h3>qnawriteform.jsp</h3> -->
	<table>
		<form action="faqwrite" method="post">
			<tr>
				<td class="left">작성자</td>
				<td><input type="text" name="fwriter" value="접속한사용자" /></td>
			</tr>
			<tr>
				<td class="left">질문</td>
				<td><textarea name="fcontent" rows="5" cols="50">[질문]</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="글작성" />
					&nbsp;&nbsp;</td>
			</tr>
		</form>
	</table>



</body>
</html>