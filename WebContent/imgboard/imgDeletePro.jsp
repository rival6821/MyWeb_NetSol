<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>network solutions</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String pass = request.getParameter("pass");
	%>
		<%
		boardDAO bdao = new boardDAO();
		int check = bdao.imgDeleteBoard(num, pass);
		if (check == 1) {
	%>
	<script type="text/javascript">
		alert("글을 삭제했습니다.");
		location.href = "imgList.jsp?pageNum=<%=pageNum%>";
	</script>
	<%
		} 
		if (check == -1){
	%>
	<script type="text/javascript">
		alert("비밀번호가 다릅니다.");
		history.back();
	</script>
	<%
		}
	%>
</body>
</html>