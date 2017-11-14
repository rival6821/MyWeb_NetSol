<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
<%
String id = (String)session.getAttribute("id");
%>
<script src="../js/jquery-3.2.1.js"></script>
<script>
$(document).ready(function(){
	$('#home_logo').click(function(){
		location.href='../main/main.jsp';
	})
})

</script>
<style>
#home_logo:hover{
	cursor: pointer;
}
</style>
<div id = "home_logo"></div><div></div>
	<nav id="top_menu" style=" border-left: 7px solid tomato;
    border-right: 7px solid darkred;">
		<ul>
			<li><a href="../main/main.jsp">HOME</a></li>
			<li><a href="../company/welcome.jsp">INTRODUCE</a></li>
			<li><a href="#">MY DREAM</a></li>
			<li><a href="../center/notice.jsp">FILE BOARD</a></li>
			<li><a href="../imgboard/imgList.jsp">GALLERY BOARD</a></li>
		</ul>
		<ul id="menu_login">
			<li>
				<% if(id == null){ %><a href="../member/login.jsp">Log In</a>
				<%} else{ %>
				<a href="../member/logout.jsp">Log Out</a>
				<%} %>
			</li>
			<li><% if(id == null){ %><a href="../member/join.jsp">Join</a>
			<%} else{ %>
			<a href="../member/info.jsp"><%=id %>님</a>
				<%} %>
			</li>
		</ul>
	</nav>
</header>