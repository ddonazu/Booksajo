<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="resources/css/faq/faq.css" />
<title>FAQ 답변</title>
</head>
<body>
<!-- <h3>qnareplyform.jsp</h3> -->
<table>
	<form action="faqreply" method="post">
		<input type="hidden" name="fid" value="${fid }" />
		
		<tr>
			<td class="left">답변</td>
			<td><textarea name="fcontent" rows="5"  cols="50">[답변]</textarea> </td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="faqreply" /> &nbsp;&nbsp;
				
			</td>
		</tr>
	</form>
</table>



</body>
</html>