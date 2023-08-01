package model;

import java.util.*;
import java.sql.*;

public class ProfessorDAO {

	public int total(String query, String key) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from professors"
					+ " where "+ key +" like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query +"%");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				total = rs.getInt("cnt"); 
			}
		} catch (Exception e) {
			System.out.println("교수 수 오류: " + e.toString());
		}
		return total;
	}
	
	// 교수목록
	public List<ProfessorVO> list(int page, String query, String key){
		List<ProfessorVO> array = new ArrayList<ProfessorVO>();
		try {
			String sql = "select * from professors"
					+ " where " + key + " like ?"
					+ " limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query +"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProfessorVO vo = new ProfessorVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getDate("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("교수 목록 오류: " + e.toString());
		}
		return array;
	}
}
