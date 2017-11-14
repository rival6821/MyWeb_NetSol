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
	%>
	<jsp:useBean id="mb" class="member.memberBean" />
	<jsp:setProperty property="*" name="mb" />
	<%
		memberDAO mdao = new memberDAO();
		int check = mdao.updateMember(mb);
		if (check == 1) {
	%>
	<script type="text/javascript">
		alert("회원정보가 수정되었습니다.");
		location.href = "../main/main.jsp";
	</script>
	<%
		}
		if (check == 0) {
	%>
	<script type="text/javascript">
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
	</script>
	<%
		}
	%>

</body>
</html>