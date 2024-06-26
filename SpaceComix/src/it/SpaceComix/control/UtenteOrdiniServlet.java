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
import it.SpaceComix.model.UserBean;


@WebServlet("/UtenteOrdiniServlet")
public class UtenteOrdiniServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UtenteOrdiniServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        
        UserBean user = (UserBean) session.getAttribute("user");
        int idUtente = user.getId();

        OrdineDAO ordineDAO = new OrdineDAO();
        Collection<OrdineBean> ordini = null;
        try {
            ordini = ordineDAO.doRetrievebyUser(idUtente);
        } catch (SQLException e) {
        	response.sendError(500);
        }
        request.setAttribute("ordiniUtente", ordini);
        
        session.setAttribute("verificato", true);
        
        request.getRequestDispatcher("/ordini.jsp").forward(request, response);
	}

}
