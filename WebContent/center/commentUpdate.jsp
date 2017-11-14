<%@page import="java.util.List"%>
<%@page import="comment.commentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("utf-8");
	int com_num = Integer.parseInt(request.getParameter("comNum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	commentDAO cdao = new commentDAO();
	String com_content = cdao.getComment(com_num);
%>
<script>
	function check() {
		if (!(document.fr.content.value)) {
			alert("댓글 내용을 입력해 주세요.");
			document.fr.content.focus();
			return false;
		}
		return true;
	}//댓글입력체크
</script>
<style type="text/css">
table {
	margin: auto;
	border-collapse: collapse;
}
td, th {
	border: 1px solid #999;
}
#com_submit {
	height: 70px;
	width: 92px;
}

#com_submit:hover {
	cursor: pointer;
	box-shadow: 1px 1px 1px gray;
}
</style>
</head>
<body>
	<form action="commentUpdatePro.jsp" onsubmit="return check()" name="fr">
		<table id="comment_btn">
			<tr>
				<td><textarea rows="4" cols="65" name="com_content"
						style="width: 400px;"><%=com_content%></textarea></td>
				<td><input type="submit" value="댓글 수정" id="com_submit"></td>
			</tr>
		</table>
		<input type="hidden" name="com_num" value="<%=com_num%>"> <input
			type="hidden" name="num" value="<%=num%>"> <input
			type="hidden" name="pageNum" value="<%=pageNum%>">
	</form>
</body>
</html>