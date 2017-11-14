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
		int check = mdao.deleteMember(id, pass);
		if (check == 1) {
		session.invalidate();
	%>
	<script type="text/javascript">
		alert("회원정보를 삭제했습니다.");
		location.href = "login.jsp";
	</script>
	<%
		} else if (check == 0) {
	%>
	<script type="text/javascript">
		alert("비밀번호가 다릅니다.");
		location.href = "deleteForm.jsp";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("아이디가 다릅니다.");
		location.href = "deleteForm.jsp";
	</script>
	<%
		}
	%>
</body>
</html>