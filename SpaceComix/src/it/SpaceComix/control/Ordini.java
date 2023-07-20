package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.SpaceComix.model.OrdineBean;
import it.SpaceComix.model.OrdineDAO;

@WebServlet("/Ordini")
public class Ordini extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Ordini() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

        OrdineDAO ordineDAO = new OrdineDAO();
        Collection<OrdineBean> ordini = null;
        try {
            ordini = ordineDAO.doRetrieveAll("id DESC");
        } catch (SQLException e) {
        	response.sendError(500);
        }
        request.setAttribute("ordiniUtente", ordini);
        
        session.setAttribute("verificato", true);
        
        request.getRequestDispatcher("/ordini.jsp").forward(request, response);
	}

}
