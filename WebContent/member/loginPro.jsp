<%@page import="member.memberBean"%>
<%@page import="member.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
	%>
	<%
		memberDAO mdao = new memberDAO();
		int check = mdao.userCheck(id, pass);
		if (check == 1) {
			session.setAttribute("id", id);
			response.sendRedirect("../main/main.jsp"); 
		} else if (check == 0) {
	%>
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
	</script>
	<%
		} else if (check == -1) {
	%>
	<script>
		alert("아이디가 없습니다.");
		history.back();
	</script>
	<%
		}
	%>
</body>
</html>