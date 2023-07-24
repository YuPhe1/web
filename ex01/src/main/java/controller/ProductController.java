package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

@WebServlet(value={"/pro/list", "/pro/insert"})
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	ProductDAO dao = new ProductDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = null;
		switch (request.getServletPath()) {
		case "/pro/list":
			request.setAttribute("array", dao.list());
			request.setAttribute("pageName", "/pro/list.jsp");
			break;
		case "/pro/insert":
			request.setAttribute("pageName", "/pro/insert.jsp");		
			break;
		}
		dis = request.getRequestDispatcher("/home.jsp");
		dis.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
