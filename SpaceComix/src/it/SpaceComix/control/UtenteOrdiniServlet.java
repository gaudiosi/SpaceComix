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

@WebServlet("/UtenteOrdiniServlet")
public class UtenteOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        int idUtente = (int) request.getAttribute("userid");

        OrdineDAO ordineDAO = new OrdineDAO();
        Collection<OrdineBean> ordini = null;
        try {
            ordini = ordineDAO.doRetrievebyUser(idUtente);
        } catch (SQLException e) {
        }
        request.setAttribute("ordiniUtente", ordini);
        
        session.setAttribute("verificato", true);
        
        request.getRequestDispatcher("/ordini.jsp").forward(request, response);
        
    }
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException {
    	doGet(request, response);
    }
}
