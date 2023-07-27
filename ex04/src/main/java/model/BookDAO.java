package model;

import java.sql.*;
import java.util.*;

public class BookDAO {
	
	// 전체데이터 갯수
	public int total() {
		int total = 0;
		try {
			String sql = "select count(*) cnt from books";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("전체데이터 개수: " + e.toString());
		}
		return total;
	}
	// 도서목록
	public List<BookVO> list(int page){
		List<BookVO> array = new ArrayList<BookVO>();
		try {
			String sql = "select * from books order by seq desc limit ?, 3";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setInt(1, (page-1)*3);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				BookVO vo = new BookVO();
				vo.setSeq(rs.getInt("seq"));
				vo.setThumbnail(rs.getString("thumbnail"));
				vo.setTitle(rs.getString("title"));
				vo.setPrice(rs.getInt("price"));
				vo.setContents(rs.getString("contents"));
				vo.setPublisher(rs.getString("publisher"));
				vo.setIsbn(rs.getString("isbn"));
				vo.setUrl(rs.getString("url"));
				array.add(vo);
			}
		} catch (Exception e) {
			System.out.println("도서목록 오류: " + e.toString());
		}
		return array;
	}
	// 도서등록
	public void insert(BookVO vo) {
		try {
			String sql = "select * from books where isbn=?";
			PreparedStatement ps = Database.CON.prepareStatement(sql);
			ps.setString(1, vo.getIsbn());
			ResultSet rs = ps.executeQuery();
			if(!rs.next()) {
				sql = "insert into books(title, thumbnail, price, authors, url, isbn, contents, publisher) "
						+ "values(?, ?, ?, ?, ?, ?, ?, ?)";
				ps = Database.CON.prepareStatement(sql);
				ps.setString(1, vo.getTitle());
				ps.setString(2, vo.getThumbnail());
				ps.setInt(3, vo.getPrice());
				ps.setString(4, vo.getAuthors());
				ps.setString(5, vo.getUrl());
				ps.setString(6, vo.getIsbn());
				ps.setString(7, vo.getContents());
				ps.setString(8, vo.getPublisher());
				ps.execute();
			}
		} catch (Exception e) {
			System.out.println("도서 등록 오류: " + e.toString());
		}
	}
}
