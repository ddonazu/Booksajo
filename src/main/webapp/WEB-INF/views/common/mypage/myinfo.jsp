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
					privateinfo += '<caption id="tablecap">필수입력사항</caption>';
					privateinfo += '<tr>';
					privateinfo += '<td style="width: 10%;" id="selname">아이디</td>';
					privateinfo += '<td colspan="3">'+ result2[0].USER_ID +'</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td id="selname">이름</td>';
					privateinfo +=	'<td colspan="3">'+ result2[0].USER_NAME +'</td>';

					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo += '<td id="selname">생년월일</td>';
					privateinfo += '<td style="width: 30%;">'+'<select name="year" id="year">'+'<option value="">1990</option>'+'<option value="">1990</option>'+'</select>년'+'<select name="month" id="month">';
					privateinfo += '<option value="">07</option>'+'<option value="">08</option>'+'</select>월'+'<select name="day" id="day">'+'<option value="">28</option>'+'<option value="">29</option>'+'</select>일'+'</td>';
					privateinfo += '<td id="selname">성별</td>';
					privateinfo +=	'<td style="width:40%;"><input type="radio" name="gender"/>여성 <input type="radio" name="gender"/>남성</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td colspan="4" id="selphone">연락처(전화번호, 휴대폰번호) 중 하나는 반드시 입력하셔야 합니다.</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td id="selname">E-mail</td>';
					privateinfo +=	'<td>'+ result2[0].USER_EMAIL +'</td>';
					privateinfo +=	'<td id="selname">전화번호</td>';
					privateinfo +=	'<td>'+ result2[0].USER_PHONE +'</td>';
					privateinfo += '</tr>';
					privateinfo += '<tr>';
					privateinfo +=	'<td id="selname" colspan="1">마케팅(광고)</br>수신동의 여부</td>';
					privateinfo +=	'<td colspan="3">';
					privateinfo +=	'<input type="checkbox" />마케팅(광고) 수신동의 여부(선택) 각종 할인혜택, 제휴이벤트/기획전 등의 내용을 받으시겠습니까?';
					privateinfo +=	'<table id="innertable" style="width: 90%; height: 80px;">';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td>SMS</td>';
					privateinfo +=	'<td><input type="radio" />수신</td>';
					privateinfo +=	'<td>동의날짜.테이블에서 가져오기</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td>Email</td>';
					privateinfo +=	'<td><input type="radio" />수신</td>';
					privateinfo +=	'<td>'+result2[0].USER_DATE +'</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'</table>';
					privateinfo +=	'</td>';

					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname">네이버아이디 연동</td>';
					privateinfo +=	'<td>14</td>';
					privateinfo +=	'<td>15</td>';
					privateinfo +=	'<td>16</td>';
					privateinfo +=  '</tr>';
					privateinfo +=	'</table>';


					privateinfo +=	'<table style="width: 100%" height="300px">';
					privateinfo +=	'<caption id="tablecap">선택입력사항</caption>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname" style="width: 10%;">기본주소 [집]</td>';
					privateinfo +=	'<td>주소를 도로명 주소 체계에 맞게 변경해주세요!<br>';
					privateinfo +=	'<input type="text" /><input type="button" value="우편번호"/><br>';
					privateinfo +=	'<input type="text" /><input type="text" /><br>';
					privateinfo +=	'위의 주소를 수정 하면 주소록의 기본 주소도 변경됩니다.<br>';
					privateinfo +=	'기본 주소는 회원정보관리>나의주소록에서 설정 하실 수 있습니다.<br>';
					privateinfo +=	'본 주소는 서비스, 경품 배송을 위한 목적 등 회원관리를 위해 이용/저장되며, 회원탈퇴 시 삭제됩니다.<br>';
					privateinfo +=	'</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname">개인정보</br>유효기간제</td>';
					privateinfo +=	'<td><input type="radio" name="agree"/>1년<input type="radio" name="agree" />3년<input type="radio" name="agree"/>5년<input type="radio" name="agree"/>탈퇴시까지</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td id="selname">제3자 정보제공 동의</td>';
					privateinfo +=	'<td><table id="innertable" style="width: 90%; height: 80px;">';
					privateinfo +=	'<tr>';
					privateinfo +=	'<td>제휴처</td>';
					privateinfo +=	'<td>동의여부</td>';
					privateinfo +=	'<td>처리날짜</td>';
					privateinfo +=	'</tr>';
					privateinfo +=	'</table></td>';
					privateinfo +=	'</tr>';
					privateinfo += '</table>';
					
					
					$('#privateinfo').html(privateinfo);
					console.log(result2[0]);
					/* 언디파인으로 나온느것은 키와 벨류로 저장되어있으니까.. 인덱스로 꺼내줘야한다는거... 그리고 키 대소문자 구문하니까.. 틀린이유 키를 소문자로 입력 */
					
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
					html += 'style="text-align: left; padding-left: 20px; width: 30%;">' + result.user_nickname +'님</td>';
					html += '<td id="coupon">쿠폰</br>'+result.user_coupon;
					html += '</td>';
					html += '<td id="point">통합포인트</br>'+result.user_point;
					html += '</td>';
					html += '<td id="check">예치금</br>'+result.user_check;
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
	회원정보수정
	<hr />
</div>


<div id="privateinfo">

<%-- <table style="width: 100%" height="500px" >
	<caption id="tablecap">필수입력사항</caption>
	<tr>
		<td style="width: 10%;" id="selname">아이디</td>
		<td colspan="3">${myinfo.user_id}</td>

	</tr>
	<tr>
		<td id="selname">이름</td>
		<td colspan="3">${myinfo.user_name}</td>

	</tr>
	<tr>
		<td id="selname">법정생년월일</td>
		<td style="width: 30%;">
		<select name="year" id="year">
		<option value="">1990</option>
		<option value="">1990</option>
		</select>년
		<select name="month" id="month">
		<option value="">07</option>
		<option value="">08</option>
		</select>월
		<select name="day" id="day">
		<option value="">28</option>
		<option value="">29</option>
		</select>일
		</td>
		<td id="selname">성별</td>
		<td style="width:40%;"><input type="radio" name="gender"/>여성 <input type="radio" name="gender"/>남성</td>
	</tr>
	<tr>
		<td colspan="4" id="selphone">연락처(전화번호, 휴대폰번호) 중 하나는 반드시 입력하셔야 합니다.</td>
	</tr>
	<tr>
		<td id="selname">E-mail</td>
		<td>${myinfo.user_email}</td>
		<td id="selname">전화번호</td>
		<td>${myinfo.user_phone}</td>
	</tr>
	<tr>
		<td id="selname" colspan="1">마케팅(광고)</br>수신동의 여부</td>
		<td colspan="3">
				<input type="checkbox" />마케팅(광고) 수신동의 여부(선택)
		각종 할인혜택, 제휴이벤트/기획전 등의 내용을 받으시겠습니까?
		<table id="innertable" style="width: 90%; height: 80px;">
		<tr>
		<td>SMS</td>
		<td><input type="radio" />수신</td>
		<td>동의날짜.테이블에서 가져오기</td>
		</tr>
		<tr>
		<td>Email</td>
		<td><input type="radio" />수신</td>
		<td>날짜 가져오기 sysdate</td>
		</tr>
		</table>
		</td>

	</tr>
	<tr>
		<td id="selname">네이버아이디 연동</td>
		<td>14</td>
		<td>15</td>
		<td>16</td>
	</tr>
<!-- 	
	<tr>
		<td id="selname">네이버아이디 연동</td>
		<td>22</td>
		<td>23</td>
		<td>24</td>
	</tr>
 -->
</table>


<table style="width: 100%" height="300px">
	<caption id="tablecap">선택입력사항</caption>
	<tr>
		<td id="selname" style="width: 10%;">기본주소 [집]</td>
		<td>
			주소를 도로명 주소 체계에 맞게 변경해주세요!<br>
			<input type="text" /><input type="button" value="우편번호"/><br>
			<input type="text" /><input type="text" /><br>
			위의 주소를 수정 하면 주소록의 기본 주소도 변경됩니다.<br>
			기본 주소는 회원정보관리>나의주소록에서 설정 하실 수 있습니다.<br>
			본 주소는 서비스, 경품 배송을 위한 목적 등 회원관리를 위해 이용/저장되며, 회원탈퇴 시 삭제됩니다.<br>
		</td>
	</tr>
	<tr>
		<td id="selname">개인정보</br>유효기간제</td>
		<td><input type="radio" name="agree"/>1년<input type="radio" name="agree" />3년<input type="radio" name="agree"/>5년<input type="radio" name="agree"/>탈퇴시까지</td>
	</tr>
	<tr>
		<td id="selname">제3자 정보제공 동의</td>
		<td><table id="innertable" style="width: 90%; height: 80px;">
		<tr>
		<td>제휴처</td>
		<td>동의여부</td>
		<td>처리날짜</td>
		</tr>
		</table></td>
	</tr>
</table> --%>


