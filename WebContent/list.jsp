<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.DBManager"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!-- 화면을 부드럽게 만들어 주는 효과 -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<%
	String pageStr = request.getParameter("page");
	int pageNum = 0;
	try {
		pageNum = Integer.parseInt(pageStr);
	} catch (NumberFormatException e) {
		pageNum = 1;
	}
	int startRow = 0;
	int endRow = 0;
	endRow = pageNum * 10;
	startRow = endRow - 9;
	int total = 0;
	try {
		DBManager db = DBManager.getInstance();
		Connection con = db.open(); //  asc

		String sql2 = "select count(*) from article";
		PreparedStatement stmt2 = con.prepareStatement(sql2);
		ResultSet rs2 = stmt2.executeQuery();
		if (rs2.next()) {
			total = rs2.getInt("count(*)");
		}

		String sql = "select * from article order by id desc" + "    limit ?, 10";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, startRow - 1);
		ResultSet rs = stmt.executeQuery();

		// 		<div class="card" style="width:400px">
		// 		  <img class="card-img-top" src="img_avatar1.png" alt="Card image">
		// 		  <div class="card-body">
		// 		    <h4 class="card-title">John Doe</h4>
		// 		    <p class="card-text">Some example text.</p>
		// 		    <a href="#" class="btn btn-primary">See Profile</a>
		// 		  </div>
		// 		</div>
		while (rs.next()) {
			String id = rs.getString("id");
			String title = rs.getString("title");
			String contnet = rs.getString("contnet");
			String hit = rs.getString("hit");
			String id2 = rs.getString("id2");
			// 절대 경로  http://localhost/JspBoard/view.jsp?id=1
			// 상대 경로  view.jsp?id=1
			//out.println("<a href='view.jsp?id=" + id + "'>" + id + "/" + title + "/" + id2 + "</a><br>");
%>
<div class="card" style="width: 400px">
	<div class="card-body">
		<h4 class="card-title"><%=title %></h4>
		<p class="card-text"><%=contnet %></p>
		<a href="view.jsp?id=<%=id %>" class="btn btn-primary"><%=id %></a>
	</div>
</div>
<%
	}

		int startPage = 0;
		startPage = (pageNum - 1) / 10 * 10 + 1;

		int endPage = 0;
		endPage = startPage + 9;

		int totalPage = 0; // 전체 페이지 수 4
		if (total % 10 == 0) { // 10 20 30 40
			totalPage = total / 10;
		} else {
			totalPage = total / 10 + 1;
		}
		if (endPage > totalPage)
			endPage = totalPage;

		// 		<ul class="pagination">
		// 		  <li class="page-item"><a class="page-link" href="#">Previous</a></li>
		// 		  <li class="page-item"><a class="page-link" href="#">1</a></li>
		// 		  <li class="page-item active"><a class="page-link" href="#">2</a></li>
		// 		  <li class="page-item"><a class="page-link" href="#">3</a></li>
		// 		  <li class="page-item"><a class="page-link" href="#">Next</a></li>
		// 		</ul>
		out.println("<ul class=\"pagination\">");

		//게시글 목록 숫자 보이는 코드
		for (int i = startPage; i <= endPage; i++) {
%>
<li class="page-item"><a class="page-link"
	href="list.jsp?page=<%=i%>"><%=i%></a></li>

<!-- 글씨(숫자)를 누를 수 있게 만듬.  -->
<!-- out.println("<a href=list.jsp?page=" + i + ">" + i + "</a>"); -->
<%
	}
		out.println("</ul>");

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>