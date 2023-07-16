package it.SpaceComix.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.SpaceComix.model.UserDAO;

@WebServlet("/EmailAvailabilityServlet")
public class EmailAvailabilityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EmailAvailabilityServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        boolean emailExists = checkEmailExists(email);
        
        String json = "{\"result\":"+ emailExists +"}";

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        out.println(json);
    }

    private boolean checkEmailExists(String email) {
    	UserDAO userDao = new UserDAO();
    	boolean risposta = false;
		try {
			risposta = userDao.doRetrieveByKey(email);
		} catch (SQLException e) {
		}
        return risposta;
    }

}
