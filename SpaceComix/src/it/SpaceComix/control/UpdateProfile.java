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
 * Servlet implementation class UpdateProfile
 */
@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateProfile() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		UserBean user = new UserBean();
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password1"));
        String conferma = (request.getParameter("password2"));
        user.setUsername(request.getParameter("username"));
        user.setNome(request.getParameter("nome"));
        user.setCognome(request.getParameter("cognome"));
        UserBean user1 =(UserBean) session.getAttribute("user");
        user.setId(user1.getId());
        
        boolean errore = false;
        if((user.getPassword()).equals(conferma)) {
        	UserDAO userDao = new UserDAO();
        	try {
        		userDao.doUpdate(user);
        		user = userDao.doRetrieveByKey(request.getParameter("email"), request.getParameter("password"));
        	} catch (SQLException e){errore = true;}
        	if(errore = false) {
        		session.setAttribute("user", user);
        		response.sendRedirect("profilo.jsp");
        	}
        }
       	String error = "Invalid paramiter. Please try again.";
       	session.setAttribute("error", error);
       	response.sendRedirect("profilo.jsp");
		
    }
}

