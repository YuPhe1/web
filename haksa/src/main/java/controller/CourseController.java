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

@WebServlet(value={"/cou/list", "/cou/list.json", "/cou/total",
		"/cou/insert", "/cou/update", "/cou/all.json",
		"/cou/grade", "/cou/grade.json", "/grade/update"})
public class CourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	CourseDAO courseDAO = new CourseDAO();
	ProfessorDAO professorDAO = new ProfessorDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("parray", professorDAO.all());
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		case "/cou/list.json":
			int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query") == null ? "" : request.getParameter("query");
			String key = request.getParameter("key");
			Gson gson = new Gson();
			out.print(gson.toJson(courseDAO.list(page, query, key)));
			break;
		case "/cou/total":
			query = request.getParameter("query") == null ? "" : request.getParameter("query");
			key = request.getParameter("key");
			out.print(courseDAO.total(query, key));
			break;
		case "/cou/update":
			String lcode = request.getParameter("lcode");
			request.setAttribute("vo", courseDAO.read(lcode));
			request.setAttribute("parray", professorDAO.all());
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
			break;
		case "/cou/all.json":
			List<CourseVO> carray = courseDAO.all();
			JSONArray jArray = new JSONArray();
			for(CourseVO vo : carray) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", vo.getLcode());
				obj.put("lname", vo.getLname());
				obj.put("room", vo.getRoom());
				obj.put("hours", vo.getHours());
				obj.put("instructor", vo.getPname());
				obj.put("persons", vo.getPersons());
				obj.put("capacity", vo.getCapacity());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/cou/grade":
			lcode = request.getParameter("lcode");
			request.setAttribute("vo", courseDAO.read(lcode));
			request.setAttribute("pageName", "/cou/grade.jsp");
			dis.forward(request, response);
			break;
		case "/cou/grade.json":
			lcode = request.getParameter("lcode");
			ArrayList<GradeVO> gArray = courseDAO.list(lcode);
			jArray = new JSONArray();
			for(GradeVO vo : gArray) {
				JSONObject obj = new JSONObject();
				obj.put("lcode", vo.getLcode());
				obj.put("scode", vo.getScode());
				obj.put("edate", vo.getEdate().substring(0,10));
				obj.put("grade", vo.getGrade());
				obj.put("sname", vo.getSname());
				obj.put("dept", vo.getDept());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		switch (request.getServletPath()) {
		case "/cou/insert":
			CourseVO vo = new CourseVO();
			vo.setLname(request.getParameter("lname"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setRoom(request.getParameter("room"));
			vo.setInstructor(request.getParameter("instructor"));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			//System.out.println(vo.toString());
			courseDAO.insert(vo);
			response.sendRedirect("/cou/list");
			break;
		case "/cou/update":
			vo = new CourseVO();
			vo.setLcode(request.getParameter("lcode"));
			vo.setLname(request.getParameter("lname"));
			vo.setHours(Integer.parseInt(request.getParameter("hours")));
			vo.setRoom(request.getParameter("room"));
			vo.setInstructor(request.getParameter("instructor"));
			vo.setCapacity(Integer.parseInt(request.getParameter("capacity")));
			vo.setPersons(Integer.parseInt(request.getParameter("persons")));
			// System.out.println(vo.toString());
			courseDAO.update(vo);
			response.sendRedirect("/cou/list");
			break;
		case "/grade/update":
			GradeVO gvo = new GradeVO();
			gvo.setLcode(request.getParameter("lcode"));
			gvo.setScode(request.getParameter("scode"));
			gvo.setGrade(Integer.parseInt(request.getParameter("grade")));
			courseDAO.update(gvo);
			break;
		}
		
	}

}
