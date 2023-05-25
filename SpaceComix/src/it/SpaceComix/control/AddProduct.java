package it.SpaceComix.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.SpaceComix.model.ProductBean;
import it.SpaceComix.model.ProductDAO;

@WebServlet("/AddProduct")
public class AddProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddProduct() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean errore = false;
        HttpSession session = request.getSession();
        ProductBean product = new ProductBean();
        product.setQuantita(Integer.parseInt(request.getParameter("quantita")));
        product.setIva(Integer.parseInt(request.getParameter("iva")));
        product.setPrezzo(Float.parseFloat(request.getParameter("prezzo")));
        product.setTitolo(request.getParameter("titolo"));
        product.setDescrizione(request.getParameter("descrizione"));
        product.setAutore(request.getParameter("autore"));
        product.setEditore(request.getParameter("editore"));
        product.setIsbn(request.getParameter("isbn"));
        product.setSconto(Integer.parseInt(request.getParameter("sconto")));

        String isbnRegex = "^978-[0-9]{1,5}-[0-9]{1,7}-[0-9]{1,6}-[0-9]{1}$";
        if (!product.getIsbn().matches(isbnRegex)) {
            errore = true;
            String error = "Invalid ISBN format. Please try again.";
            session.setAttribute("error", error);
            response.sendRedirect("add_product.jsp");
            return;
        }

        ProductDAO productDao = new ProductDAO();
        try {
            productDao.doSave(product);
        } catch (SQLException e) {
            errore = true;
        }

        if (!errore) {
            session.setAttribute("success", "Prodotto aggiunto.");
            response.sendRedirect("index.jsp");
        } else {
            String error = "errpre, ritenta.";
            session.setAttribute("error", error);
            response.sendRedirect("AddProdotto.jsp");
        }
    }
}
