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

@WebServlet(value={"/pro/list","/pro/list.json", "/pro/total"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df = new DecimalFormat("#,###원");
	ProductDAO dao = new ProductDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		switch (request.getServletPath()) {
		case "/pro/list": 
			request.setAttribute("pageName", "/pro/list.jsp");
			dis.forward(request, response);
			break;
		case "/pro/list.json":
			int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
			String query = request.getParameter("query") == null ? "" : request.getParameter("query");
			ArrayList<ProductVO> array = dao.list(page, query);
			JSONArray jArray = new JSONArray();
			for(ProductVO vo : array) {
				JSONObject obj = new JSONObject();
				obj.put("pcode", vo.getPcode());
				obj.put("pname", vo.getPname());
				obj.put("price", vo.getPrice());
				obj.put("fprice", df.format(vo.getPrice()));
				obj.put("fdate", sdf.format(vo.getRdate()));
				jArray.add(obj);
			}
			out.print(jArray);
			break;
		case "/pro/total":
			String query1 = request.getParameter("query") == null ? "" : request.getParameter("query");
			out.print(dao.total(query1));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}