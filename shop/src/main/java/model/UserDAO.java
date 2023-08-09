package model;

import java.sql.*;
import java.util.*;

public class UserDAO {

	public int total(String key, String query) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from users where " + key + " like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query+"%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("회원목록오류:" + e.toString());
		}
		return total;
	}
	
	// 회원목록
	public ArrayList<UserVO> list(String key, String query, int page){
		ArrayList<UserVO> array = new ArrayList<UserVO>();
		try {
			String sql = "select * from users where " + key + " like ? "
					+ "order by regDate desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%"+ query+"%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				UserVO vo = new UserVO();
				vo.setUid(rs.getString("uid"));
				vo.setUpass(rs.getString("upass"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress1(rs.getString("address1"));
				vo.setAddress2(rs.getString("address2"));
				vo.setPhone(rs.getString("phone"));
				vo.setPhoto(rs.getString("photo"));
				vo.setRegDate(rs.getTimestamp("regDate"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("회원목록오류:" + e.toString());
		}
		return array;
	}
	// 회원수정
	public void update(UserVO vo) {
		System.out.println("update");
		try {
			String sql = "update users set uname=?, phone=?,"
					+ " photo=?, address1=?, address2=? where uid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getUname());
			ps.setString(2, vo.getPhone());
			ps.setString(3, vo.getPhoto());
			ps.setString(4, vo.getAddress1());
			ps.setString(5, vo.getAddress2());
			ps.setString(6, vo.getUid());
			ps.execute();
		} catch (Exception e) {
			System.out.println("회원수정 오류: " + e.toString());
		}
	}

	// 회원가입
	public void insert(UserVO vo) {
		try {
			String sql = "insert into users(uid, upass, uname, phone, photo, address1, address2) "
					+ "values(?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getUpass());
			ps.setString(3, vo.getUname());
			ps.setString(4, vo.getPhone());
			ps.setString(5, vo.getPhoto());
			ps.setString(6, vo.getAddress1());
			ps.setString(7, vo.getAddress2());
			ps.execute();
		} catch (Exception e) {
			System.out.println("회원가입 오류: " + e.toString());
		}
	}

	// 회원정보
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
