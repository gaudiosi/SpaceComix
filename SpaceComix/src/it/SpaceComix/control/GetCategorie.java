package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.SpaceComix.model.CategoriaBean;
import it.SpaceComix.model.CategoriaDAO;

@WebServlet("/GetCategorie")
public class GetCategorie extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public GetCategorie()
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CategoriaDAO cdao = new CategoriaDAO();
		int i = 0;
	    String ord = "nome DESC";
	    String json = "{\"categorie\": [";
	    
	    try {
			Collection<CategoriaBean> categorie = cdao.doRetrieveAll(ord);
			for (CategoriaBean c : categorie) {
				if(i == 0) {
					json += c.stringify();
				} else {
					json += "," + c.stringify();
				}
				i++;
		    }
		} catch (SQLException e) {
			response.sendError(500, "Ci sono stati problemi con il server, si prega di riprovare");
		}
	    
	    json += "]}";
	    
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
