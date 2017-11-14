<%@page import="comment.commentDAO"%>
<%@page import="comment.commentBean"%>
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
<link href="../css/front.css?v=1" rel="stylesheet" type="text/css">

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
	<div id="wrap">
		<!-- 헤더파일들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더파일들어가는 곳 -->
		<!-- 메인이미지 들어가는곳 -->
		<div class="clear"></div>
		<div id="main_img">
			<img src="../images/banner/techfocus-banner.png" width="953"
				height="179">
		</div>
		<!-- 메인이미지 들어가는곳 -->
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<article id="front">
			<div id="solution">
				<div id="hosting">
					<h3>Network Solutions</h3>
					<p>Why choose Network Solutions Based in Busan, we offer
						unbeatable IT, Communication, Network & Security solutions across
						the North East and nationwide, delivering flexible, fast and
						efficient systems suited to your business.</p>
				</div>
				<div id="security">
					<h3>Network Security</h3>
					<p>Network security combines multiple layers of defenses at the
						edge and in the network. Each network security layer implements
						policies and controls. Authorized users gain access to network
						resources, but malicious actors are blocked from carrying out
						exploits and threats.</p>
				</div>
				<div id="payment">
					<h3>Network Payment</h3>
					<p>A payment system is any system used to settle financial
						transactions through the transfer of monetary value, and includes
						the institutions, instruments, people, rules, procedures,
						standards, and technologies that make such an exchange possible.</p>
				</div>
			</div>
			<div class="clear"></div>
			<div id="sec_news">
				<%
					request.setCharacterEncoding("utf-8");
					boardDAO bdao = new boardDAO();
					commentDAO cdao = new commentDAO();
					int count = bdao.getImgBoardCount();
					String pageNum = "1";
					int pageSize = 3;
					List boardList = bdao.getImgBoardList(1, pageSize);
				%>
				<h3 style="padding-left: 30px; color: #0C2235">Gallery Board</h3>
				<table>
					<tr>
						<%
							if (count == 0) {
						%>
						<td colspan="3">글없음!</td>
						<%
							} else {
								for (int i = 0; i < 3; i++) {
									boardBean bb = (boardBean) boardList.get(i);
						%>
						<td id="main_img_sample"><a
							href="../imgboard/imgContent.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><img
								alt="" src="../upload/<%=bb.getFile()%>" width="130px"
								height="130px" style="border-radius: 8px;"><br><%=bb.getSubject()%></a></td>
						<%
							}
							}
						%>
					</tr>
				</table>
			</div>
			<div id="news_notice">
				<!-- 최근글 5개만 가져오기 -->
				<%
					count = bdao.getBoardCount();
					pageSize = 5;//한페이지에 보여줄 글의 수
					//페이지번호가 없으면 1페이지.
					//디비에서 게시판글가져오기 시작행, 페이지사이즈,
					boardList = null;
					if (count != 0) {
						boardList = bdao.getBoardList(1, pageSize);
						//sql 모든글 가져오기 정렬 re_ref내림차순, re_seq 오름차순
						//limit 첫행-1,갯수
					}
				%>
				<h3 class="brown">File Board</h3>
				<table>
					<%
						if (count == 0) {
					%>
					<tr>
						<td colspan="2">글없음!</td>
					</tr>
					<%
						} else {
							for (int i = 0; i < boardList.size(); i++) {
								boardBean bb = (boardBean) boardList.get(i);
								commentBean cb = new commentBean();
								int commentCount = cdao.getCommentCount(bb.getNum());
					%>
					<tr>
						<td class="contxt">
							<%
								int wid = 0;
										if (bb.getRe_lev() > 0) {
											wid = bb.getRe_lev() * 10;
							%> <img alt="" src="../images/center/level.gif"
							width="<%=wid%>px" height="10px"> <img alt=""
							src="../images/center/reply.png" height="10px"> <%}%> 
							<a href="../center/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>"><%=bb.getSubject()%> <%
									if (commentCount != 0) {
								%><span id="commentCount"><%=commentCount%> <%
 	}
 %></span></a>
						</td>
						<%
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
						%>
						<td><%=sdf.format(bb.getDate())%></td>
					</tr>
					<%
						}
						}
					%>
				</table>
			</div>
		</article>
		<!-- 메인 콘텐츠 들어가는 곳 -->
		<div class="clear"></div>
		<!-- 푸터 들어가는 곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는 곳 -->
	</div>
</body>
</html>