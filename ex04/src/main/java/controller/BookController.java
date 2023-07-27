package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

@WebServlet(value={"/book/search", "/book/insert", "/book/list", "/book/list.json", "/book/total"})
public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	BookDAO dao = new BookDAO(); 
	Gson gson = new Gson();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		PrintWriter out = response.getWriter();	// 브라우저
		switch (request.getServletPath()) {
		case "/book/search":
			request.setAttribute("pageName", "/book/search.jsp");
			dis.forward(request, response);
			break;
		case "/book/list":
			request.setAttribute("pageName", "/book/list.jsp");
			dis.forward(request, response);
			break;
		case "/book/list.json":
			int page = Integer.parseInt(request.getParameter("page"));
			out.println(gson.toJson(dao.list(page)));
			break;
		case "/book/total":
			out.print(dao.total());
			break;
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch (request.getServletPath()) {
		case "/book/insert": // REST API
			BookVO vo = new BookVO(); 
			vo.setIsbn(request.getParameter("isbn"));
			vo.setAuthors(request.getParameter("authors"));
			vo.setPublisher(request.getParameter("publisher"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			vo.setContents(request.getParameter("contents"));
			vo.setTitle(request.getParameter("title"));
			vo.setThumbnail(request.getParameter("thumbnail"));
			vo.setUrl(request.getParameter("url"));
			//System.out.println(vo.toString());
			dao.insert(vo);
			break;
		}
	}

}
