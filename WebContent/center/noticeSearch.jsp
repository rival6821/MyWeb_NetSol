<%@page import="comment.commentDAO"%>
<%@page import="comment.commentBean"%>
<%@page import="board.boardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>network solutions</title>
<link href="../css/default.css?v=1" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?v=1" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
	<%
	//검색어가져오기 한글처리필요
		request.setCharacterEncoding("utf-8");
		String search = (String)request.getParameter("search");
		commentDAO cdao = new commentDAO();
		boardDAO bdao = new boardDAO();
		int count = bdao.getBoardCount(search);
		int pageSize = 15;//한페이지에 보여줄 글의 수
		String pageNum = request.getParameter("pageNum");
		if (pageNum == null) {
			pageNum = "1";
		} //페이지번호가 없으면 1페이지.
		int currentPage = Integer.parseInt(pageNum);//현재페이지
		int startRow = (currentPage - 1) * pageSize + 1;//현재페이지의 시작글
		int endRow = currentPage * pageSize;//현재페이지의 마지막글
		//디비에서 게시판글가져오기 시작행, 페이지사이즈,
		List boardList = null;
		if (count != 0) {
			boardList = bdao.getBoardList(startRow, pageSize, search);
			//sql 모든글 가져오기 정렬 re_ref내림차순, re_seq 오름차순, 제목에 search 포함.
			//limit 첫행-1,갯수
		}
		int number = 0;
		number=count-(currentPage-1)*pageSize;
	%>
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 메인이미지 -->
		<div id="sub_img_center">
		</div>
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
		<%
		//전체 글개수 구하기
		//DB작업 BoardDAO bda객체생성
		//int count = getBoardCount()함수호출
		//한화면에 보여줄 글 개수 15개
		//현페이지 번호 가져오기
		//가져올 글 시작행번호 구하기
		//끝행번호 구하기
		//List boardList = getBoardList(시작행번호,가져올글개수)
		%>
			<h1>File Board</h1>
			<table id="notice">
				<tr style="text-align: center;">
					<th class="tno">No.</th>
					<th class="ttitle">Title</th>
					<th class="twrite">Writer</th>
					<th class="tdate">Date</th>
					<th class="tread">Read</th>
				</tr>
				<%
					if (count == 0) {
				%><tr>
					<td colspan="5">글없음!</td>
				</tr>
				<%
					} else {
						for (int i = 0; i < boardList.size(); i++) {
							boardBean bb = (boardBean) boardList.get(i);
				%>
				<tr>
					<td><%=number--%></td>
					<td style="text-align: left; padding-left: 10px;" id="subject">
						<%
							int wid = 0;
									if (bb.getRe_lev() > 0) {
										wid = bb.getRe_lev() * 10;
						%> <img alt="" src="../images/center/level.gif" width="<%=wid%>px"
						height="10px"> <img alt="" src="../images/center/reply.png"
						height="10px"> <%
 	}
 %> 
 						<%
						commentBean cb = new commentBean();
						int commentCount= cdao.getCommentCount(bb.getNum());
						%><a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%>
						<% if(commentCount!=0){%><span id="commentCount"><%=commentCount %><%} %></span></a>
					</td>
					<td><%=bb.getName()%></td>
					<td><%=bb.getDate()%></td>
					<td><%=bb.getReadcount()%></td>
				</tr>
				<%
					}
					}
				%>
			</table>
			<div id="table_search">
			<form action="noticeSearch.jsp" >
				<input type="text" name="search" class="input_box" placeholder="글 제목 검색"> <input
					type="submit" value="search" class="btn">
			</form>
			</div>
			<div class="clear"></div>

			<div id="page_control">
				<%
					//게시판의 전체 페이지 개수 구하는 식
					//게시판 글수50개 한화면에 보여줄 페이지수 10개->페이지수 계산
					int pageCount = (count / pageSize) + ((count % pageSize == 0) ? 0 : 1);//게시판의 전체 페이지 개수 
					int pageBlock = 5;//한화면에 보여줄 페이지수
					int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;//페이지 시작번호
					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount) {
						endPage = pageCount;
					} //페이지끝번호
					if (startPage > pageBlock) {
				%><a href="noticeSearch.jsp?pageNum=<%=startPage - pageBlock%>&search=<%=search%>">Prev</a>
				<%
					} //페이지이전버튼
					for (int i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
				%>
				<a href="#" style="font-weight: bold;"><%=i%></a>
				<%
					} else {
				%>
				<a href="noticeSearch.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i%></a>
				<%
					}
					}
				%>
				<%
					if (endPage < pageCount) {
				%>
				<a href="noticeSearch.jsp?pageNum=<%=startPage + pageBlock%>&search=<%=search%>">Next</a>
				<%
					} //페이지다음버튼
				if(session.getAttribute("id")!=null){
				 %>
				<a href="write.jsp">[글쓰기]</a>
				<%} %>
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