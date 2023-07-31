package model;

import java.util.*;
import java.sql.*;

public class ProductDAO {

	// 상품 개수
	public int total(String query) {
		int cnt = 0;
		
		try {
			String sql = "select count(*) c from products where pname like ? ";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" +  query + "%");
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("c");
			}
		} catch (Exception e) {
			System.out.println("상품수:" + e.toString());
		}
		
		return cnt;
	}
	
	// 상품목록
	public ArrayList<ProductVO> list(int page, String query){
		ArrayList<ProductVO> array = new ArrayList<ProductVO>();
		
		try {
			String sql = "select * from products where pname like ? order by pcode desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, "%" +  query + "%");
			ps.setInt(2, (page-1)*5);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				ProductVO vo = new ProductVO();
				vo.setPcode(rs.getInt("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setPrice(rs.getInt("price"));
				vo.setRdate(rs.getTimestamp("rdate"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("상품목록오류: " + e.toString());
		}
		
		return array;
	}
}
