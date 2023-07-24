package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(value={"/stu/list", "/stu/insert"})
public class StudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = null;
		switch (request.getServletPath()) {
		case "/stu/list":
			request.setAttribute("pageName", "/stu/list.jsp");
			break;
		case "/stu/insert":
			request.setAttribute("pageName", "/stu/insert.jsp");
			
			break;
		}
		dis = request.getRequestDispatcher("/home.jsp");
		dis.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
