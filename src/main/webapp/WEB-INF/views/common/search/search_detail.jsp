<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<link rel="stylesheet" media="screen and (min-width:512px)"
	href="resources/css/search_detail_desk.css">
<link rel="stylesheet" media="screen and (max-width:500px)"
	href="resources/css/search_detail_mobile.css">




<%
	String userId = (String) session.getAttribute("userid");
%>

<script>
var sessionId = '<%=userId%>';

	$(document)
			.ready(
					function() {
						var isbn = '${isbn}';
						console.log(isbn);
						DetailData(isbn);
						testData(isbn);
						sort(isbn);

						function DetailData(isbn) {
							$
									.ajax(
											{
												type : 'POST',
												url : 'https://dapi.kakao.com/v3/search/book?target=isbn&query='
														+ isbn,
												headers : {
													Authorization : 'KakaoAK 2ecf5febe1e05d5d376370e2b4d6c779'
												},
												dataType : 'json',
												contentType : 'application/json; charset=utf-8',
											})
									.done(
											function(data) { //들어올때도 어쨋든 제이슨타입으로 1개 들어오는거니까 인덱스 써줘야함 틀린이유.
												var html = '';
												var thumbnail = '';
												var contents = data.documents[0].contents;
												var contentcut = contents
														.split('.');
												var date = data.documents[0].datetime;
												console.log(date.toString());
												var datestr = date.toString();
												
												console.log(datestr.split("T")[0]);
												var datestr2=datestr.split("T")[0];
												
												//사이드에 보내줄거
												html += '<table style="width: 100%; display:inline-block">';
												html += '<div class="icon">';
												html += '<img src="resources/img/icon_m_choice.gif" alt="MD의선택">';
												html += '<img src="resources/img/icon_m_freedel.gif" alt="무료배송">';
												html += '<img src="resources/img/icon_m_event.gif" alt="이벤트">';
												html += '<img src="resources/img/icon_m_deduction.gif" alt="소득공제">';
												html += '</div>'
												html += '<tr>';
												html += '<td colspan="2" style="width: 60%; height:70px; font-size:X-large; color:blue" id="z"><b>'
														+ data.documents[0].title
														+ '</b></td>';
												html += '</tr>';
												html += '<tr>';
												html += '<td colspan="3" id="x" style="height:50px; font-size:large; text-align: left;"><b>'
														+ contentcut[0]+'</b>';
												+'</td>';
												html += '</tr>';
												html += '</br><tr>';
												html += '<td colspan="3" id="au" style="font-size:medium;" ></br><b>'
														+ data.documents[0].authors
														+ '&nbsp;&nbsp;지음&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
														+ data.documents[0].publisher
														+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
														+ datestr2
														+ '</b></td>';
												html += '</tr>';
												html += '<tr>';
												html += '<td colspan="3" id="n"></br><p>리뷰/평점</p></td>';
												html += '</tr>';
												html += '<tr>';
												html += '<td colspan="2" id="m" style="width: 30px; height:70px; font-size:medium;">정가&nbsp;&nbsp;:&nbsp;&nbsp;'
													+ data.documents[0].price
														+ '원</td>';
												html += '</tr>';
												html += '<tr>';
												html += '<td id="sale" style="height:50px; font-size: large;" >판매가&nbsp;&nbsp;:&nbsp;&nbsp;<b style="font-size: large; color: red;" >'
													+data.documents[0].sale_price+'원&nbsp;&nbsp;[10%↓할인]&nbsp;</b></br>';
												html +=	'<p style="font-size: small;">혜택 :[기본적립] 700원 적립 [5% 적립]</br>[추가적립] 5만원 이상 구매 시 2,000원 추가적립</br>[회원혜택] 회원 등급 별, 3만원 이상 구매 시 2~4% 추가적립</br>[리뷰적립] 리뷰 작성 시 e교환권 최대 300원 추가적립</p></td>';
												html += '</tr>';
												html += '</table>';

												console.log(data.documents[0]);

												thumbnail +='<div class="rsticky">'+'<img src='+data.documents[0].thumbnail+'class="img-fluid" alt="..." style="width: 120px; height: 174px;" / >';
												$('#img2').html(thumbnail);														//width: 248px; height: 330px;
												$('#detail').html(html);
											}).fail(function(error) {

									});
																			
						}
					});
	
					 
						function testData(isbn) {
						
							var word = "";
							$.ajax({ 
								type : "POST",
								url : "/booksajo/test/search_keyword/",
								data :JSON.stringify({ 
									isbn : isbn
								}),
								datatype : 'json',
								contentType : 'application/json; charset=utf-8',
								success : function(result) {
									console.log('dd');

 									//word += console.log("들어옴");

										word += '<h3 class="h2keyword">키워드 Pick</h3> </br>';
									for ( var ele in result) {
										word += '<h4 id="pf">'+result[ele].item.word+'</h4>' ;
										word += '&nbsp;'+'</div>';
									}

									console.log(word);
									$("#keywordpick").html(word);
								}
							});
						} 

						/*왼쪽 사이드 sticky 끝지점 */				
						
						function sort(isbn) {
							
							var cate = "";
							console.log("카테고리 함수들어왔음" + isbn);
							$.ajax({ 
								type : "POST",
								url : "/booksajo/test/search_category/",
								data :JSON.stringify({ 
									isbn : isbn
								}),
								datatype : 'json',
								contentType : 'application/json; charset=utf-8',
								success : function(result) {
									
									var str=JSON.stringify(result);
									console.log(str);
									console.log(result[0]);
									/* 

									    <li class="breadcrumb-item active" aria-current="page">대카테고리</li>
									    <li class="breadcrumb-item active" aria-current="page">소카테고리</li>
									  
									</nav>
									 */
										//cate +='<nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns=''http://www.w3.org/2000/svg' width='8' height='8' %3E%3Cpath d= "M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb" >'; 
										//cate +='<ol class="breadcrumb">';
										//cate +='<li class="breadcrumb-item">'+result+'</li>';
										//cate +='</ol>';
										var nm="";
										var nmspli = new Array();	
										for ( var ele in result) {
										
											   nm = result[ele].class_nm;
												nmspli = nm.split(">");
	 											cate += '<h3 style="display: inline; font-weight: 550; font-size: 12px;">' 
	 														+ nmspli[0] + '</h3>' + '>' + 
	 														'<h2 style="display: inline; font-weight: 600; font-size: 16px;">' 
	 														+ nmspli[1] + '</h2>' + '>' +
	 														'<h1 style="display: inline; font-weight: 800; font-size: 22px;">' 
	 														+ nmspli[2] + '</h1>';
																				
											}
											
											console.log(nmspli);
											console.log(nmspli[0]);
											console.log(nmspli[1]);
											console.log(nmspli[2]);
											console.log(nm);
								
										
										/* cate += result[0]; */

									console.log(cate);
									$("#detailtitle").html(cate); //카테고리 부분쪽으로..title쪽으로
								}
							});
						} 
						
						
						
						function moveconfirm() {
							if(sessionId != 'null'){
									var isbn = ${isbn};
									var count = $('#count').val();
									var userId = sessionId; //위에선 sessionId에 담고 여기서  userId에 또 담아줘... 스크립트끼리 변수 전달하는거...
									
									if (confirm("장바구니에 담았습니다. 장바구니페이지로 이동하시겠습니까?")){   
									 	location.href="shoplist2?isbnscr="+${isbn}+"&count="+ $('#count').val()+"&userId="+ userId + "";
									}else{
									
										$.ajax({ 
											type : "POST",
											url : "/booksajo/shoplist3",
											data :JSON.stringify({ 
												isbnscr : isbn
												,count : count
												,userId : userId
											}),
											datatype : 'json',
											contentType : 'application/json; charset=utf-8',
											success : function(result) {
							
											}
										});
								} 
							}else{
								alert('먼저 로그인 해주세요');
							}
						 
						}
			

</script>

<h2 style="display: inline;"></h2>

<div id="inlineside">

	<div id="img2">
		<!-- <img src="" alt=""  style="width: 100px; height: 170px;"/> -->
		<!-- <img src="resources/img/Imgbanner.png" alt="" style="width: 120px; height: 174px;" id="imghidden"/> -->
		<br />
	</div>

	<div id="storelo">
		<div class="btnPreview">
			<a href="#" class="priview" style="cursor: pointer;">미리보기</a> | <a
				href="#" class="priview" style="cursor: pointer;">크게보기</a>
		</div>


		<div class="btnLocation">
			<a id="ndStock" style="cursor: pointer;">매장 재고 · 위치</a>
		</div>
	</div>

	<div id="keywordpick">키워드 Pick</div>
</div>


<div id="title2">
	<div id="detail" style="height: 400px;"></div>




	<table style="margin-left: 30px; text-align: left;"></table>



	<div id="booksen" style="display: inline-block;">

		<form action="shoplist2" id="formorder" method="post">
			<br />
			<br />

			<div style="font-size: 12px; font-weight: bolder;">
				주문수량 : <input type="number" max="10" min="1" value="num" id="count"
					name="count" />

				<!-- 장바구니/바로구매 -->

				<span class="btn_count">
					<button type="button"
						onclick="javascript:formQtyChangeSplit(document.proForm.qty,'1', document.getElementById('split_select').selectedIndex);">
						<img src="resources/img/btn_plus.gif" alt="수량 더하기">
					</button>
					<button type="button"
						onclick="javascript:formQtyChangeSplit(document.proForm.qty,'-1', document.getElementById('split_select').selectedIndex);">
						<img src="resources/img/btn_minus.gif" alt="수량 빼기">
					</button>
				</span>


			</div>
			<br /> <br /> <input type="button" value="장바구니 담기" id="shoplist"
				class="btn_blue" onclick="moveconfirm();" /> <input type="submit"
				value="바로구매" id="payment" class="btn_blue2"
				onclick="location.href='payment?isbn=${isbn}'" /> <input
				type="hidden" name="isbnsrc" value="'${isbn }'" />
			<%-- onclick="location.href='shoplist?${isbn}'" --%>
			<!-- 자바스크립트는 줄바꿈되면 에러난다..연결해서 써주기 -->
		</form>
	</div>



	<div id="bookReview">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#bookinfoTag">상품정보</a></li>
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#bookReviewTag">회원리뷰</a></li>
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#boxDetailTag">교환/반품/품절</a></li>
		</ul>

		<a name="bookinfoTag" style="position: absolute; top: 620px"></a>
	</div>


	<!-- 이 상품의 isbn,쪽수,크기 정보 -->
	<table class="table_simple2 table_opened margin_top10"
		summary="이 상품의 상세정보">
		<colgroup>
			<col width="18%">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">ISBN</th>
				<td><span title="ISBN-13">9791163031185</span>
			</tr>

			<tr>
				<th scope="row">쪽수</th>
				<td>276쪽</td>
			</tr>

			<tr>
				<th scope="row">크기</th>
				<td>172 * 226 * 20 mm /496g
			</tr>
		</tbody>
	</table>

	<!-- 상품상세정보 -->
	<table class="table_simple2 margin_top10">
		<colgroup>
			<col width="22%">
			<col width="*">
			<col width="22%">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th><img
					src="http://image.kyobobook.co.kr/ink/images/prom/2012/general/121108_info/quality_mark.jpg"
					alt="품질인증마크" width="20" height="30" vspace="5" hspace="29"> <br>
					제품안전인증</th>
				<td colspan="3">KC마크는 이 제품이 공통 안전기준에 적합하였음을 의미합니다.</br></td>
				<!-- //16-05-11 어린이제품안전특별법 상품정보 수정 -->

			</tr>

			<tr>
				<th width="10px;">크기,중량</th>
				<td colspan="3">172 * 226 * 20 mm / 496g</td>
			</tr>

			<tr>
				<th>제조일자</th>
				<td colspan="3">2019/11/20</td>
			</tr>

			<tr>
				<th>색상</th>
				<td colspan="3">이미지참고</td>
			</tr>

			<tr>
				<th>제조자 (수입자)</th>
				<td colspan="3">이지스퍼블리싱</td>
			</tr>


			<tr>
				<th>품질보증기준</th>
				<td colspan="3">관련 법 및 소비자 분쟁해결 규정에 따름</td>
			</tr>

		</tbody>
	</table>

	<br />
	<br />
	<h1 style="margin: 5px 0 5px 0; text-align: left;">
		<strong>책소개</strong>
	</h1>
	<br />
	<br /> <img src="resources/img/doit.jpg" id="bookimg" role="tab"
		style="width: 733px;" />


	<!-- 이선아 참고부분 -->
	<%-- 	<c:forEach items="${reviewList }" var="list">
		${list.isbn }
	</c:forEach> --%>




	<!-------------------------------------------------------------------------------------------------------------------------------------------------------->
	<!-- 이선아 리뷰테이블 -->

	<!-- 리뷰게시판 리뷰작성 -->
	<!-- jsp_work에 jspwebm15 hit login 참고-->


	<div id="reviewwrap">

		<c:if test="${empty userid }">


			<div class="reviewWriteBtn">
				<a href="http://localhost:9007/booksajo/login?isbn=${isbn }"
					onclick="alert('로그인 후 작성 가능합니다.')"><img
					src="resources/img/btn_write_review.gif" /></a>
			</div>
		</c:if>

		<c:if test="${not empty userid }">
			<script type="text/javascript">
			function showPopUp() { 
				
				//창 크기 지정 
					var width = 250; 
					var height = 10; 
				
				//pc화면기준 가운데 정렬  
					var left = (window.screen.width / 1) - (width / 2); 
					var top = (window.screen.height / 4); 
				//윈도우 속성 지정 
			
					var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes'; 
				
				//연결하고싶은url 
					const url = "http://localhost:9007/booksajo/reviewWrite"; 
				
				//등록된 url 및 window 속성 기준으로 팝업창을 연다. 
					window.open(url, "hello popup", windowStatus); } 
		</script>
			<div class="reviewWriteBtn">
				<a href="javascript:showPopUp()"><img
					src="resources/img/btn_write_review.gif" /></a>
			</div>
		</c:if>

<<<<<<< HEAD
=======
		<%-- 	<div>
		<h5>${userid }</h5>
		<h5>${admin }</h5>
	</div> --%>

>>>>>>> d3049cf2f98755a211e96d2aec6c1f1c13008a67

		<!-- 리뷰작성 게시판 -->
		<!-- <a name="fixTag" style="position: absolute; top: 500px"/> -->
		<div class="table22">
			<div class="tab_detail_content" id="infotab"
				style="width: 920px; margin-top: 10px;">

				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#bookinfoTag">상품정보</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#bookReviewTag">회원리뷰</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#boxDetailTag">교환/반품/품절</a></li>
				</ul>

				<!-- 			<div class="rate" style="margin: 30px 0 100px 0;"> -->
				<!-- 			<h2 style="text-align: left;">Klover 리뷰</h2> -->




				<!-- 			★여기부터★ -->




				<!-- 			</div>			 -->





				<div>
					<a name="bookReviewTag" style="position: absolute; top: -330px"></a>
					<c:forEach items="${reviewList }" var="reviewdto">
						<table class="table3">
							<tr class="reviewtable1">
								<td class="reviewid"
									style="font-size: 12px; font-weight: bolder;">${reviewdto.user_id }</td>
								<td class="reviewdate"
									style="font-size: 11px; color: #ADADAD; text-align: left">
									<fmt:formatDate value="${reviewdto.re_date }"
										pattern="yyy-MM-dd" />
								</td>
								<td class="reviewrating">리뷰 점수 : ${reviewdto.re_score }</td>
							</tr>
							<tr class="reviewtable2">
								<td colspan="2" class="comment">${reviewdto.re_content }</td>
							</tr>
						</table>
					</c:forEach>
				</div>
			</div>
		</div>


		<!-- 답댓글 작성panel -->
		<!-- 			<table>
			<tr>
			<td>
					<div class="reply_wrap" id="subReviewWrap0" style="display: block;">
						<div class="re_write_wrap book_review">
							<textarea name="" cols="" rows=""
								onkeyup="javascript:fc_chk_byte(this,1000,'id_TextBytes0');" placeholder="내용을 입력하세요."></textarea>
							<button type="button" class="btn_submit"
								onclick=" javascript:regSubReview('klover', '0', '6193100'); ">
								<span>등록</span>
							</button> 
							<span class="notice_reply" id="id_TextBytes0">내용을 입력해주세요.
								주제와 무관한 댓글, 악플, 배송문의 등의 글은 임의 삭제될 수 있습니다. 0/1000자</span>
						</div>
					</div>
				</td>
			</tr>
		<tr> 
	<td> -->



		<!-- 리뷰게시판 페이징 -->
		<div class="paging_num">
			<c:if test="${ReviewSearchVO.totPage>1 }">
				<c:if test="${ReviewSearchVO.page>1 }">
					<a href="search_detail?page=1&isbn=${isbn}"><img
						src="resources/img/btn_prev_on.gif" alt="" /></a>
					<a href="search_detail?page=${ReviewSearchVO.page-1 }&isbn=${isbn}"><img
						src="resources/img/btn_prev.gif" alt="" /></a>
				</c:if>
				<c:forEach begin="${ReviewSearchVO.pageStart }"
					end="${ReviewSearchVO.pageEnd }" var="i">
					<c:choose>
						<c:when test="${i eq ReviewSearchVO.page }">
							<span style="color: #0172c9; font-weight: bold;">${i } </span>&nbsp;&nbsp;|&nbsp;&nbsp; 
					</c:when>
						<c:otherwise>
							<a href="search_detail?page=${i }&isbn=${isbn}"
								style="color: #666;">${i } </a>&nbsp;&nbsp;|&nbsp;&nbsp;
					</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${ReviewSearchVO.totPage>ReviewSearchVO.page }">
					<a
						href="search_detail?page=${ReviewSearchVO.page+1  }&isbn=${isbn}"><img
						src="resources/img/btn_next.gif" alt="" /></a>
					<a
						href="search_detail?page=${ReviewSearchVO.totPage }&isbn=${isbn}"><img
						src="resources/img/btn_next_on.gif" alt="" /></a>
				</c:if>
			</c:if>
		</div>


		<!-- 			</td>
			</tr>
			</table> -->



		<!-- 이선아 교환/반품/품절  뷰단-->
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#bookinfoTag">상품정보</a></li>
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#bookReviewTag">회원리뷰</a></li>
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#boxDetailTag">교환/반품/품절</a></li>
		</ul>

		<div class="box_detail_content">
			<a name="boxDetailTag" style="position: relative; top: -380px"></a>
			<h2 class="title_detail_basic">교환/반품/품절안내</h2>
			<p class="margin_top20">※ 상품 설명에 반품/교환 관련한 안내가 있는 경우 그 내용을
				우선으로합니다. (업체 사정에 따라 달라질 수 있습니다.)</p>
			<table class="table_simple2 table_detail_guide margin_top10">
				<%-- 		<caption class="caption_hidden">교환/반품/품절안내</caption> --%>
				<colgroup>
					<col width="22%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">반품/교환방법</th>
						<td><strong>마이룸 &gt; 주문관리 &gt; 주문/배송내역 &gt; 주문조회
								&gt; <a href="#">반품/교환신청</a> , <br> <a href="#">[1:1상담&gt;반품/교환/환불]</a>
								또는 고객센터 (1544-1900)
						</strong><br> ※ 오픈마켓, 해외배송주문, 기프트 주문시 <a href="#">[1:1상담&gt;반품/교환/환불]</a><br>
							&nbsp; &nbsp; 또는 고객센터 (1544-1900)</td>
					</tr>
					<tr>
						<th scope="row">반품/교환가능 기간</th>
						<td>변심반품의 경우 수령 후 7일 이내,<br> 상품의 결함 및 계약내용과 다를 경우 문제점 발견
							후 30일 이내
						</td>
					</tr>
					<tr>
						<th scope="row">반품/교환비용</th>
						<td>변심 혹은 구매착오로 인한 반품/교환은 반송료 고객 부담</td>
					</tr>
					<tr>
						<th scope="row">반품/교환 불가 사유</th>
						<td>
							<ul class="list_normal">
								<li>소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우<br> (단지 확인을 위한
									포장 훼손은 제외)
								</li>
								<li>소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우<br> 예)
									화장품, 식품, 가전제품(악세서리 포함) 등
								</li>
								<li>복제가 가능한 상품 등의 포장을 훼손한 경우<br> 예) 음반/DVD/비디오, 소프트웨어,
									만화책, 잡지, 영상 화보집
								</li>
								<li>소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우 ((1)해외주문도서)</li>
								<li>디지털 컨텐츠인 eBook, 오디오북 등을 1회 이상 다운로드를 받았을 경우</li>
								<li>시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우</li>
								<li>전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에<br>
									해당되는 경우
								</li>
							</ul> (1) 해외주문도서 : 이용자의 요청에 의한 개인주문상품으로 단순변심 및 착오로 인한 취소/교환/반품 시 ‘해외주문
							반품/취소 수수료’ 고객 부담 (해외주문 반품/취소 수수료 : ①서양도서-판매정가의 12%, ②일본도서-판매정가의
							7%를 적용)

						</td>
					</tr>
					<tr>
						<th scope="row">상품 품절</th>
						<td>공급사(출판사) 재고 사정에 의해 품절/지연될 수 있으며, 품절 시 관련 사항에 대해서는<br>
							이메일과 문자로 안내드리겠습니다.
						</td>
					</tr>
					<tr>
						<th scope="row">소비자 피해보상<br> 환불지연에 따른 배상
						</th>
						<td>
							<ul class="list_normal">
								<li>상품의 불량에 의한 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은<br>
									소비자분쟁해결 기준 (공정거래위원회 고시)에 준하여 처리됨
								</li>
								<li>대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의<br>
									소비자 보호에 관한 법률에 따라 처리함
								</li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>





<!-- 오른쪽 사이드 sticky탭 -->
<div class="sideTag">
	<div class="sticky">
		<ul class="nav nav-tabs " id="side_nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#bookinfoTag">상품정보</a></li>
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#bookReviewTag">회원리뷰</a></li>
			<li class="nav-item"><a class="nav-link active"
				aria-current="page" href="#boxDetailTag">교환/반품/품절</a></li>
		</ul>
		<!-- 이선아 참고부분 -->
		<!-- 			<script>
// 				$(function(){
// 				})
				
// 				function asdf() {
// 					$("#reviewWrite").append("<div id='ffff'>ahsdjfkhjsadf</div>")
// 				}
// 				function 등록() {
// 					데이터 인서트하도록 만들기
// 					$("#ffff").지우는펑션;
// 				}
// 				function 취소() {
// 					$("#ffff").지우는펑션;
// 				}
				
			</script> -->

		<!-- 오른쪽 사이드 quick메뉴탭 -->
		<div id="quick_menu2" class="quickSticky" style="width: 60px;">
			<div id="reviewWrite"></div>
			<div class="btn_quick_top" onclick="asdf()">
				<a href="#">Top</a>
				<!-- 페이지 가장 상단으로 보내주는것은 #Top하면 그냥 자동으로 됨 -->
			</div>
			<div class="btn_quick_down">
				<a href="#Down">Down</a>
				<!-- footer.jsp에 태그위치 설정해두었음 -->
			</div>
		</div>
	</div>
</div>



<!-- 	<script src='/js/search_detail.js'></script> -->