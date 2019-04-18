<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.DBManager"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open();
		String sql = "select id from member where id=? and pw=?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		boolean isOk = false;
		if (rs.next()) {
			isOk = true;
		}
		if (isOk) {
			out.println("로그인되었습니다.");
			session.setAttribute("id", id); //게시글쓸떄 그사람이 맞는지 확인을 하기위해 그 id를 뽑을 수 있도록 생성.
		} else {
			out.println("다시 로그인해주세요.");
		}
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>