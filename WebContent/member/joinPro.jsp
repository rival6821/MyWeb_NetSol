<%@page import="mail.sendMail"%>
<%@page import="mail.SendMailTest"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="member.memberBean"%>
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
	memberDAO mdao = new memberDAO();
%>
<jsp:useBean id="mb" class="member.memberBean" />
<jsp:setProperty property="*" name="mb" />
<%
	mb.setReg_date(new Timestamp(System.currentTimeMillis()));
	mdao.insertMember(mb);
%>
<script type="text/javascript">
	alert("회원가입을 축하합니다. \n회원가입축하 이메일이 발송되었습니다.");
	location.href = "login.jsp"
</script>
<%
	if(mb.getEmail_check().equals("ok")){
	String email = mb.getEmail();
	String id = mb.getId();
	sendMail smt = new sendMail();
	smt.SendMail(id, email);}
%>
</head>
<body>

</body>
</html>