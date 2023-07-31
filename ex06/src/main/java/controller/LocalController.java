package controller;

import java.io.IOException;
import java.io.PrintWriter;

import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.*;


@WebServlet(value={"/local/list", "/local/list.json", "/local/total"})
public class LocalController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	LocalDAO dao = new LocalDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch (request.getServletPath()) {
		case "/local/list": 
			request.setAttribute("pageName", "/local/list.jsp");
			dis.forward(request, response);
			break;
		case "/local/list.json":
			int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query") == null ? "" : request.getParameter("query");
			List<LocalVO> array = dao.list(page, query);
			JSONArray jArray = new JSONArray();
			for(LocalVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("id", vo.getId());
				obj.put("lid", vo.getLid());
				obj.put("lname", vo.getLname());
				obj.put("laddress", vo.getLaddress());
				obj.put("lphone", vo.getLphone());
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/local/total":
			String query1 = request.getParameter("query") == null ? "" : request.getParameter("query");
			out.print(dao.total(query1));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
