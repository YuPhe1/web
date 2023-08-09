package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.*;

@WebServlet(value={"/user/login", "/user/logout", "/user/read",
		"/user/insert", "/user/update", "/user/list", "/user/list.json", "/user/total"})

public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	UserDAO userDAO = new UserDAO();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session = request.getSession();
		switch (request.getServletPath()) {
		case "/user/login":
			request.setAttribute("pageName", "/user/login.jsp");
			dis.forward(request, response);
			break;
		case "/user/logout":
			session.removeAttribute("user");
			response.sendRedirect("/");
			break;
		case "/user/read":
			UserVO vo = (UserVO) session.getAttribute("user");
			request.setAttribute("vo", userDAO.read(vo.getUid()));
			request.setAttribute("pageName", "/user/read.jsp");
			dis.forward(request, response);
			break;
		case "/user/insert":
			request.setAttribute("pageName", "/user/insert.jsp");
			dis.forward(request, response);
			break;
		case "/user/list":
			request.setAttribute("pageName", "/user/list.jsp");
			dis.forward(request, response);
			break;
		case "/user/list.json": // /user/list.json?page=1&key=uid&query=
			String key = request.getParameter("key");
			String query = request.getParameter("query");
			int page = Integer.parseInt(request.getParameter("page"));
			ArrayList<UserVO> array = userDAO.list(key, query, page);
			Gson gson = new Gson();
			out.print(gson.toJson(array));
			break;
		case "/user/total":
			key = request.getParameter("key");
			query = request.getParameter("query");
			out.print(userDAO.total(key, query));
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = "/upload/photo/";
		File mdPath = new File("c:" + path);
		if(!mdPath.exists()) mdPath.mkdirs();
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session =request.getSession();
		switch(request.getServletPath()) {
		case "/user/login":
			String uid = request.getParameter("uid");
			String upass = request.getParameter("upass");
			UserVO user = userDAO.read(uid);
			int result = 0; // 아이디가 없는 경우
			if(user.getUid() != null) {
				if(upass.equals(user.getUpass())) {
					result = 1; // 로그인 성공 
					session.setAttribute("user", user);
				} else {
					result = 2; // 비밀번호 불일치
				}
			}
			out.print(result);
			break;
		case "/user/insert":
			
			// 사진저장
			MultipartRequest multi = new MultipartRequest(
					request, "c:"+path, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
			String photo = multi.getFilesystemName("photo") == null 
					? "" : path + multi.getFilesystemName("photo");
			user = new UserVO();
			user.setUid(multi.getParameter("uid"));
			user.setUpass(multi.getParameter("upass"));
			user.setUname(multi.getParameter("uname"));
			user.setPhone(multi.getParameter("phone"));
			user.setAddress1(multi.getParameter("address1"));
			user.setAddress2(multi.getParameter("address2"));
			user.setPhoto(photo);
			userDAO.insert(user);
			response.sendRedirect("/user/login");
			break;
		case "/user/update":
			multi = new MultipartRequest(
					request, "c:"+path, 1024*1024*10, "UTF-8", new DefaultFileRenamePolicy());
			photo = multi.getFilesystemName("photo") == null 
					? multi.getParameter("oldPhoto") : path + multi.getFilesystemName("photo");
			try {
				File file = new File("c:"+ photo);
				file.delete();
			} catch (Exception e) {
				System.out.println("파일 삭제 오류: " + e.toString());
			}
			System.out.println(photo);
			user = new UserVO();
			user.setUid(multi.getParameter("uid"));
			user.setUname(multi.getParameter("uname"));
			user.setPhone(multi.getParameter("phone"));
			user.setAddress1(multi.getParameter("address1"));
			user.setAddress2(multi.getParameter("address2"));
			user.setPhoto(photo);
			System.out.println(user.toString());
			userDAO.update(user);
			response.sendRedirect("/user/read");
			break;
		}
	}

}
