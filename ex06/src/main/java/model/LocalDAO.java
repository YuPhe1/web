package model;

import java.util.*;
import java.sql.*;

public class LocalDAO {

	// 개수
	public int total(String query) {
		int cnt = 0;

		try {
			String sql = "select count(*) c from local where lname like ? or laddress like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setString(2, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("c");
			}
		} catch (Exception e) {
			System.out.println("지역수:" + e.toString());
		}

		return cnt;
	}

	// 목록
	public List<LocalVO> list(int page, String query){
		List<LocalVO> array = new ArrayList<LocalVO>();
		try {
			String sql = "select * from local where lname like ? or laddress like ? "
					+ "order by id desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setString(2, "%" + query + "%");
			ps.setInt(3, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				LocalVO vo = new LocalVO();
				vo.setId(rs.getInt("id"));
				vo.setLid(rs.getString("lid"));
				vo.setLname(rs.getString("lname"));
				vo.setLaddress(rs.getString("laddress"));
				vo.setLphone(rs.getString("lphone"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("로컬 정보 목록 오류: " + e.toString());
		}
		return array;
	}

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
