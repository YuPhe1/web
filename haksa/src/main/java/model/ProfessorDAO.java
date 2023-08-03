package model;

import java.util.*;
import java.sql.*;
import java.text.*;

public class ProfessorDAO {

	public void update(ProfessorVO vo) {
		try {
			String sql = "update professors set pname=?,dept=?,title=?,salary=?,hiredate=?"
					+ " where pcode=?";
			PreparedStatement ps =  Database.CON.prepareStatement(sql);
			ps.setString(6, vo.getPcode());
			ps.setString(1, vo.getPname());
			ps.setString(2, vo.getDept());
			ps.setString(3, vo.getTitle());
			ps.setInt(4, vo.getSalary());
			ps.setString(5, vo.getHiredate());
			ps.execute();
		} catch (Exception e) {
			System.out.println("교수 수정: " + e.toString());
		}
	}

	public ProfessorVO read(String pcode) {
		ProfessorVO vo = new ProfessorVO();
		try {
			String sql = "select * from professors"
					+ " where pcode like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, pcode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
			}
		} catch (Exception e) {
			System.out.println("교수 정보 오류: " + e.toString());
		}
		return vo;
	}

	// 교수등록
	public void insert(ProfessorVO vo) {
		try {
			int ncode = 0;
			String sql = "select max(pcode)+1 ncode from professors";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				ncode = rs.getInt("ncode");
			}
			sql = "insert into professors(pcode, pname, dept, title, salary, hiredate)"
					+ " values(?, ?, ?, ?, ?, ?)";
			ps =  Database.CON.prepareStatement(sql);
			ps.setInt(1, ncode);
			ps.setString(2, vo.getPname());
			ps.setString(3, vo.getDept());
			ps.setString(4, vo.getTitle());
			ps.setInt(5, vo.getSalary());
			ps.setString(6, vo.getHiredate());
			ps.execute();
		} catch (Exception e) {
			System.out.println("교수 등록: " + e.toString());
		}
	}

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
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("교수 목록 오류: " + e.toString());
		}
		return array;
	}

	// 모든교수목록
	public List<ProfessorVO> all(){
		List<ProfessorVO> array = new ArrayList<ProfessorVO>();
		try {
			String sql = "select * from professors order by pname";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProfessorVO vo = new ProfessorVO();
				vo.setPcode(rs.getString("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				vo.setHiredate(rs.getString("hiredate"));
				vo.setTitle(rs.getString("title"));
				vo.setSalary(rs.getInt("salary"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("모든 교수 목록 오류: " + e.toString());
		}
		return array;
	}
}
