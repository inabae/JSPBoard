package DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class 게시물등록 {
	public static void main(String[] args) {
		for (int i = 0; i < 100; i++) {

			String title = "title" + i;
			String contnet = "contnet" + i;
			String id = "qq";

			try {
				DBManager db = DBManager.getInstance();
				Connection con = db.open();
				String sql = "insert into article values (null, ?, ?, 0, ?)";
				PreparedStatement stmt = con.prepareStatement(sql);
				stmt.setString(1, title);
				stmt.setString(2, contnet);
				stmt.setString(3, id);
				int result = stmt.executeUpdate();
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
}