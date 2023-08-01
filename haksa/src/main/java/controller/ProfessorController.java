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
import java.text.*;

@WebServlet(value={"/pro/list", "/pro/list.json", "/pro/total"})
public class ProfessorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	ProfessorDAO dao = new ProfessorDAO();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("#,###원");
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch(request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			int page = Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query") == null ? "" : request.getParameter("query");
			String key = request.getParameter("key");
			List<ProfessorVO> array = dao.list(page, query, key);
			JSONArray jArray = new JSONArray();
			for(ProfessorVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("pcode", vo.getPcode());
				obj.put("pname", vo.getPname());
				obj.put("dept", vo.getDept());
				obj.put("title", vo.getTitle());
				obj.put("hiredate", sdf.format(vo.getHiredate()));
				obj.put("salary", vo.getSalary());
				obj.put("fsalary", df.format(vo.getSalary()));
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/pro/total":
			query = request.getParameter("query") == null ? "" : request.getParameter("query");
			key = request.getParameter("key");
			int total = dao.total(query, key);
			out.print(total);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
