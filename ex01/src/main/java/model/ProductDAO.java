package model;

import java.sql.*;
import java.util.*;

public class ProductDAO {
	
	// 목록출력
	public List<ProductVO> list(){
		List<ProductVO> array = new ArrayList<ProductVO>();
		try {
			String sql = "select * from products order by pcode desc";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
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
			System.out.println("상품목록 오류: " + e.toString());
		}
		return array;
	}
}
