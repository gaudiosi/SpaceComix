package it.SpaceComix.control;

import it.SpaceComix.model.Carrello;
import it.SpaceComix.model.ProductBean;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import it.SpaceComix.model.DAO;
import it.SpaceComix.model.ProductModelDM;
import it.SpaceComix.model.ProductDAO;

/**
 * Servlet implementation class ControllerProdotti
 */
@WebServlet("/ControllerProdotti")
public class ControllerProdotti extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static boolean isDataSource = true;

	static DAO model;

	static {
		if (isDataSource) {
			model = new ProductDAO();
		} else {
			model = new ProductModelDM();
		}
	}
    /**
     * Default constructor. 
     */
    public ControllerProdotti() {
        // TODO Auto-generated constructor stub
		super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*response.getWriter().append("Served at: ").append(request.getContextPath());*/

		Carrello cart = (Carrello)request.getSession().getAttribute("cart");
		if(cart == null) {
			cart = new Carrello();
			request.getSession().setAttribute("cart", cart);
		}

		String action = request.getParameter("action");

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("addC")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.addProduct(model.doRetrieveByKey(id));
				} else if (action.equalsIgnoreCase("deleteC")) {
					int id = Integer.parseInt(request.getParameter("id"));
					cart.deleteProduct(model.doRetrieveByKey(id));
				} else if (action.equalsIgnoreCase("read")) {
					int id = Integer.parseInt(request.getParameter("id"));
					request.removeAttribute("product");
					request.setAttribute("product", model.doRetrieveByKey(id));
				} else if (action.equalsIgnoreCase("delete")) {
					int id = Integer.parseInt(request.getParameter("id"));
					model.doDelete(id);
				} else if (action.equalsIgnoreCase("insert")) {
					String titolo = request.getParameter("titolo");
					String descrizione = request.getParameter("descrizione");
					int prezzo = Integer.parseInt(request.getParameter("prezzo"));
					int quantita = Integer.parseInt(request.getParameter("quantita"));

					ProductBean bean = new ProductBean();
					bean.setTitolo(titolo);
					bean.setDescrizione(descrizione);
					bean.setPrezzo(prezzo);
					bean.setQuantita(quantita);
					model.doSave(bean);
				}
			}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		request.getSession().setAttribute("cart", cart);
		request.setAttribute("cart", cart);


		String sort = request.getParameter("sort");

		try {
			request.removeAttribute("products");
			request.setAttribute("products", model.doRetrieveAll(sort));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductView.jsp");
		dispatcher.forward(request, response);
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
