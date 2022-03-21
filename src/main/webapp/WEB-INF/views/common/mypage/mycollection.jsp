<%@ page language="java" contentType="text/html; charset=UTF=8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="resources/css/mypage/mycollection.css">

<h3>MYCOLLECTION</h3>



<%
	String userId = (String) session.getAttribute("userid");
	System.out.println("userID:" + userId);
%>

<script>

$(document)
.ready(
		function() {
		var sessionId = '<%=userId%>';
		console.log("sessionID:" + sessionId);
		getdetail_info(sessionId);

		
		function getdetail_info(sessionId) {

			var userId = sessionId;
			
			$.ajax({
				type : "POST",
				url : "/booksajo/getmycollection",
				data : JSON.stringify({
					userId : userId
				}),
				datatype : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(result) {
				
					
					html="";
					
					for ( var ele in result) {
						/* collection_id,myline_title,isbn,page,line,bookline,myline */
/* 						html += result[ele].COLLECTION_ID ;
						html += result[ele].MYLINE_TITLE ;
						html += result[ele].ISBN ;
						html += result[ele].PAGE ;
						html += result[ele].LINE ;
						html += result[ele].BOOKLINE ;
						html += result[ele].MYLINE ;
						 */
						
						html += '<div id="block">'; 
						html += '<form action="collectmodify" method="get">'
						html += '<table class="collectable">';
						html += '<tr>';
						html += '<td id="bookimg"><input type="submit" value="글 귀 수정" /><input type="hidden" name="isbn" value="'+ result[ele].ISBN +'"/><a href="collectdelete?isbn='+result[ele].ISBN+'">삭제</a>'+ result[ele].ISBN +'</td>';
						html += '</tr>';
						html += '<tr>';
						html +=	'<td id="booktitle">' + result[ele].MYLINE_TITLE +'</td>';
						html += '</tr>';
						html +=	'<tr>';
						html += '<td id="bookpageline">' + result[ele].PAGE + result[ele].LINE +'</td>';
						html +=	'</tr>';
						html +=	'<tr>';
						html +=	'<td id="booklinebref">' + result[ele].BOOKLINE + '</td>';
						html +=	'</tr>';
						html +=	'<tr>';
						html +=	'<td id="mylinebref">' + result[ele].MYLINE + '</td>';
						html +=	'</tr>';
						html += '</table>';
						html += '</form>';
						html += '</div>'; 
						
					}
					
					$('#collectiontable').html(html);
					//console.log(result[0].MYLINE_TITLE);
					//console.log(result[1].MYLINE_TITLE);
					//언디파인 -> 데이블 필드 대문자로 써줘야함...
					
				}
				});
				
		}
		
	});
</script>



<div id="collectiontable">
<!-- <table class="collectable">

</table> -->
</div>


<!-- 
<table class="collectable">
<tr id="bookimg">
<td>책 이미지1</td>
<td>책 이미지2</td>
<td>책 이미지3</td>
</tr>
<tr id="booktitle">
<td>책제목1</td>
<td>책제목2</td>
<td>책제목3</td>
</tr>
<tr id="bookpageline">
<td>페이지,줄1</td>
<td>페이지,줄2</td>
<td>페이지,줄3</td>
</tr>
<tr id="booklinebref">
<td>글귀1</td>
<td>글귀2</td>
<td>글귀3</td>
</tr>
</table>

 -->