package model;

import java.sql.*;
import java.util.*;

public class CourseDAO {
	
	// 점수수정
	public void update(GradeVO vo) {
		try {
			String sql = "update enrollments set grade=?"
					+ " where scode=? and lcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, vo.getGrade());
			ps.setString(2, vo.getScode());
			ps.setString(3, vo.getLcode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("성적 수정 오류: " + e.toString());
		}
	}
	
	// 성적목록
	public ArrayList<GradeVO> list(String lcode){
		ArrayList<GradeVO> array = new ArrayList<GradeVO>();
		try {
			String sql = "select * from view_enroll_stu where lcode=?  order by scode";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				GradeVO vo = new GradeVO();
				vo.setLcode(rs.getString("lcode"));
				vo.setScode(rs.getString("scode"));
				vo.setEdate(rs.getString("edate"));
				vo.setGrade(rs.getInt("grade"));
				vo.setSname(rs.getString("sname"));
				vo.setDept(rs.getString("dept"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("성적목록 오류: " + e.toString());
		}
		return array;
	}
	// 전체 강좌목록
	public List<CourseVO> all(){
		List<CourseVO> array = new ArrayList<CourseVO>();
		try {
			String sql = "select * from view_cou order by lname";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
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
			System.out.println("전체 강좌 목록 오류: " + e.toString());
		}
		return array;
	}
	
	// 강좌 수정
	public void update(CourseVO vo) {
		try {
			String sql = "update courses set lname=?, hours=?,"
					+ " room=?, instructor=?, capacity=?, persons=? "
					+ " where lcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getLname());
			ps.setInt(2, vo.getHours());
			ps.setString(3, vo.getRoom());
			ps.setString(4, vo.getInstructor());
			ps.setInt(5, vo.getCapacity());
			ps.setInt(6, vo.getPersons());
			ps.setString(7, vo.getLcode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("강좌 수정 오류: " + e.toString());
		}
	}

	// 강좌 조회
	public CourseVO read(String lcode) {
		CourseVO vo = new CourseVO();
		try {
			String sql = "select * from courses where lcode = ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				vo.setLcode(lcode);
				vo.setLname(rs.getString("lname"));
				vo.setHours(rs.getInt("hours"));
				vo.setRoom(rs.getString("room"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getInt("persons"));
			}
		} catch (Exception e) {
			System.out.println("강좌 조회 오류: " + e.toString());
		}
		return vo;
	}
	
	// 새로운 코드
	public String getCode() {
		String code= "";
		try {
			String mcode="";
			String sql = "select max(lcode) ncode from courses";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				mcode = rs.getString("ncode");
				code = "N" +(Integer.parseInt(mcode.substring(1)) + 1);
			}
		}catch (Exception e) {
			System.out.println("새로운 코드 오류:" + e.toString());
		}
		return code;
	}
	// 강좌 등록
	public void insert(CourseVO vo) {
		try {
			String code = getCode();
			String sql = "insert into courses(lcode, lname, hours, room, instructor, capacity, persons)"
					+ " values(?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ps.setString(2, vo.getLname());
			ps.setInt(3, vo.getHours());
			ps.setString(4, vo.getRoom());
			ps.setString(5, vo.getInstructor());
			ps.setInt(6, vo.getCapacity());
			ps.setInt(7, vo.getPersons());
			ps.execute();
		} catch (Exception e) {
			System.out.println("강좌 등록 오류: " + e.toString());
		}
	}

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
