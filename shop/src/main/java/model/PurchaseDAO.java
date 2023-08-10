package model;

import java.sql.*;
import java.util.*;
import java.text.*;

public class PurchaseDAO {

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	public int total(String key, String query) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from view_purchase where " + key 
					+ " like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		}catch (Exception e) {
			System.out.println("주문목록 오류: " + e.toString());
		}
		return total;
	}
	
	// 주문목록
	public ArrayList<PurchaseVO> list(String key, String query, int page){
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "select * from view_purchase where " + key 
					+ " like ? order by purDate desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PurchaseVO vo = new PurchaseVO();
				vo.setPid(rs.getString("pid"));
				vo.setUid(rs.getString("uid"));
				vo.setRphone(rs.getString("rphone"));
				vo.setRaddress1(rs.getString("raddress1"));
				vo.setRaddress2(rs.getString("raddress2"));
				vo.setPurDate(sdf.format(rs.getTimestamp("purDate")));
				vo.setStatus(rs.getInt("status"));
				vo.setPurSum(rs.getInt("purSum"));
				vo.setUname(rs.getString("uname"));
				array.add(vo);
			}
		}catch (Exception e) {
			System.out.println("주문목록 오류: " + e.toString());
		}
		return array;
	}
	
	// 주문상품등록
	public void insert(OrderVO vo) {
		try {
			String sql = "insert into orders(pid, gid, price, qnt)"
					+ " values(?, ?, ?, ?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPid());
			ps.setString(2, vo.getGid());
			ps.setInt(3, vo.getPrice());
			ps.setInt(4, vo.getQnt());
			ps.execute();
		} catch (Exception e) {
			System.out.println("주문상품등록 오류: " + e.toString());
		}
	}
	
	// 주문등록오류
	public void insert(PurchaseVO vo) {
		try {
			String sql = "insert into purchase(pid, uid, raddress1, raddress2"
					+ ", rphone, purSum) values(?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPid());
			ps.setString(2, vo.getUid());
			ps.setString(3, vo.getRaddress1());
			ps.setString(4, vo.getRaddress2());
			ps.setString(5, vo.getRphone());
			ps.setInt(6, vo.getPurSum());
			ps.execute();
		} catch (Exception e) {
			System.out.println("주문등록 오류: " + e.toString());
		}
	}
}
