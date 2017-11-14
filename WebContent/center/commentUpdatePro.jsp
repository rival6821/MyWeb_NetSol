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
	int comNum = Integer.parseInt(request.getParameter("comNum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String comContent = request.getParameter("comContent");
	commentDAO cdao = new commentDAO();
	int check = cdao.updateComment(comContent, comNum);
	if (check==1){
		%>
		<script>
		alert("댓글이 수정 되었습니다.");
		location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>"
		</script>
		<%
	}%>
</body>
</html>