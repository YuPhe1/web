package model;

import java.util.ArrayList;

public class DAOTest {

	public static void main(String[] args) {
		
		ProductDAO dao = new ProductDAO();
		
		System.out.println("검색수: " + dao.total(""));
		
//		ArrayList<ProductVO> array = dao.list(1, "전자");
		
//		for(ProductVO vo : array) {
//			System.out.println(vo.toString());
//		}

	}

}
