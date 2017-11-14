<%@page import="java.sql.Date"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
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
	<jsp:useBean id="bb" class="board.boardBean" />
	<jsp:setProperty property="*" name="bb" />
	<%
		boardDAO bdao = new boardDAO();
		bdao.reInsertBoard(bb);
	%>
	<script type="text/javascript">
	alert("글 작성 완료!");
	location.href = "notice.jsp"
	</script>
</body>
</html>