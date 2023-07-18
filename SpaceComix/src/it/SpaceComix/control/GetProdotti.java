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

@WebServlet("/GetProdotti")
public class GetProdotti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetProdotti() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int contaitem = 0;
		HttpSession session = request.getSession();
		ProductDAO pdao = new ProductDAO();
	    String ord = "nome DESC";
	    String json = "{\"prodotti\": [";
	    
	    try {
			Collection<ProductBean> prodotti = pdao.doRetrieveAll(ord);
		    String genere = request.getParameter("generi");
			for (ProductBean prodotto : prodotti) {
		        String[] generiRichiesti = null;

		        if (genere != null && !genere.isEmpty()) {
		            generiRichiesti = genere.split(",");
		        }

		        boolean isProdottoValido = true;

		        if (generiRichiesti != null && generiRichiesti.length > 0) {
		            isProdottoValido = false;

		            for (String genereRichiesto : generiRichiesti) {
		                if (prodotto.appartieneAGenere(genereRichiesto) == 1) {
		                    isProdottoValido = true;
		                    break;
		                }
		            }
		        }

		        if (isProdottoValido) {
		            if(contaitem == 0) {
						json += prodotto.stringify();
					} else {
						json += "," + prodotto.stringify();
					}
		            contaitem++;
		        }
			}
		} catch (SQLException e) {
			response.sendError(500, "Ci sono stati problemi con il server, si prega di riprovare");
		}
	    
	    json += "]}";
	    
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    session.setAttribute("contaitem", contaitem);
	    response.getWriter().write(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
