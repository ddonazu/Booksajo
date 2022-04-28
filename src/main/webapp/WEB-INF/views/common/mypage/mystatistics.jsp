<%@ page language="java" contentType="text/html; charset=UTF=8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/mypage/mystatistics.css">
<h3>MYSTATISTICS</h3>

<h4>내 통계 페이지</h4>

방법:


1. 유저별 결제 페이지에 모든 구매한 도서 가져온다. 도서 제목 형태소 분석을 통해 -> 명사 추출한다음  -> 나의 관심 분야  모음 란을 화면에 보여준다.

2. 1.의 상세방법내용:  1) 유저별 구매 책제목에서 명사 추출  + 2) 구매책 가중치 키워드 뽑아냄 [3개만] + 3) 소.중 .대 카테고리에서 명사추출     = 카테고리 KDC겹치는 번호를 찾는다.[인덱스 사용하려고..카운트하려면 숫자로 보는게 더 좋으니까]
3. 그리고 해당 카테고리에 카운트 중복될수록 +1을 올려준다... => 최종 합계 나오도록 하고  

4. 최종 그래프에 나타나게 반영


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
		//유저별 구매책 정보 가져오는 매소드 호출
		getbuy_info(sessionId);

		
		function getbuy_info(sessionId) {

			var userId = sessionId;
			
			$.ajax({
				type : "POST",
				url : "/booksajo/getbuy",
				data : JSON.stringify({
					userId : userId
				}),
				datatype : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(result) {
				
					
					console.log("갯바이 호출완료");
					
					
					
					$('#favolist').html(html);
					//console.log(result[0].MYLINE_TITLE);
					//console.log(result[1].MYLINE_TITLE);
					//언디파인 -> 데이블 필드 대문자로 써줘야함...
					
				}
				});
				
		}
		
		function getchart_info(sessionId) {
			
			var userId = sessionId;
			
			$.ajax({
				type : "POST",
				url : "/booksajo/mychart_info",
				data : JSON.stringify({
					userId : userId
				}),
				datatype : 'json',
				contentType : 'application/json; charset=utf-8',
				success : function(result) {
				
					
					console.log("갯마이차트 리턴완료");
					console.log(result);
					console.log(result.KDC);
					
					//제대로 리턴된거 확인후 -> 차트로 보여주는 작업진행하기
					
					

					
				}
				});
			
			
		}
		
	});
</script>


<div id="favolist">
관심 분야. 카테고리 나타내기..잡플래닛 평점처럼..
</div>

<div id="mychart">
차트.리스트 차트표현
</div>
