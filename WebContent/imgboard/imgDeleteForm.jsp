<%@page import="board.boardBean"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시글 작성</title>
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
	return true;
}}//submit_check();

</script>
</head>
<body>
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
			<%
		request.setCharacterEncoding("utf-8");
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		boardBean bb = new boardBean();
		boardDAO bdao = new boardDAO();
		bb = (boardBean) bdao.getImgBoard(num);
	%>
		<h1>Gallery Board</h1>
<form action="imgDeletePro.jsp?num=<%=num%>&pageNum=<%=pageNum%>"
		method="post" name="fr" onsubmit="return submit_check()">
		<table>
			<tr>
				<th class="center" style="width: 140px">게시글번호</th>
				<td style="width: 200px;padding-left: 10px"><%=num%></td>
			</tr>
			<tr>
				<th class="center" style="width: 140px">작성자</th>
				<td style="width: 200px;padding-left: 10px"><%=bb.getName()%></td>
			</tr>
			<tr>
				<th class="center">비밀번호 확인</th>
				<td style="padding-left: 10px"><input type="password"
					name="pass" class="text"></td>
			</tr>
			<tr>
				<th colspan="2" class="center"><input type="submit"
					value="글 삭제" class="bt"> <input type="button" value="글목록"
					onclick="location.href='imgList.jsp?pageNum=<%=pageNum%>'" class="bt"></th>
			</tr>
		</table>
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