<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>network solutions</title>
<link href="../css/default.css?v=1" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?v=1" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
<script type="text/javascript">
	function form_check() {
		var form = document.userinfo;
		if (form.id.value.length < 4) {
			alert("아이디를 4자이상 입력하세요.");
			form.id.focus();
			return false;
		}
		if (form.dupCheck.value != "check") {
			alert("아이디 중복체크를 하세요.");
			form.id.focus();
			return false;
		}
		if (form.pass.value.length < 4) {
			alert("비밀번호를 4자이상 입력하세요.");
			form.pass.focus();
			return false;
		}
		if (!(form.pass.value == form.pass2.value)) {
			alert("비밀번호가 일치하지 않습니다.");
			form.pass2.focus();
			return false;
		}
		if (!form.age.value) {
			alert("나이를 입력하세요.");
			form.age.focus();
			return false;
		}
		if (!form.name.value) {
			alert("이름을 입력하세요.");
			form.name.focus();
			return false;
		}
		if (!form.gender.value) {
			alert("성별을 입력하세요.");
			return false;
		}
		if (!form.email.value) {
			alert("이메일을 입력하세요.");
			form.email.focus();
			return false;
		}
		if (!(form.email.value == form.email2.value)) {
			alert("이메일이 일치하지 않습니다.");
			form.email2.focus();
			return false;
		}
		if (!(form.email_check.value)) {
			alert("이메일 발송여부를 확인해주세요.");
			return false;
		}
		return true;
	}//form_check()

	function idCheck() {
		var form = document.userinfo;
		if (form.id.value.length < 4) {
			alert("아이디를 4자이상 입력하세요.");
			form.id.focus();
 		} else {
			url = "idCheck.jsp?id=" + form.id.value;
			window.open(url, "idCheck",
					"toolbar=no, width=350, height=150, top=300, left=300");
		} 
	}//idCheck()
	
	function inputIdCheck(){
		document.userinfo.dupCheck.value = "unCheck";
	}//inputIdCheck()
</script>
</head>
<body>

	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_member"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="#">Join us</a></li>
				<!-- 구현 아직 안되었음 -->
				<li><a href="#">Privacy policy</a></li>
				<!-- 구현 아직 안되었음 -->
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>

			<h1>Join Us</h1>
			<form action="joinPro.jsp" id="join" method="post"
				onsubmit="return form_check()" name="userinfo">
				<fieldset>
					<legend>Basic Info</legend>
					<label>아이디</label> <input type="text" name="id" class="id" onkeydown="inputIdCheck()">
					<input type="button" value="ID중복확인" class="dup" onclick="idCheck()"><br>
					<label>비밀번호</label> <input type="password" name="pass"><br>
					<label>비밀번호 재입력</label> <input type="password" name="pass2"><br>
					<label>나이</label> <input type="number" name="age"><br>
					<label>이름</label> <input type="text" name="name"><br>
					<label>성별</label> <input type="radio" value="남자" name="gender"
						class="border_none"> 남자<br> <input type="radio"
						value="여자" name="gender" class="border_none"> 여자<br>
					<label>이메일</label> <input type="email" name="email"><br>
					<label>이메일 재입력</label> <input type="email" name="email2"><br>
					<label>이메일발송 동의여부</label><input type="radio" name="email_check" class="border_none" value="ok"> 동의함	
					<input type="radio" name="email_check" class="border_none" value="no"> 동의하지않음<br>
					*동의시 회원가입 축하 이메일이 발송됩니다.<br>
				</fieldset>
				<fieldset>
					<legend>Optional</legend>
					<label>우편번호</label> <input type="text" id="sample4_postcode" placeholder="우편번호" style="margin-right:20px;" name="zipcode">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="font-size: 12px;color:#333;"><br>
<label>도로명주소</label><input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="address" style="width:400px;">
<!-- <input type="text" id="sample4_jibunAddress" placeholder="지번주소"> -->
<span id="guide" style="color:#999"></span>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample4_roadAddress').value = fullRoadAddr;
                document.getElementById('sample4_jibunAddress').value = data.jibunAddress;

                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

                } else {
                    document.getElementById('guide').innerHTML = '';
                }
            }
        }).open();
    }
</script>
					<br> <label>전화번호</label> <input type="text" name="phone"><br>
					<label>휴대폰번호</label> <input type="text" name="mobile"><br>
					<input type="hidden" name="dupCheck" value="unCheck">
				</fieldset>
				<div class="clear"></div>
				<div id="buttons">
					<input type="submit" value="Submit" class="submit"> <input
						type="reset" value="Cancel" class="cancel">
				</div>
			</form>
		</article>
		<!-- 본문내용 -->
		<!-- 본문들어가는 곳 -->

		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>