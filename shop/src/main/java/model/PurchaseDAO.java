package model;

import java.sql.*;
import java.util.*;
import java.text.*;

public class PurchaseDAO {

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


	// 특정 유저의 구매목록
	public ArrayList<PurchaseVO> user(String uid){
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "select * from purchase where uid=? order by purDate desc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, uid);
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
				array.add(vo);
			}
		}catch (Exception e) {
			System.out.println("특정 유저의 구매목록: " + e.toString());
		}
		return array;
	}
	// 주문 상태 변경
	public void update(String pid, int status) {
		try {
			String sql = "update purchase set status=? where pid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, status);
			ps.setString(2, pid);
			ps.execute();
		} catch (Exception e) {
			System.out.println("주문상태 변경 오류: " + e.toString());
		}
	}

	// 구매한 상품 목록
	public ArrayList<OrderVO> list(String pid){
		ArrayList<OrderVO> array = new ArrayList<OrderVO>();
		try {
			String sql = "select * from view_orders where pid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, pid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				OrderVO vo = new OrderVO();
				vo.setOid(rs.getInt("oid"));
				vo.setPid(rs.getString("pid"));
				vo.setGid(rs.getString("gid"));
				vo.setPrice(rs.getInt("price"));
				vo.setQnt(rs.getInt("qnt"));
				vo.setTitle(rs.getString("title"));
				vo.setImage(rs.getString("image"));
				array.add(vo);
			}
		}catch (Exception e) {
			System.out.println("구매한 상품목록 오류: " + e.toString());
		}
		return array;
	}

	// 주문 정보
	public PurchaseVO read(String pid){
		PurchaseVO vo = new PurchaseVO();
		try {
			String sql = "select * from view_purchase where pid=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, pid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				vo.setPid(rs.getString("pid"));
				vo.setUid(rs.getString("uid"));
				vo.setRphone(rs.getString("rphone"));
				vo.setRaddress1(rs.getString("raddress1"));
				vo.setRaddress2(rs.getString("raddress2"));
				vo.setPurDate(sdf.format(rs.getTimestamp("purDate")));
				vo.setStatus(rs.getInt("status"));
				vo.setPurSum(rs.getInt("purSum"));
				vo.setUname(rs.getString("uname"));
			}
		}catch (Exception e) {
			System.out.println("주문정보 오류: " + e.toString());
		}
		return vo;
	}

	// 검색 수
	public int total(String key, String query, String query2) {
		int total = 0;
		try {
			String sql = "select count(*) cnt from view_purchase where " + key 
					+ " like ? and status like ?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setString(2, "%" + query2 + "%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		}catch (Exception e) {
			System.out.println("주문 검색 수 오류: " + e.toString());
		}
		return total;
	}

	// 주문목록
	public ArrayList<PurchaseVO> list(String key, String query, int page, String query2){
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "select * from view_purchase where " + key 
					+ " like ? and status like ? order by purDate desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" + query + "%");
			ps.setString(2, "%" + query2 + "%");
			ps.setInt(3, (page-1)*5);
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
