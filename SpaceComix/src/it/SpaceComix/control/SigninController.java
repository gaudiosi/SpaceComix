package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.SpaceComix.model.UserBean;
import it.SpaceComix.model.UserDAO;

@WebServlet("/Signin")
public class SigninController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SigninController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		boolean errore = false; 
		HttpSession session = request.getSession();
		UserBean user = new UserBean();
        user.setEmail(request.getParameter("email"));
        user.setPassword(request.getParameter("password1"));
        String conferma = (request.getParameter("password2"));
        user.setUsername(request.getParameter("username"));
        user.setNome(request.getParameter("nome"));
        user.setCognome(request.getParameter("cognome"));
        
        if(conferma.equals(user.getPassword())) {
        	UserDAO userDao = new UserDAO();
			try {
				userDao.doSave(user);
			} catch (SQLException e){errore = true;}
			try {
				user = userDao.doRetrieveByKey(user.getEmail(), user.getPassword());
			} catch (SQLException e) {
				errore = true;
			}
			if(!errore && user.getId() != 0) {
            	session.setAttribute("user", user);
            	RequestDispatcher dispatcher = request.getRequestDispatcher("index");
            	dispatcher.forward(request, response);
            } else {
            	String error = "Errore del server";
        		session.setAttribute("error", error);
        		RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            	dispatcher.forward(request, response);
            }
		}else {
			String error = "Password non coincidenti. Si prega di riprovare";
			session.setAttribute("error", error);
			RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        	dispatcher.forward(request, response);
		}
    }
}