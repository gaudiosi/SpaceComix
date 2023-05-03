package it.SpaceComix.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Logout
 */
@WebServlet("/Logout")
public class Logout extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		request.getSession().removeAttribute("role");
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("userid");
		request.getSession().invalidate();

		response.sendRedirect("home.jsp");	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}

	private static final long serialVersionUID = 1L;
    
    public Logout() {
        super();
    }
	
}