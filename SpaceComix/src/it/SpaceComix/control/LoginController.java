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

@WebServlet("/Login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LoginController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	        String email = request.getParameter("email");
	        String password = request.getParameter("password");

	        boolean errore = false;
	        UserDAO userDao = new UserDAO();
	        UserBean user = new UserBean();
			try {
				user = userDao.doRetrieveByKey(email, password);
			} catch (SQLException e){errore = true;}
			
			HttpSession session = request.getSession();
			
	        if (!errore) {
	            session.setAttribute("user", user);
	            response.sendRedirect("index.jsp");
	        } else {
	        	String error = "Invalid email or password. Please try again.";
	        	session.setAttribute("error", error);
	        	response.sendRedirect("Login.jsp");
	        }
	    }
	}