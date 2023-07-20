package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.SpaceComix.model.OrdineBean;
import it.SpaceComix.model.OrdineDAO;

@WebServlet("/ComposizioneOrdine")
public class ComposizioneOrdine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ComposizioneOrdine() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        int id = Integer.parseInt((request.getParameter("idOrdine")));

        OrdineDAO ordineDAO = new OrdineDAO();
        OrdineBean ordine = null;
        try {
            ordine = ordineDAO.doRetrieveByKey(id);
        } catch (SQLException e) {
        	response.sendError(500);
        }

        request.getSession().setAttribute("ordine", ordine);
        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/fattura.jsp");

        dispatcher.forward(request, response);
	}

}
