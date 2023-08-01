package model;

import java.util.*;

public class DAOTest {

	public static void main(String[] args) {
		
//		ProfessorDAO dao = new ProfessorDAO();
		
//		System.out.println("검색수: "+dao.total("전자"));
//		List<ProfessorVO> array = dao.list(1, "이");
//		for(ProfessorVO vo : array) {
//			System.out.println(vo.toString());
//		}

		
		StudentDAO dao = new StudentDAO();
		
		for(StudentVO vo : dao.list(1, "4", "year")) {
			System.out.println(vo.toString());
		}
		
		System.out.println(dao.total("4", "year"));
	}

}
