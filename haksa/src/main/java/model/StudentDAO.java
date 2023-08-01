package model;

import java.util.*;
import java.sql.*;

public class StudentDAO {

	// 학생 수
	public int total(String query, String key) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from view_stu"
					+ " where " + key + " like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query +"%");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("학생 수 오류: " + e.toString());
		}
		return total;
	}
	
	// 학생 목록
	public List<StudentVO> list(int page, String query, String key){
		List<StudentVO> array = new ArrayList<StudentVO>();
		
		try {
			String sql = "select * from view_stu"
					+ " where " + key + " like ?"
					+ " limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query +"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				StudentVO vo = new StudentVO();
				vo.setScode(rs.getString("scode"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getInt("year"));
				vo.setBirthday(rs.getDate("birthday"));
				vo.setAdvisor(rs.getString("advisor"));
				vo.setPname(rs.getString("pname"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("학생 목록 오류: " + e.toString());
		}
		
		return array;
	}
}
