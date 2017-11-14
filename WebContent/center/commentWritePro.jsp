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
	%>
	<jsp:useBean id="cb" class="comment.commentBean"/>
	<jsp:setProperty property="*" name="cb"/>
	<%
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	commentDAO cdao = new commentDAO();
	cdao.insertCommentBoard(cb);
	int num = cb.getCom_board();
	%>
	<script type="text/javascript">
		alert("글 작성 완료!");
		location.href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>"
	</script>

</body>
</html>