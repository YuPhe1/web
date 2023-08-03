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

@WebServlet(value={"/cou/list", "/cou/list.json", "/cou/total", "/cou/insert", "/cou/update"})
public class CourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	CourseDAO coursDAO = new CourseDAO();
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
			out.print(gson.toJson(coursDAO.list(page, query, key)));
			break;
		case "/cou/total":
			query = request.getParameter("query") == null ? "" : request.getParameter("query");
			key = request.getParameter("key");
			out.print(coursDAO.total(query, key));
			break;
		case "/cou/update":
			String lcode = request.getParameter("lcode");
			request.setAttribute("vo", coursDAO.read(lcode));
			request.setAttribute("parray", professorDAO.all());
			request.setAttribute("pageName", "/cou/update.jsp");
			dis.forward(request, response);
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
			coursDAO.insert(vo);
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
			coursDAO.update(vo);
			response.sendRedirect("/cou/list");
			break;
		}
		
	}

}
