package controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;


@WebServlet(value={"/cart/list", "/cart/insert"})
public class CartCotroller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	GoodsDAO gdao = new GoodsDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session = request.getSession();
		ArrayList<CartVO> arrCart = session.getAttribute("arrCart") == null ?
				new ArrayList<CartVO>(): (ArrayList<CartVO>)session.getAttribute("arrCart");
 		switch (request.getServletPath()) {
		case "/cart/list":
			request.setAttribute("pageName", "/order/cart.jsp");
			dis.forward(request, response);
			break;
		case "/cart/insert":
			GoodsVO gvo = gdao.read(request.getParameter("gid"));
			CartVO cvo = new CartVO();
			cvo.setGid(gvo.getGid());
			cvo.setTitle(gvo.getTitle());
			cvo.setImage(gvo.getImage());
			cvo.setPrice(gvo.getPrice());
			cvo.setQnt(1);
			System.out.println(cvo.toString());
			arrCart.add(cvo);
			session.setAttribute("arrCart", arrCart);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
