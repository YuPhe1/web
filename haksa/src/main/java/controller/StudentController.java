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

import model.*;
import java.util.*;

@WebServlet(value={"/stu/list", "/stu/list.json", "/stu/total"})
public class StudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	StudentDAO dao = new StudentDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("pageName", "/stu/list.jsp");
			dis.forward(request, response);
			break;
		case "/stu/list.json":
			int page = Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query") == null ? "" : request.getParameter("query");
			String key = request.getParameter("key");
			List<StudentVO> array = dao.list(page, query, key);
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
			int total = dao.total(query, key);
			out.print(total);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
