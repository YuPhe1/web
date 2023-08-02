package model;

import java.sql.*;
import java.util.*;

public class CourseDAO {

	// 검색수
	public int total(String query, String key) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from view_cou"
					+ " where " + key + " like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query +"%");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("강좌 검색수 오류: " + e.toString());
		}
		return total;
	}
	
	// 강좌목록
	public List<CourseVO> list(int page, String query, String key){
		List<CourseVO> array = new ArrayList<CourseVO>();
		try {
			String sql = "select * from view_cou"
					+ " where " + key + " like ?"
					+ " limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query +"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				CourseVO vo = new CourseVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
				vo.setPname(rs.getString("pname"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("강좌 목록 오류: " + e.toString());
		}
		return array;
	}
}
