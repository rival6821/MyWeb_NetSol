<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
		String realPath = request.getRealPath("/upload");
		System.out.println(realPath);
		int maxSize = 5 * 1024 * 1024;
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8",
				new DefaultFileRenamePolicy());
		boardBean bb = new boardBean();
		boardDAO bdao = new boardDAO();
		bb.setName(multi.getParameter("name"));
		bb.setPass(multi.getParameter("pass"));
		bb.setSubject(multi.getParameter("subject"));
		bb.setContent(multi.getParameter("content"));
		bb.setFile(multi.getFilesystemName("file"));
		System.out.println("업로드된 파일이름 : "+multi.getFilesystemName("file"));
		System.out.println("업로드 할때 원 파일이름 : "+multi.getOriginalFileName("file"));
		bdao.insertBoard(bb);
	%>
	<script type="text/javascript">
		alert("글 작성 완료!");
		location.href = "notice.jsp"
	</script>
</body>
</html>