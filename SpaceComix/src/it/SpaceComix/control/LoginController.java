package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.SpaceComix.model.*;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/Login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	        String username = request.getParameter("username");
	        String password = request.getParameter("password");

	        UserDAO userDao = new UserDAO();
	        UserBean user = null;
			try {
				user =  userDao.doRetrieveByKey(username, password);
			} catch (SQLException e){}

	        if (user != null) {
	            HttpSession session = request.getSession();
	            session.setAttribute("user", user);
	            session.setAttribute("role", user.getRuolo().equals("admin"));
	            response.sendRedirect(request.getContextPath() + "/home");
	        } else {
	            request.setAttribute("error", "Invalid username or password");
	            request.getRequestDispatcher("login.jsp").forward(request, response);
	        }
	    }
	}