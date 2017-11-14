<%@page import="board.boardBean"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>network solutions</title>
<link href="../css/default.css?v=1" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?v=1" rel="stylesheet" type="text/css">
<style>

table {
	margin: auto;
	border-collapse: collapse;
}

td, th {
	border: 1px solid #999;
	height: 30px;
}

.bt:hover {
	cursor: pointer;
	box-shadow: 1px 1px 1px gray;
}

.center {
	text-align: center;
	background-color: #f5f5f5;
	font-weight: bold;
}
</style>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("id");
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		boardBean bb = new boardBean();
		boardDAO bdao = new boardDAO();
		bdao.updateImgReadcount(num);//조회수증가
		//글수정 글삭제
		bb = (boardBean) bdao.getImgBoard(num);
		String content =bb.getContent().replace("\r\n", "<br>");
	%>

	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_img"></div>
		<!-- 메인이미지 -->

		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="imgList.jsp">Gallery Board</a></li>
				<li><a href="#">Puppy</a></li>
				<li><a href="#">Cat</a></li>
				<li><a href="#">Car</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
		<h1>Gallery Board</h1>
			<table id="content">
				<tr>
					<td width="100px" class="center">글번호</td>
					<td width="200px" style="padding-left: 10px"><%=num%></td>
					<td width="100px" class="center">조회수</td>
					<td style="padding-left: 10px"><%=bb.getReadcount()%></td>
				</tr>
				<tr>
					<td class="center">작성자</td>
					<td style="padding-left: 10px"><%=bb.getName()%></td>
					<td class="center">작성일</td>
					<td style="padding-left: 10px"><%=bb.getDate()%></td>
				</tr>
				<tr>
					<td class="center">글 제목</td>
					<td colspan="3" style="padding-left: 10px"><%=bb.getSubject()%></td>
				</tr>
				<tr>
				<td class="center">파일명</td>
				<td colspan="3" style="padding-left: 10px"><%=bb.getFile()%></td>
				</tr>
				<tr>
					<%
						if (bb.getFile() == null) {
					%>
					<td colspan="3" style="padding-left: 10px">파일없음</td>
					<%
						} else {
					%>
					<td colspan="4" style="padding-left: 6px"><a
						href="../upload/<%=bb.getFile()%>"><img
						alt="" src="../upload/<%=bb.getFile()%>" width="600px"
						></a></td>
					<%
						}
					%>
				</tr>
				<tr height="100px;">
					<td class="center">글 내용</td>
					<td colspan="3" style="padding-left: 10px;"><%=content%></td>
				</tr>
			
				<tr>
					<td colspan="4" width="600px" class="center"><%if(id!=null){if(id.equals(bb.getName())){ %><input
						type="button" value="글수정" class="bt"
						onclick="location.href='imgUpdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						<input type="button" value="글삭제" class="bt"
						onclick="location.href='imgDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"><%}} %>
						<input type="button" value="글목록"
						onclick="location.href='imgList.jsp?pageNum=<%=pageNum%>'"
						class="bt"></td>
				</tr>
			</table>
		</article>
		<!-- 게시판 -->
		<!-- 본문들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터들어가는 곳 -->
	</div>
</body>
</html>