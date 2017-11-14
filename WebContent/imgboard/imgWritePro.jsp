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
		//cos.jar프로그램 설치
		//파일업로드 - MultipartRequest 생성
		String realPath = request.getRealPath("/upload");
	System.out.println(realPath);
		int maxSize = 5 * 1024 * 1024;
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "utf-8",
				new DefaultFileRenamePolicy());
		//게시판글 저장하는 자바빈
		//패키지 board폴더 만들고 파일이름 boardBean
		//디비작업하는 파일
		//boardDAO생성 insertBoard()생성
		//insertBoard bb메서드 호출
		//list.jsp로 이동
		boardBean bb = new boardBean();
		boardDAO bdao = new boardDAO();
		bb.setName(multi.getParameter("name"));
		bb.setPass(multi.getParameter("pass"));
		bb.setSubject(multi.getParameter("subject"));
		bb.setContent(multi.getParameter("content"));
		bb.setFile(multi.getFilesystemName("file"));
		System.out.println("업로드된 파일이름 : "+multi.getFilesystemName("file"));
		System.out.println("업로드 할때 원 파일이름 : "+multi.getOriginalFileName("file"));
		bdao.insertImgBoard(bb);
	%>
	<script type="text/javascript">
		alert("글 작성 완료!");
		location.href = "imgList.jsp"
	</script>
</body>
</html>