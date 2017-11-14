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
.text {
	border: none;
	border-bottom: 1px solid #999;
	padding: 4px;
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
<script type="text/javascript">
function submit_check() {
	if (document.fr.pass.value.length < 4) {
		alert("비밀번호를 4자이상 입력하세요.");
		document.fr.pass.focus();
		return false;
	}
	if (document.fr.subject.value == false) {
		alert("제목을 입력하세요.");
		document.fr.subject.focus();
		return false;
	}
	if (document.fr.content.value == false) {
		alert("글내용을 입력해주세요.");
		document.fr.content.focus();
		return false;
	}
	return true;
}//submit_check();
</script>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		boardBean bb = new boardBean();
		boardDAO bdao = new boardDAO();
		bb = (boardBean) bdao.getImgBoard(num);
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
			<form action="imgUpdatePro.jsp?num=<%=num%>&pageNum=<%=pageNum%>"
		method="post" name="fr" onsubmit="return submit_check()" enctype="multipart/form-data">
			<table id="content">
				<tr>
				<td class="center" width="100px">작성자</td>
				<td style="padding-left: 10px" width="200px"><%=bb.getName()%></td>
				<td class="center" width="100px">비밀번호</td>
				<td style="padding-left: 10px"><input type="password"
					name="pass" class="text"></td>
				</tr>
				<tr>
					<td class="center">글 제목</td>
					<td colspan="3" style="padding-left: 10px"><input type="text"
					value="<%=bb.getSubject()%>" name="subject" class="text"></td>
				</tr>
				<tr>
				<td class="center">기존파일</td>
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
						alt="" src="../upload/<%=bb.getFile()%>" width="300px"
						></a></td>
					<%
						}
					%>
				</tr>
				<td class="center">첨부파일</td>
				<td colspan="3" style="padding-left: 10px"><input type="file"
								name="file" class="text"></td>
				<tr height="50px;">
					<td class="center">글 내용</td>
					<td colspan="3" style="padding-left: 10px;"><textarea
						name="content" rows="10" cols="50"><%=bb.getContent()%></textarea></td>
				</tr>
			<tr>
				<td colspan="4" width="600px" class="center"><input
					type="submit" value="글수정" class="bt"> <input type="button" value="글목록"
					onclick="location.href='imgList.jsp?pageNum=<%=pageNum%>'" class="bt"></td>
			</tr>
			</table>
			<input type="hidden" name="existingFile" value="<%=bb.getFile()%>">
			</form>
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