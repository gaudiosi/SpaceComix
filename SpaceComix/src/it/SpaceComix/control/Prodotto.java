package it.SpaceComix.control;


import it.SpaceComix.model.CategoriaBean;
import it.SpaceComix.model.DAO;
import it.SpaceComix.model.ProductBean;
import it.SpaceComix.model.ProductDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/Prodotto")
public class Prodotto extends HttpServlet {

    private static final long serialVersionUID = 1L;
    static DAO<ProductBean> modelp = new ProductDAO();


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productid = request.getParameter("id");
        if(productid!=null)
        {
            try {

                ProductBean prodotto = modelp.doRetrieveByKey(Integer.parseInt(productid));
                request.setAttribute("prodotto", prodotto);

                Collection<CategoriaBean> categorie=prodotto.getGeneri();


                //Trovo i prodotti simili: quelli con più generi in comune
                List<ProductBean> prodotti = (List<ProductBean>)modelp.doRetrieveAll("nome DESC");


                Comparator <ProductBean> ConfrontoGeneriInComune = (c1, c2) -> {
                    int GeneriInComune1 = countCommonElements(categorie, c1.getGeneri());
                    int GeneriInComune2 = countCommonElements(categorie, c2.getGeneri());
                    return Integer.compare(GeneriInComune2, GeneriInComune1); // Descending order
                };

                prodotti.sort(ConfrontoGeneriInComune);
                request.getSession().setAttribute("simili", prodotti);

                RequestDispatcher dispatcher= request.getServletContext().getRequestDispatcher("/Prodotto.jsp");
                dispatcher.forward(request,response);


            }
            catch (SQLException e)
            {
                response.sendError(500, "Errore nell'elaborazione del server");
            }
        }
        else response.sendRedirect("Home"); //da vedere
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
    	doPost(request, response);
}


    private static int countCommonElements(Collection<CategoriaBean> col1, Collection<CategoriaBean> col2) {
        Set<CategoriaBean> set1 = new HashSet<>(col1);
        Set<CategoriaBean> set2 = new HashSet<>(col2);
        set1.retainAll(set2);  //RIMANGONO SOLO GLI ELEMENTI IN COMUNE
        System.out.println(set1.size());
        return set1.size();
    }
}







