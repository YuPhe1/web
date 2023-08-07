package model;

import java.util.*;
import java.sql.*;

public class GoodsDAO {

	// 상품등록
	public void insert(GoodsVO vo) {
		try {
			String sql = "insert into goods(gid, title, price, maker, image) "
					+ "values(?, ?, ?, ?, ?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getGid());
			ps.setString(2, vo.getTitle());
			ps.setInt(3, vo.getPrice());
			ps.setString(4, vo.getMaker());
			ps.setString(5, vo.getImage());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품등록 오류: " + e.toString());
		}
	}
}
