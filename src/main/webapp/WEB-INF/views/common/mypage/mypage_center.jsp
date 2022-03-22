<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="resources/css/mypage_center.css" />

<!-- 여기다가 검색테이블 구현하면 되겠다요 -->


<!-- 유저 정보가 하나일땐 이렇게 되는데.. 문제가 유저정보가 여러게 레이블일땐 에러남.. -->


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

<!-- 모델값 제대로 못 전달하면 타일 바디부분 에러가난다. -->
<%-- <c:forEach items="myinfo" var="meme">
${meme.user_nickname }

</c:forEach>
 --%>


<div id="cuponcheck">
<!-- 	<table style="width: 100%" height="90px">
		<tr>
			<td id="usertab"
				style="text-align: left; padding-left: 20px; width: 30%;">&nbsp;&nbsp;님</td>
			<td id="coupon">쿠폰</br>1
			</td>
			<td id="point">통합포인트</br>2
			</td>
			<td id="check">예치금</br>3
			</td>
		</tr>
	</table> -->
</div>

<div id="tt">주문 취소와 반품 상황</div>

<div id="orderlist">

	<table border="1px solid" style="width: 100%;">
		<tr>
			<td>주문번호</td>
			<td>주문금액</td>
			<td>상품정보</td>
			<td>수량</td>
			<td>주문상태</td>
			<td>주문변경</td>
		</tr>
	</table>

</div>


<!-- <script src='/js/mypage_center.js'></script> -->