<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/signIn.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {

						var extraRoadAddr = '';

						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}

						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}

						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						document.getElementById('postcode').value = data.zonecode;
						document.getElementById("jibunAddress").value = data.jibunAddress;

						if (roadAddr !== '') {
							document.getElementById("extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");

						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
</script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">

<style>
/* #content { */
/* 	margin: 0 auto; */
/* 	float: none; */
/* 	height: 100%; */
/* } */

#content {
    width: 800px;
    margin: 340px 0 120px 560px;
    float: none;
    height: 100%;
}

table {
	width: 650px;
	height: 200px;
}

.title {
	font-size: 14px;
	text-align: left;
	padding-left: 100px;
	color: #555;
}

input {
	width: 225px;
	height: 30px;
	
	
  font-size: 15px;
  border: 0;
  border-radius: 5px;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
	
	
}

td {
	text-align: left;
	padding-left: 200px;
}

#right {
	padding-left: 80px;
}

#img1 {
	width: 100px;
	height: 40px;
	margin-top: 30px;
}

#submitbtn {
	border: 0;
	outline: none;
	width: 100px;
	height: 100px;
	border-radius: 5px;
	font-size: 14px;
	margin: 30px;
	box-shadow: 3px 3px 3px rgb(109, 109, 109), -3px -3px 3px
		rgb(237, 237, 237);
	transition: 0.3s;
}

#postbtn {
	margin-left: 5px;
	border: 0;
	outline: none;
	width: 120px;
	height: 25px;
	border-radius: 5px;
	font-size: 14px;
	box-shadow: 3px 3px 3px rgb(109, 109, 109), -3px -3px 3px
		rgb(237, 237, 237);
	transition: 0.3s;
}

#submitbtn:hover, #postbtn:hover {
	box-shadow: -3px -3px 3px rgb(172, 172, 172), 3px 3px 3px
		rgb(237, 237, 237);
	transition: 0.3s;
}

#gendersel {
	width: 224px;
	height: 30px;
	font-size: 13px;
  border: 0;
  border-radius: 5px;
  outline: none;
  padding-left: 10px;
  background-color: rgb(233, 233, 233);
}

#signInForm {
	width: 100%;
	margin-top: 309px;
	margin-bottom: 100px;
	
}
</style>
</head>
<body>

	<div id="signInForm">
		<form action="signInProc" method="post">


			<legend>
				<img id="img1" src="resources/img/logo3.png" /><br /> <span
					style="font-size: 20px; font-family: impact; color: #555">회 원 가 입</span>
			</legend>
			<table>
				<tr>
					<td class="title">아이디</td>
					<td class="right" colspan="2"><input id="id" name="id"
						type="text" required autofocus></td>
				</tr>
				<tr>
					<td class="title">비밀번호</td>
					<td class="right" colspan="2"><input id="pwd" name="pwd"
						type="password" required></td>
				</tr>
				<tr>
					<td class="title">닉네임</td>
					<td class="right" colspan="2"><input id="nickname"
						name="nickname" type="text" required></td>
				</tr>
				<tr>
					<td class="title">성별</td>
					<td class="right" colspan="2"><select name="gender"
						id="gendersel">
							<option value="none">==선택==</option>
							<option value="남성">남성</option>
							<option value="여성">여성</option>
					</select></td>
				</tr>
				<tr>
					<td class="title">나이</td>
					<td class="right" colspan="2"><input id="age" name="age"
						type="text" required></td>
				</tr>
				<tr>
					<td class="title">이름</td>
					<td class="right" colspan="2"><input id="name" name="name"
						type="text" required></td>
				</tr>
				<tr>
					<td class="title">전화번호</td>
					<td class="right" colspan="2"><input id="phone" name="phone"
						type="text" required></td>
				</tr>
				<tr>
					<td class="title">우편번호</td>
					<td class="right" colspan="2"><input type="text" id="postcode"
						placeholder="우편번호"> <input id="postbtn" type="button"
						name="postcode" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"></td>
				</tr>
				<tr>
					<td class="title">주소1</td>
					<td class="right" colspan="2"><input type="text" name="addr1"
						id="jibunAddress" placeholder="지번주소"></td>

				</tr>
				<tr>
					<td class="title">주소2</td>
					<td colspan="2"><input type="text" id="detailAddress"
						name="addr2" placeholder="상세주소"></td>
				</tr>

				<tr>
					<td class="title">이메일</td>
					<td class="right" colspan="2"><input id="email" name="email"
						type="text" required><input id="postbtn" type="submit"
						name="mail" onclick="alert('인증메일이 발송되었습니다.')" value="인증메일 발송"></td>
				</tr>

			</table>
			<input id="submitbtn" type="submit" value="가 입"
				style="width: 380px; margin: 20px 0 0 65px; height: 35px; font-size: 13px; font-family: impact; font-weight: bolder;;" />
		</form>
	</div>
</body>
</html>


