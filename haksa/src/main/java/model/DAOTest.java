package model;

import java.util.*;

public class DAOTest {

	public static void main(String[] args) {
		
//		ProfessorDAO dao = new ProfessorDAO();

//		System.out.println(dao.read("221").toString());
		
//		ProfessorVO vo = new ProfessorVO();
//		vo.setPname("이몽룡");
//		vo.setDept("전자");
//		vo.setTitle("정교수");
//		vo.setHiredate("2023.08.02");
//		dao.insert(vo);
//		System.out.println("입력완료");
		
//		System.out.println("검색수: "+dao.total("전자"));
//		List<ProfessorVO> array = dao.list(1, "이");
//		for(ProfessorVO vo : array) {
//			System.out.println(vo.toString());
//		}

		
		StudentDAO dao = new StudentDAO();
		
		for(EnrollVO vo : dao.list("92514023")) {
			System.out.println(vo.toString());
		}
//		
//		for(StudentVO vo : dao.list(1, "4", "year")) {
//			System.out.println(vo.toString());
//		}
//		
//		System.out.println(dao.total("4", "year"));
		
//		CourseDAO dao = new CourseDAO();
//		System.out.println(dao.getCode());
//		for(CourseVO vo : dao.list(1, "이병렬", "pname")) {
//			System.out.println(vo.toString());
//		}
//		
//		System.out.println(dao.total("이병렬", "pname"));
		
	}

}
