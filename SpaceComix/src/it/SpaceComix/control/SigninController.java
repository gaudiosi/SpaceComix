package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.SpaceComix.model.UserBean;
import it.SpaceComix.model.UserDAO;

/**
 * Servlet implementation class SigninController
 */
@WebServlet("/Signin")
public class SigninController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SigninController() {
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

		UserBean user = new UserBean();
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password"));
        user.setUsername(request.getParameter("username"));
        user.setNome(request.getParameter("nome"));
        user.setCognome(request.getParameter("cognome"));
        
        UserDAO userDao = new UserDAO();
		try {
			userDao.doSave(user);
		} catch (SQLException e){}
		try {
			user = userDao.doRetrieveByKey(request.getParameter("email"), request.getParameter("password"));
		} catch (SQLException e){}
		if(user.getId() != 0) {
			HttpSession session = request.getSession();
			session.setAttribute("userid", user.getId());
			session.setAttribute("user", user.getUsername());
			session.setAttribute("role", user.getRuolo());
			response.sendRedirect("home.jsp");
		}	else	{
			String error = "Invalid paramiter. Please try again.";
        	HttpSession session = request.getSession();
        	session.setAttribute("error1", error);
        	response.sendRedirect("register.jsp");
		}
    }
}