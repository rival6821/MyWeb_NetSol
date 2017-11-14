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
		return true;
	}//form_check()

</script>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String id = (String) session.getAttribute("id");
if (id == null) {
	response.sendRedirect("loginForm.jsp");
}
%>
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
			<h1>Withdraw</h1>
			<form action="deletePro.jsp" id="join" method="post"
				onsubmit="return form_check()" name="userinfo">
				<fieldset>
					<legend>Delete Info</legend>
					<label>아이디</label> <input type="text" name="id" class="id"><br>
					<label>비밀번호</label> <input type="password" name="pass"><br>
					<label>비밀번호 재입력</label> <input type="password" name="pass2"><br>
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