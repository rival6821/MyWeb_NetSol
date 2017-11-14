<%@page import="comment.commentBean"%>
<%@page import="java.util.List"%>
<%@page import="comment.commentDAO"%>
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

#com_submit {
	height: 70px;
	width: 92px;
}

#com_submit:hover {
	cursor: pointer;
	box-shadow: 1px 1px 1px gray;
}

#comment_tb td, th {
	height: 25px;
	padding-left: 10px;
	border: none;
}


</style>

<script src="../js/jquery-3.2.1.js"></script>
<script>
$(document).ready(function(){
	$("td[class^='hideCom']").css('display','none');
})
	
	function check() {
		if (!(document.fr.content.value)) {
			alert("댓글 내용을 입력해 주세요.");
			document.fr.content.focus();
			return false;
		}
		return true;
	}//댓글입력체크


 	function commentUpdate(num,pageNum,comNum) {
		var comContent = $('.updateCom'+comNum).val();
		if(comContent!=""){
 		location.href = "commentUpdatePro.jsp?num="+num+"&pageNum="+pageNum+
 				"&comNum=" + comNum+"&comContent=" + comContent;
 		}else{
 			alert("댓글 내용을 입력해주세요");
 		}
	}//업데이트
	
	function commentDelete(num,pageNum,com_num) {
		if(confirm('정말 삭제하시겠습니까?')){
			location.href="commentDelete.jsp?num="+num+"&pageNum="+pageNum+"&comNum=" + com_num;
		}
	}//댓글 삭제
	
	function hideCom(num){
		$('.hideCom'+num).toggle().css('padding-left','20px');
	}
</script>

</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String id = (String) session.getAttribute("id");
		int num = Integer.parseInt(request.getParameter("num"));
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		boardBean bb = new boardBean();
		boardDAO bdao = new boardDAO();
		bdao.updateReadcount(num);//조회수증가
		//글수정 글삭제
		bb = (boardBean) bdao.getBoard(num);
		String content =bb.getContent().replace("\r\n", "<br>");
	%>

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
					<td class="center">파일</td>
					<%
						if (bb.getFile() == null) {
					%>
					<td colspan="3" style="padding-left: 10px">파일없음</td>
					<%
						} else {
					%>
					<td colspan="3" style="padding-left: 10px"><a
						href="../upload/<%=bb.getFile()%>"><%=bb.getFile()%></a><img
						alt="" src="../upload/<%=bb.getFile()%>" width="20px"
						height="20px"></td>
					<%
						}
					%>
				</tr>
				<tr height="250px;">
					<td class="center">글 내용</td>
					<td colspan="3" style="padding-left: 10px;"><%=content%></td>
				</tr>
				<tr>
					<td colspan="4" width="600px" class="center">
						<%
							if (id != null) {
								if (id.equals(bb.getName())) {
						%><input type="button" value="글수정" class="bt"
						onclick="location.href='updateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						<input type="button" value="글삭제" class="bt"
						onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						<%
							}
						%> <input type="button" value="답글쓰기" class="bt"
						onclick="location.href='rewrite.jsp?num=<%=num%>&re_ref=<%=bb.getRe_ref()%>&re_lev=<%=bb.getRe_lev()%>&re_seq=<%=bb.getRe_seq()%>'">
						<%
							}
						%><input type="button" value="글목록"
						onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'"
						class="bt">
					</td>
				</tr>
			</table>
			<!-- 댓글 보기 -->
			<%
				commentDAO cdao = new commentDAO();
				List commentList = null;
				int count = cdao.getCommentCount(num);
				if (count != 0) {
					commentList = cdao.getCommentList(num);
				}
			%>
			<p style="padding-left: 27px;">
				댓글 :
				<%=count%>
				개
			</p>
			<table id="comment_tb">
				<%
					if (count == 0) {
				%>
				<tr>
					<td style="width: 590px; text-align: center;font-weight: bold;">댓글 없음</td>
				</tr>
				<%
					} else {
						for (int i = 0; i < commentList.size(); i++) {
							commentBean cb = (commentBean) commentList.get(i);
				%>
				<tr style="background-color: #e2e2e2;">
					<td style="font-weight: bold;"><%=cb.getCom_id()%></td>
					<td
						style="text-align: right; padding: 0 10px 0 0; font-size: 11px;"><%=cb.getCom_date()%>
						<%
							if (id != null) {
										if (id.equals(cb.getCom_id())) {
						%>
						<input type="button" value="댓글수정" class="bt" onclick="hideCom(<%=cb.getCom_num() %>)">
						<input type="button" value="댓글삭제" class="bt"
						onclick="commentDelete(<%=cb.getCom_board()%>,<%=pageNum%>,<%=cb.getCom_num()%>)">
						<%
							}
									}
						%></td>
				</tr>
				<tr>
					<td colspan="2" style="width: 590px;"><%=cb.getCom_content()%>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="hideCom<%=cb.getCom_num()%>" ><input type="text" value="<%=cb.getCom_content()%>" 
					style="width:400px;"  class="updateCom<%=cb.getCom_num()%>">
						<input type="button" value="댓글수정하기" class="bt"
						onclick="commentUpdate(<%=cb.getCom_board()%>,<%=pageNum%>,<%=cb.getCom_num()%>)">
					</td>
				</tr>
				<%
					}//for
					}
				%>
			</table>
			<br>
			<!-- 댓글작성 -->
			<form action="commentWritePro.jsp" name="fr"
				onsubmit="return check();">
				<table border="1" id="comment_btn">
					<tr>
						<%
							if (id != null) {
						%>
						<td><textarea rows="4" cols="65" placeholder="댓글을 작성해 주세요."
								name="com_content" style="width: 500px;"></textarea></td>
						<td><input type="submit" value="댓글 쓰기" id="com_submit"></td>
						<%
							} else {
						%>
						<td><textarea rows="4" cols="65"
								placeholder="댓글을 작성을 위해서는 로그인을 해주세요." name="content"
								style="width: 500px;" readonly></textarea></td>
						<td><input type="button" value="로그인필요" id="com_submit"></td>
						<%
							}
						%>
					</tr>
				</table>
				<input type="hidden" name="com_id" value=<%=id%>> <input
					type="hidden" name="com_board" value=<%=num%>> <input
					type="hidden" name="pageNum" value=<%=pageNum%>>
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