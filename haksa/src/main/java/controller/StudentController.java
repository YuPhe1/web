package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;

import model.*;
import java.util.*;

@WebServlet(value={"/stu/list", "/stu/list.json", "/stu/total",
		"/stu/insert", "/stu/update", "/stu/enroll",
		"/stu/enroll.json", "/enroll/insert", "/stu/cou.json",
		"/enroll/delete"})
public class StudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	StudentDAO studentDAO = new StudentDAO();
	ProfessorDAO professorDAO = new ProfessorDAO();
//	CourseDAO courseDAO = new CourseDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("parray", professorDAO.all());
			request.setAttribute("pageName", "/stu/list.jsp");
			dis.forward(request, response);
			break;
		case "/stu/list.json":
			int page = Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query") == null ? "" : request.getParameter("query");
			String key = request.getParameter("key");
			List<StudentVO> array = studentDAO.list(page, query, key);
			JSONArray jArray = new JSONArray();
			for(StudentVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("scode", vo.getScode());
				obj.put("sname", vo.getSname());
				obj.put("dept", vo.getDept());
				obj.put("year", vo.getYear());
				obj.put("birthday", vo.getBirthday().toString());
				obj.put("advisor", vo.getAdvisor());
				obj.put("pname", vo.getPname());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/stu/total":
			query = request.getParameter("query") == null ? "" : request.getParameter("query");
			key = request.getParameter("key");
			int total = studentDAO.total(query, key);
			out.print(total);
			break;
		case "/stu/update":
			String scode = request.getParameter("scode");
			request.setAttribute("vo", studentDAO.read(scode));
			request.setAttribute("parray", professorDAO.all());
			request.setAttribute("pageName", "/stu/update.jsp");
			dis.forward(request, response);
			break;
		case "/stu/enroll":
			scode = request.getParameter("scode");
			request.setAttribute("vo", studentDAO.read(scode));
//			request.setAttribute("carray", courseDAO.all());
			request.setAttribute("pageName", "/stu/enroll.jsp");
			dis.forward(request, response);
			break;
		case "/stu/enroll.json":
			ArrayList<EnrollVO> earray = studentDAO.list(request.getParameter("scode"));
			jArray = new JSONArray();
			for(EnrollVO vo : earray) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", vo.getLcode());
				obj.put("scode", vo.getScode());
				obj.put("edate", vo.getEdate().substring(0,10));
				obj.put("grade", vo.getGrade());
				obj.put("lname", vo.getLname());
				obj.put("room", vo.getRoom());
				obj.put("hours", vo.getHours());
				obj.put("pname", vo.getPname());
				obj.put("persons", vo.getPersons());
				obj.put("capacity", vo.getCapacity());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/enroll/insert":
			String lcode = request.getParameter("lcode");
			scode = request.getParameter("scode");
			out.print(studentDAO.insert(scode, lcode));
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch (request.getServletPath()) {
		case "/stu/insert":
			StudentVO vo = new StudentVO();
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			studentDAO.insert(vo);
			response.sendRedirect("/stu/list");
			break;
		case "/stu/update":
			vo = new StudentVO();
			vo.setScode(request.getParameter("scode"));
			vo.setSname(request.getParameter("sname"));
			vo.setDept(request.getParameter("dept"));
			vo.setBirthday(request.getParameter("birthday"));
			vo.setYear(Integer.parseInt(request.getParameter("year")));
			vo.setAdvisor(request.getParameter("advisor"));
			studentDAO.update(vo);
			response.sendRedirect("/stu/list");
			break;
		case "/enroll/delete":
			String scode = request.getParameter("scode");
			String lcode = request.getParameter("lcode");
			studentDAO.delete(scode, lcode);
			break;
		}
	}

}
