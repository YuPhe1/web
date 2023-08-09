package model;

import java.sql.*;

public class UserDAO {

	public UserVO read(String uid) {
		UserVO vo = new UserVO();
		try {
			String sql = "select * from users where uid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhone(rs.getString("phone"));
				vo.setPhoto(rs.getString("photo"));
				vo.setRegDate(rs.getTimestamp("regDate"));
			}
		} catch (Exception e) {
			System.out.println("회원정보읽기:" + e.toString());
		}
		return vo;
	}
}
