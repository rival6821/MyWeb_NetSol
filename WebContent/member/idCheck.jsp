<%@page import="member.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	memberDAO mdao = new memberDAO();
	int check = mdao.idCheck(id);
%>
<style type="text/css">
body{
text-align : center;
}
body a{
text-decoration: none;
color : #333;
}
body a:hover{
color : orange;
cursor : pointer;
}
</style>
<script type="text/javascript">
function checkvalue(){
	opener.document.userinfo.dupCheck.value="check";
}
</script>
</head>
<body>
아이디 중복체크
<hr>
	<%
		if (check == 1) {
	%>
	이미 사용중인 id입니다.
	<br>
	<a href="#"
		onclick="opener.document.userinfo.id.focus(); window.close();">[닫기]</a>
	<%
		} else {
	%>
	사용가능한 id입니다.
	<br>
	<a href="#"
		onclick="checkvalue(); window.close();">[사용하기]</a>
	<%
		}
	%>
</body>
</html>