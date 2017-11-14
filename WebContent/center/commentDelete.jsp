<%@page import="comment.commentDAO"%>
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
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int com_num = Integer.parseInt(request.getParameter("comNum"));
	commentDAO cdao = new commentDAO();
	cdao.deleteComment(com_num);
	%>
	<script>
	alert("글을 삭제했습니다.");
	location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>"
	</script>
</body>
</html>