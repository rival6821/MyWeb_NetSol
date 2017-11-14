<%@page import="member.memberBean"%>
<%@page import="member.memberDAO"%>
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
		if (form.pass.value.length < 4) {
			alert("비밀번호를 4자이상 입력하세요.");
			form.pass.focus();
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
		if (!form.age.value) {
			alert("나이를 입력해주세요.");
			form.age.focus();
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
		return true;
	}

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
				<li><a href="join.jsp">Join us</a></li>
				<li><a href="#">Privacy policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<%
			request.setCharacterEncoding("utf-8");
			String id = (String) session.getAttribute("id");
			if (id == null) {
				response.sendRedirect("login.jsp");
			}
			memberDAO mdao = new memberDAO();
			memberBean mb = mdao.getMember(id);
		%>
		<article>
			<h1>Member Info</h1>
				<form action="updatePro.jsp" id="join" method="post"
				onsubmit="return form_check()" name="userinfo">
				<fieldset>
					<legend>Basic Info</legend>
					<label>아이디</label> <input type="text" value="<%=mb.getId()%>" readonly name="id"><br>
					<label>비밀번호</label> <input type="password" name="pass"><br>
					<label>나이</label> <input type="number" value="<%=mb.getAge() %>" name="age"><br>
					<label>이름</label> <input type="text" value="<%=mb.getName() %>" name="name"><br>
					<label>성별</label> 
					<input type="radio" value="남자" name="gender" class="border_none" 
					<%=(mb.getGender().equals("남자"))?"checked":""%>> 남자<br> 
					<input type="radio" value="여자" name="gender" class="border_none" 
					<%=(mb.getGender().equals("여자"))?"checked":""%>> 여자<br>
					<label>이메일</label> <input type="text" value="<%=mb.getEmail() %>" name="email"><br>
 					<label>이메일발송 동의여부</label> 
					<input type="radio" value="ok" name="email_check" class="border_none" 
					<%=(mb.getEmail_check().equals("ok"))?"checked":"" %>> 동의함<br> 
					<input type="radio" value="no" name="email_check" class="border_none" 
					<%=(mb.getEmail_check().equals("no"))?"checked":"" %>> 동의하지않음<br>
				</fieldset>
				<fieldset>
					<legend>Optional</legend>
					<label>우편번호</label> <input type="text" value="<%=mb.getZipcode() %>" name="zipcode"><br>
					<label>도로명주소</label> <input type="text" value="<%=mb.getAddress() %>" name="address" style="width:400px;"><br>
					<label>전화번호</label> <input type="text" value="<%=mb.getPhone() %>" name="phone"><br>
					<label>휴대폰번호</label> <input type="text" value="<%=mb.getMobile() %>" name="mobile"><br>
					
				</fieldset>
				<div class="clear"></div>
						<div id="buttons">
					<input type="submit" value="Update Info" class="submit"> <input
						type="button" value="Delete Info" class="cancel" onclick="location.href='deleteForm.jsp'">
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