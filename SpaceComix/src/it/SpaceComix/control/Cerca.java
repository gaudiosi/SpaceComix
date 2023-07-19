package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.SpaceComix.model.ProductBean;
import it.SpaceComix.model.ProductDAO;

@WebServlet("/Cerca")
public class Cerca extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Cerca() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int contaitem = 0;
		RequestDispatcher dispatcher = null;
		ProductDAO pdao = new ProductDAO();
		String titolo = request.getParameter("myInput");
	    
	    try {
			Collection<ProductBean> prodotti = pdao.doRetrieveByKey(titolo);
			for (ProductBean prodotto : prodotti) {
				
				contaitem++;
				
				if(contaitem == 1) {
					request.setAttribute("prodotto", prodotto);
			    	dispatcher = request.getRequestDispatcher("Prodotto.jsp");
			    }
			}
		} catch (SQLException e) {
			response.sendError(500, "Ci sono stati problemi con il server, si prega di riprovare");
		}
	    
	    if(contaitem == 1) {
    		dispatcher.forward(request, response);
	    } else {
	    	request.setAttribute("titolo", titolo);
	    	dispatcher = request.getRequestDispatcher("risultati.jsp");
	    	dispatcher.forward(request, response);
	    }
	}

}
