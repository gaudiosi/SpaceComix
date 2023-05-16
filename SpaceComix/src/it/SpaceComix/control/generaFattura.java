package it.SpaceComix.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.SpaceComix.model.Carrello;
import it.SpaceComix.model.FatturaGenerator;
/**
 * Servlet implementation class generaFattura
 */
@WebServlet("/generaFattura")
public class generaFattura extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Carrello cart = (Carrello) request.getSession().getAttribute("cart");


        FatturaGenerator.main(cart);


        //response.sendRedirect("/conferma-checkout.jsp");
    }
}
