package model;

//import java.util.*;
import java.sql.*;

public class LocalDAO {

	// 로컬 정보 저장
	public void insert(LocalVO vo) {
		try {
			String sql = "select * from local where lid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getLid());
			ResultSet rs = ps.executeQuery();
			if(!rs.next()) {
				sql = "insert into local(lid, lname, laddress, lphone, lurl, x, y)"
						+ " values(?, ?, ?, ?, ?, ? ,?)";
				ps = Database.CON.prepareStatement(sql);
				ps.setString(1, vo.getLid());
				ps.setString(2, vo.getLname());
				ps.setString(3, vo.getLaddress());
				ps.setString(4, vo.getLphone());
				ps.setString(5, vo.getLurl());
				ps.setString(6, vo.getX());
				ps.setString(7, vo.getY());
				ps.execute();
			}
		} catch (Exception e) {
			System.out.println("로컬 정보 저장 오류: " + e.toString());
		}
	}
}
