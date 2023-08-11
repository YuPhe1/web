package model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class ReviewDAO {

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// 리뷰 목록
	public ArrayList<ReviewVO> list(String gid){
		ArrayList<ReviewVO> array = new ArrayList<ReviewVO>();
		try {
			String sql = "select * from view_reviews where gid=? "
					+ "order by rid desc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, gid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ReviewVO vo = new ReviewVO();
				vo.setRid(rs.getInt("rid"));
				vo.setGid(rs.getString("gid"));
				vo.setUid(rs.getString("uid"));
				vo.setContent(rs.getString("content"));
				vo.setRevDate(sdf.format(rs.getTimestamp("revDate")));
				vo.setPhoto(rs.getString("photo"));
				vo.setUname(rs.getString("uname"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("리뷰 목록 오류: " + e.toString());
		}
		return array;
	}
	
	// 리뷰 등록
	public void insert(ReviewVO vo) {
		try {
			String sql = "insert into reviews (uid, gid, content)"
					+ " values(?, ?, ?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getUid());
			ps.setString(2, vo.getGid());
			ps.setString(3, vo.getContent());
			ps.execute();
		} catch (Exception e) {
			System.out.println("리뷰등록 오류: " + e.toString());
		}
	}
}
