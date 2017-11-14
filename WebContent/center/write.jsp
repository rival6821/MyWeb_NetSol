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
#write_tb table {
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
<%if(session.getAttribute("id")==null){%>
<script>
	location.href="../main/main.jsp";
	</script>
<%}%>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 메인이미지 -->

		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="notice.jsp">File Board</a></li>
				<li><a href="#">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 왼쪽메뉴 -->

		<!-- 게시판 -->
		<article>
		<h1>File Board</h1>
			<div id="write_tb">
				<form name="fr" action="writePro.jsp" method="post"
					onsubmit="return submit_check()" enctype="multipart/form-data">
					<table>
						<tr>
							<td width="100px" class="center">작성자</td>
							<td style="padding-left: 10px"><input type="text"
								name="name" class="text" value="<%=session.getAttribute("id")%>" readonly></td>
						</tr>
						<tr>
							<td width="100px" class="center">비밀번호</td>
							<td style="padding-left: 10px"><input type="password"
								name="pass" class="text" placeholder="비밀번호를 입력해 주세요."></td>
						</tr>
						<tr>
							<td width="100px" class="center">글 제목</td>
							<td style="padding-left: 10px"><input type="text"
								name="subject" placeholder="제목을 입력해 주세요." class="text"></td>
						</tr>
						<tr>
							<td width="100px" class="center">파일</td>
							<td style="padding-left: 10px"><input type="file"
								name="file" class="text"></td>
						</tr>
						<tr>
							<td width="100px" class="center">글 내용</td>
							<td><textarea name="content" rows="15" cols="50"
									placeholder="내용을 작성해 주세요."></textarea></td>
						</tr>
						<tr>
							<td colspan="2" width="600px" class="center"><input
								type="submit" value="글쓰기" class="bt"> <input
								type="reset" value="다시쓰기" class="bt"></td>
						</tr>
					</table>
				</form>
			</div>
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