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

import it.SpaceComix.model.ProductBean;
import it.SpaceComix.model.ProductDAO;

@WebServlet("/Trova")
public class Trova extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Trova() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int contaitem = 0;
		HttpSession session = request.getSession();
		ProductDAO pdao = new ProductDAO();
		String titolo = request.getParameter("titolo");
	    String json = "{\"prodotti\": [";
	    
	    try {
			Collection<ProductBean> prodotti = pdao.doRetrieveByKey(titolo);
			for (ProductBean prodotto : prodotti) {
				
				if(contaitem == 0) {
					json += prodotto.stringify();
				} else {
					json += "," + prodotto.stringify();
				}
				contaitem++;
			}
		} catch (SQLException e) {
			response.sendError(500, "Ci sono stati problemi con il server, si prega di riprovare");
		}
	    
	    json += "]}";
	    
	    if(contaitem == 0) {
	    	response.sendError(800);
	    } else {
	    	response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    session.setAttribute("contaitem", contaitem);
		    response.getWriter().write(json);
	    }
	}

}
