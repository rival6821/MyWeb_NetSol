<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String realPath = request.getRealPath("/upload");
	System.out.println(realPath);
	int maxSize = 5 * 1024 * 1024;
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8",
			new DefaultFileRenamePolicy());
	boardBean bb = new boardBean();
	boardDAO bdao = new boardDAO();
	String existingFile = multi.getParameter("existingFile");
	Enumeration<String> fileNames = multi.getFileNames();
	if(fileNames.hasMoreElements()){
		String fileName = fileNames.nextElement();
		String updateFile = multi.getFilesystemName(fileName);
		if(updateFile==null){
			bb.setFile(existingFile);
		}else{
			bb.setFile(updateFile);
		}
	}
	bb.setName(multi.getParameter("name"));
	bb.setPass(multi.getParameter("pass"));
	bb.setSubject(multi.getParameter("subject"));
	bb.setContent(multi.getParameter("content"));
	
		int check = bdao.updateBoard(bb, num);
		if (check == 1) {
	%>
	<script type="text/javascript">
		alert("글 내용이 수정되었습니다.");
		location.href = "content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>
	<%
		}
		if (check == -1) {
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