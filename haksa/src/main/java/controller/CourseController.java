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

@WebServlet(value={"/cou/list", "/cou/list.json", "/cou/total"})
public class CourseController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	CourseDAO dao = new CourseDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/cou/list":
			request.setAttribute("pageName", "/cou/list.jsp");
			dis.forward(request, response);
			break;
		case "/cou/list.json":
			int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query") == null ? "" : request.getParameter("query");
			String key = request.getParameter("key");
			Gson gson = new Gson();
			out.print(gson.toJson(dao.list(page, query, key)));
			break;
		case "/cou/total":
			query = request.getParameter("query") == null ? "" : request.getParameter("query");
			key = request.getParameter("key");
			out.print(dao.total(query, key));
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
