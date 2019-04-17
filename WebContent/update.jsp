<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.DBManager"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = request.getParameter("id");
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open(); //  asc
		String sql = "select * from article where id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);

		ResultSet rs = stmt.executeQuery();
		if (rs.next()) {
			String num = rs.getString("id");
			String title = rs.getString("title");
			String contnet = rs.getString("contnet");
			String hit = rs.getString("hit");
			String id2 = rs.getString("id2");
%>
<form method="post" action="update_proc.jsp">
	제목 : <input type="text" name="title" value="<%=title%>"><br>
	내용 : <textarea name="contnet"><%=contnet%></textarea><br>
	<input type="hidden" name="id" value="<%=id%>">
	<input type="submit" value="수정완료">
<%-- 	<h1><%=title%>/<%=num%></h1> --%>
<%-- 	<p><%=contnet%></p> --%>
<%-- 	<p><%=hit%></p> --%>
<%-- 	<p><%=id2%></p> --%>
</form>
<%
	}

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>