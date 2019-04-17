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

		//조회수 조작하기 (한사람이 여러번 할 수 있도록) 
		String sql2 = "update article set hit=hit + 1 where id = ?";
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		stmt2.setString(1, id);
		stmt2.executeUpdate();
		
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
<h1><%=title%>
	/
	<%=num%></h1>
<p><%=contnet%></p>
<p><%=hit%></p>
<p><%=id2%></p>
<button type="button" onclick="location='update.jsp?id=<%=id%>'">수정</button>
<button type="button" onclick="del()">삭제</button>
<%
	}

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>
<script>
	function del() {
		var isOK = confirm("삭제할래?");
		if(isOK){
			location = 'delete_proc.jsp?id=<%=id%>';
		}
	}
</script>