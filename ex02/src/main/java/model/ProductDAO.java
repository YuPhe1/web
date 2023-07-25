package model;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	
	// 전체상품수
	public int last() {
		int last = 0;
		try {
			String sql = "select count(*) c from products";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				last = (rs.getInt("c") + 4) / 5;
			}
		} catch (Exception e) {
			System.out.println("전체 상품 페이지 오류: " + e.toString());
		}
		return last;
	}
	//상품수정
	public void update(ProductVO vo) {
		try {
			String sql = "update products set pname=?, price=?, rdate=now() where pcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setInt(2, vo.getPrice());
			ps.setInt(3, vo.getPcode());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품수정 오류: " + e.toString());
		}
	}
	// 상품삭제
	public void delete(String code) {
		try {			
			String sql = "delete from products where pcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품삭제오류: " + e.toString());
		}
	}
	
	// 상품정보
	public ProductVO read(String code) {
		ProductVO vo = new ProductVO();
		try {
			String sql = "select * from products where pcode=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, code);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				vo.setPcode(rs.getInt("pcode"));
				vo.setPname(rs.getString("pname"));
				vo.setPrice(rs.getInt("price"));
				vo.setRdate(rs.getTimestamp("rdate"));
			}
		} catch (Exception e) {
			System.out.println("상품정보오류: " + e.toString());
		}
		return vo;
	}
	
	// 상품등록
	public void insert(ProductVO vo) {
		try {
			String sql = "insert into products(pname, price) values(?, ?)";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getPname());
			ps.setInt(2, vo.getPrice());
			ps.execute();
		} catch (Exception e) {
			System.out.println("상품등록 오류: " + e.toString());
		}
	}
	
	// 상품목록
	public List<ProductVO> list(int page){
		List<ProductVO> array = new ArrayList<ProductVO>();
		try {
			String sql = "select * from products order by pcode desc limit ?,5";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*5);
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
