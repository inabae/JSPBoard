<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.DBManager"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8"); //위의 utf-8과 맞춰서 이렇게 쓰면 한글 안깨짐
	String title = request.getParameter("title");
	String contnet = request.getParameter("contnet");
	//signin_proc에서 뽑은 id를 가져오기
	String id = (String)session.getAttribute("id");

	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		String sql = "insert into article values (null, ?, ?, 0, ?)";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, title);
		stmt.setString(2, contnet);
		stmt.setString(3, id);
		int result = stmt.executeUpdate(); // 성공이면 1이상의  값, 실패하면 0값
		if (result > 0) {
			out.println("작성완료");
		} else {
			out.println("작성실패");
		}
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>