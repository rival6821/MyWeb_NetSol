<%@page import="java.text.SimpleDateFormat"%>
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
		request.setCharacterEncoding("utf-8");
		String search = (String)request.getParameter("search");
		boardDAO bdao = new boardDAO();
		int count = bdao.getImgBoardCount(search);
		int pageSize = 5;//한페이지에 보여줄 글의 수
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
			boardList = bdao.getImgBoardList(startRow, pageSize, search);
			//sql 모든글 가져오기 정렬 re_ref내림차순, re_seq 오름차순
			//limit 첫행-1,갯수
		}
		int number = 0;
		number=count-(currentPage-1)*pageSize;
		int cols = 4;//한행에 나오길 원하는 열의 수, 원하는 만큼 고치면 됨
		int rows = ((boardList.size() - 1) / cols) + 1;//나오는 행의 수
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
				<%
					int count_img = 0;//게시글이 표시될때마다 1씩 증가
					if (count == 0) {
				%><h3 style="text-align:center;">글없음!</h3>
				<%
					} else {
						/* ****반복구문 시작**** */
						for (int i = 0; i < rows; i++) {//세로줄
							%>			
				<table style="margin:0 0 15px 0;">
				<tr>
					<%
						for (int j = 0; j < cols; j++, count_img++) {//가로줄,
				%>
			<!-- 마지막게시글에 테이블 닫는부분 -->
					<%if (count_img == boardList.size()) {%>
				</tr>
			</table>
			<%break;}//마지막게시글을 표시하고 모든 for구문을 빠져나감%>
	       <!-- 마지막게시글에 테이블 닫는부분 -->
	       <% boardBean bb = (boardBean) boardList.get(count_img); 
	       String content =bb.getContent();
	       if(bb.getContent().length()>25){
	    	   content = bb.getContent().substring(0, 24)+"...";
	       }
	       %>
					<td width="320" height="410" id="imgList">
						<a href="imgContent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>">
							<%
								if (bb.getFile() == null) {
							%> <img alt="" src="../image/image.png" width="307px"
							height="307px" style="margin-bottom:5px;"> <%
 	} else {
 %><img alt="" src="../upload/<%=bb.getFile()%>" width="307px"
							height="307px" style="border-radius: 8px;margin-bottom:5px;"> <%
 	}
 %><br><span id="img_subject"><%=bb.getSubject()%></span><br><br>
 <span id="img_content"><%=content%></span></a>
 <hr><%SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd"); %>
 <span id="img_date"><%= sdf.format(bb.getDate())%></span>
 <span id="img_name"><%=bb.getName()%></span></td>
    <!-- 한행의 테이블닫기 -->
			<%if (j == (cols - 1)) {//가로줄의 마지막 게시글이면 테이블을 닫음%>
				</tr>
			</table>
			<%}%>
	<!-- 한행의 테이블닫기 -->  
				<%}}}%>
			<!-- 검색버튼 -->
			<div id="table_search">
				<form action="imgListSearch.jsp" >
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
				%><a href="imgList.jsp?pageNum=<%=startPage - pageBlock%>">Prev</a>
				<%
					} //페이지이전버튼
					for (int i = startPage; i <= endPage; i++) {
						if (i == currentPage) {
				%>
				<a href="#" style="font-weight: bold;"><%=i%></a>
				<%
					} else {
				%>
				<a href="imgList.jsp?pageNum=<%=i%>"><%=i%></a>
				<%
					}
					}
				%>
				<%
					if (endPage < pageCount) {
				%>
				<a href="imgList.jsp?pageNum=<%=startPage + pageBlock%>">Next</a>
				<%
					} //페이지다음버튼
					if (session.getAttribute("id") != null) {
				%>
				<input type="button" value="글쓰기" class="writebtn" onclick="location.href='imgWrite.jsp'">
				<%
					}
				%>

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