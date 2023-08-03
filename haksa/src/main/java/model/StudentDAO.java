package model;

import java.util.*;
import java.sql.*;

public class StudentDAO {

	// 학생 정보 수정
	public void update(StudentVO vo) {
		try {
			String sql = "update students set sname=?, dept=?, year=?, "
					+ "birthday=?, advisor=? where scode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getSname());
			ps.setString(2, vo.getDept());
			ps.setInt(3, vo.getYear());
			ps.setString(4, vo.getBirthday());
			ps.setString(5, vo.getAdvisor());
			ps.setString(6, vo.getScode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("학생 정보 수정");
		}
	}
	
	// 학생 정보
	public StudentVO read(String scode) {
		StudentVO vo = new StudentVO();
		try {
			String sql = "select * from students where scode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, scode);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setScode(scode);
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				vo.setYear(rs.getInt("year"));
				vo.setBirthday(rs.getString("birthday"));
				vo.setAdvisor(rs.getString("advisor"));
			}
		} catch (Exception e) {
			System.out.println("학생 정보 오류: " + e.toString());
		}
		return vo;
	}
	
	// 학생 등록
	public void insert(StudentVO vo) {
		try {
			String sql = "select max(scode)+1 ncode from students";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			String ncode = "";
			if(rs.next()) {
				ncode = rs.getString("ncode");
			}
			sql = "insert into students(scode, sname, dept, year, birthday, advisor)"
					+ " values(?, ?, ?, ?, ?, ?)";
			ps = Database.CON.prepareStatement(sql);
			ps.setString(1, ncode);
			ps.setString(2, vo.getSname());
			ps.setString(3, vo.getDept());
			ps.setInt(4, vo.getYear());
			ps.setString(5, vo.getBirthday());
			ps.setString(6, vo.getAdvisor());
			ps.execute();
		} catch (Exception e) {
			System.out.println("학생 등록 오류: " + e.toString());
		}
	}
	
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
				vo.setBirthday(rs.getString("birthday"));
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
