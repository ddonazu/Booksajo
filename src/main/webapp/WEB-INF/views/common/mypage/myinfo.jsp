<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-2022-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="resources/css/myinfo.css">




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
		getuserinfo(sessionId);
		getdetail_info(sessionId);

		
		
		function getdetail_info(sessionId) {

			var userId = sessionId;
			
			$.ajax({
				type : "POST",
				url : "/booksajo/mypage_detail_info",
				data : JSON.stringify({
					userId : userId
				}),
				datatype : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(result2) {
				
					
					privateinfo="";
					
					privateinfo += '<table style="width: 100%" height="500px" >';
					privateinfo += '<caption id="tablecap">$)CGJ<v@T7B;gGW</caption>';
					privateinfo += '<tr>';
					privateinfo += '<td style="width: 10%;" id="selname">$)C>F@L5p</td>';
					privateinfo += '<td colspan="3">'+ result2[0].USER_ID +'</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td id="selname">$)C@L8'</td>';
					privateinfo +=	'<td colspan="3">'+ result2[0].USER_NAME +'</td>';

					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo += '<td id="selname">$)C;}3b?y@O</td>';
					privateinfo += '<td style="width: 30%;">'+'<select name="year" id="year">'+'<option value="">1990</option>'+'<option value="">1990</option>'+'</select>$)C3b'+'<select name="month" id="month">';
					privateinfo += '<option value="">07</option>'+'<option value="">08</option>'+'</select>$)C?y'+'<select name="day" id="day">'+'<option value="">28</option>'+'<option value="">29</option>'+'</select>@O'+'</td>';
					privateinfo += '<td id="selname">$)C<::0</td>';
					privateinfo +=	'<td style="width:40%;"><input type="radio" name="gender"/>$)C?)<: <input type="radio" name="gender"/>32<:</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td colspan="4" id="selphone">$)C?,6tC3(@|H-9xH#, H^4kFy9xH#) A_ GO3*4B 9]5e=C @T7BGO<E>_ GU4O4Y.</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td id="selname">E-mail</td>';
					privateinfo +=	'<td>'+ result2[0].USER_EMAIL +'</td>';
					privateinfo +=	'<td id="selname">$)C@|H-9xH#</td>';
					privateinfo +=	'<td>'+ result2[0].USER_PHONE +'</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td id="selname" colspan="1">$)C86DIFC(1$0m)</br><v=E5?@G ?):N</td>';
					privateinfo +=	'<td colspan="3">';
					privateinfo +=	'<input type="checkbox" />$)C86DIFC(1$0m) <v=E5?@G ?):N(<1EC) 0"A> GR@NG}EC, A&H^@L:%F./1bH9@| 5n@G 3;?k@; 9^@8=C0Z=@4O1n?';
					privateinfo +=	'<table id="innertable" style="width: 90%; height: 80px;">';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td>SMS</td>';
					privateinfo +=	'<td><input type="radio" />$)C<v=E</td>';
					privateinfo +=	'<td>$)C5?@G3/B%.EW@L:m?!<- 0!A.?@1b</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td>Email</td>';
					privateinfo +=	'<td><input type="radio" />$)C<v=E</td>';
					privateinfo +=	'<td>'+result2[0].USER_DATE +'</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'</table>';
					privateinfo +=	'</td>';

					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname">$)C3W@L9v>F@L5p ?,5?</td>';
					privateinfo +=	'<td>14</td>';
					privateinfo +=	'<td>15</td>';
					privateinfo +=	'<td>16</td>';
					privateinfo +=  '</tr>';
					privateinfo +=	'</table>';


					privateinfo +=	'<table style="width: 100%" height="300px">';
					privateinfo +=	'<caption id="tablecap">$)C<1EC@T7B;gGW</caption>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname" style="width: 10%;">$)C1b:;AV<R [A}]</td>';
					privateinfo +=	'<td>$)CAV<R8& 557N8m AV<R C<0h?! 8B0T :/0fGXAV<<?d!<br>';
					privateinfo +=	'<input type="text" /><input type="button" value="$)C?lFm9xH#"/><br>';
					privateinfo +=	'<input type="text" /><input type="text" /><br>';
					privateinfo +=	'$)C@'@G AV<R8& <vA$ GO8i AV<R7O@G 1b:; AV<R55 :/0f5K4O4Y.<br>';
					privateinfo +=	'$)C1b:; AV<R4B H8?xA$:80|8.>3*@GAV<R7O?!<- <3A$ GO=G <v @V=@4O4Y.<br>';
					privateinfo +=	'$)C:; AV<R4B <-:q=:, 0fG0 9h<[@; @'GQ 8q@{ 5n H8?x0|8.8& @'GX @L?k/@z@e5G8g, H8?xE;Ep =C ;hA&5K4O4Y.<br>';
					privateinfo +=	'</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname">$)C03@NA$:8</br>@/H?1b0#A&</td>';
					privateinfo +=	'<td><input type="radio" name="agree"/>1$)C3b<input type="radio" name="agree" />33b<input type="radio" name="agree"/>53b<input type="radio" name="agree"/>E;Ep=C1nAv</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname">$)CA&3@Z A$:8A&0x 5?@G</td>';
					privateinfo +=	'<td><table id="innertable" style="width: 90%; height: 80px;">';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td>$)CA&H^C3</td>';
					privateinfo +=	'<td>$)C5?@G?):N</td>';
					privateinfo +=	'<td>$)CC38.3/B%</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'</table></td>';
					privateinfo +=	'</tr>';
					privateinfo += '</table>';
					
					
					$('#privateinfo').html(privateinfo);
					console.log(result2[0]);
					/* $)C>p5pFD@N@87N 3*?B4@0M@: E0?M :'7y7N @z@e5G>n@V@84O1n.. @N5&=:7N 2(3;A`>_GQ4Y4B0E... 1W8.0m E0 4k<R9.@Z 189.GO4O1n.. F280@L@/ E08& <R9.@Z7N @T7B */
					
				}});
				
		}
		
		
		function getuserinfo(sessionId) {

			var userId = sessionId;
			
			$.ajax({
				type : "POST",
				url : "/booksajo/mypageuser",
				data : JSON.stringify({
					userId : userId
				}),
				datatype : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(result) {

					var html="";
					//console.log("result:"+result);

					
 					html += '<table style="width: 100%" height="90px">';
					html += '<tr>';
					html += '<td id="usertab"';
					html += 'style="text-align: left; padding-left: 20px; width: 30%;">' + result.user_nickname +'$)C4T</td>';
					html += '<td id="coupon">$)CDmFy</br>'+result.user_coupon;
					html += '</td>';
					html += '<td id="point">$)CEkGUFw@NF.</br>'+result.user_point;
					html += '</td>';
					html += '<td id="check">$)C?9D!1]</br>'+result.user_check;
					html += '</td>';
					html += '</tr>';
					html += '</table>';
					
					
								
					//$('#usertab').html(putnickname);
					$('#cuponcheck').html(html); 
				
					
				}
			});

		}
	});
</script>



<div id="cuponcheck">

</div>




<div id="myinfomodi">
	$)CH8?xA$:8<vA$
	<hr />
</div>


<div id="privateinfo">

<%-- <table style="width: 100%" height="500px" >
	<caption id="tablecap">$)CGJ<v@T7B;gGW</caption>
	<tr>
		<td style="width: 10%;" id="selname">$)C>F@L5p</td>
		<td colspan="3">${myinfo.user_id}</td>

	</tr>
	<tr>
		<td id="selname">$)C@L8'</td>
		<td colspan="3">${myinfo.user_name}</td>

	</tr>
	<tr>
		<td id="selname">$)C9}A$;}3b?y@O</td>
		<td style="width: 30%;">
		<select name="year" id="year">
		<option value="">1990</option>
		<option value="">1990</option>
		</select>$)C3b
		<select name="month" id="month">
		<option value="">07</option>
		<option value="">08</option>
		</select>$)C?y
		<select name="day" id="day">
		<option value="">28</option>
		<option value="">29</option>
		</select>$)C@O
		</td>
		<td id="selname">$)C<::0</td>
		<td style="width:40%;"><input type="radio" name="gender"/>$)C?)<: <input type="radio" name="gender"/>32<:</td>
	</tr>
	<tr>
		<td colspan="4" id="selphone">$)C?,6tC3(@|H-9xH#, H^4kFy9xH#) A_ GO3*4B 9]5e=C @T7BGO<E>_ GU4O4Y.</td>
	</tr>
	<tr>
		<td id="selname">E-mail</td>
		<td>${myinfo.user_email}</td>
		<td id="selname">$)C@|H-9xH#</td>
		<td>${myinfo.user_phone}</td>
	</tr>
	<tr>
		<td id="selname" colspan="1">$)C86DIFC(1$0m)</br><v=E5?@G ?):N</td>
		<td colspan="3">
				<input type="checkbox" />$)C86DIFC(1$0m) <v=E5?@G ?):N(<1EC)
		$)C0"A> GR@NG}EC, A&H^@L:%F./1bH9@| 5n@G 3;?k@; 9^@8=C0Z=@4O1n?
		<table id="innertable" style="width: 90%; height: 80px;">
		<tr>
		<td>SMS</td>
		<td><input type="radio" />$)C<v=E</td>
		<td>$)C5?@G3/B%.EW@L:m?!<- 0!A.?@1b</td>
		</tr>
		<tr>
		<td>Email</td>
		<td><input type="radio" />$)C<v=E</td>
		<td>$)C3/B% 0!A.?@1b sysdate</td>
		</tr>
		</table>
		</td>

	</tr>
	<tr>
		<td id="selname">$)C3W@L9v>F@L5p ?,5?</td>
		<td>14</td>
		<td>15</td>
		<td>16</td>
	</tr>
<!-- 	
	<tr>
		<td id="selname">$)C3W@L9v>F@L5p ?,5?</td>
		<td>22</td>
		<td>23</td>
		<td>24</td>
	</tr>
 -->
</table>


<table style="width: 100%" height="300px">
	<caption id="tablecap">$)C<1EC@T7B;gGW</caption>
	<tr>
		<td id="selname" style="width: 10%;">$)C1b:;AV<R [A}]</td>
		<td>
			$)CAV<R8& 557N8m AV<R C<0h?! 8B0T :/0fGXAV<<?d!<br>
			<input type="text" /><input type="button" value="$)C?lFm9xH#"/><br>
			<input type="text" /><input type="text" /><br>
			$)C@'@G AV<R8& <vA$ GO8i AV<R7O@G 1b:; AV<R55 :/0f5K4O4Y.<br>
			$)C1b:; AV<R4B H8?xA$:80|8.>3*@GAV<R7O?!<- <3A$ GO=G <v @V=@4O4Y.<br>
			$)C:; AV<R4B <-:q=:, 0fG0 9h<[@; @'GQ 8q@{ 5n H8?x0|8.8& @'GX @L?k/@z@e5G8g, H8?xE;Ep =C ;hA&5K4O4Y.<br>
		</td>
	</tr>
	<tr>
		<td id="selname">$)C03@NA$:8</br>@/H?1b0#A&</td>
		<td><input type="radio" name="agree"/>1$)C3b<input type="radio" name="agree" />33b<input type="radio" name="agree"/>53b<input type="radio" name="agree"/>E;Ep=C1nAv</td>
	</tr>
	<tr>
		<td id="selname">$)CA&3@Z A$:8A&0x 5?@G</td>
		<td><table id="innertable" style="width: 90%; height: 80px;">
		<tr>
		<td>$)CA&H^C3</td>
		<td>$)C5?@G?):N</td>
		<td>$)CC38.3/B%</td>
		</tr>
		</table></td>
	</tr>
</table> --%>


