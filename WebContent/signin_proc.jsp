
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.DBManager"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
			out.println("�α��εǾ����ϴ�.");
		} else {
			out.println("�ٽ� �α������ּ���.");
		}
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>