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
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	        String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        boolean errore = false;
	        UserDAO userDao = new UserDAO();
	        UserBean user = new UserBean();
			try {
				user = userDao.doRetrieveByKey(email, password);
			} catch (SQLException e){errore = true;}

	        if (errore == false) {
	            HttpSession session = request.getSession();
	            session.setAttribute("user", user);
	            response.sendRedirect("index.jsp");
	        } else {
	        	String error = "Invalid email or password. Please try again.";
	        	HttpSession session = request.getSession();
	        	session.setAttribute("error", error);
	        	response.sendRedirect("Login.jsp");
	        }
	    }
	}