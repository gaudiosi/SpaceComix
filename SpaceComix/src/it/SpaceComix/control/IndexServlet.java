package it.SpaceComix.control;

import it.SpaceComix.model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

@WebServlet("/index")
public class IndexServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    static DAO<ProductBean> modelp = new ProductDAO();

    public IndexServlet()
    {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        try {

                Collection<ProductBean> prodotti = modelp.doRetrieveAll("nome DESC");


                Collection<ProductBean> prodotti1 = new LinkedList<ProductBean>();
                Collection<ProductBean> prodotti2 = new LinkedList<ProductBean>();

                String cat1 ="shonen";
                String cat2 = "dark fantasy";

                for(ProductBean product: prodotti){
                    for(CategoriaBean categoria: product.getGeneri())
                    {
                        if(categoria.getNome().equals(cat1))
                        {
                            prodotti1.add(product);
                        }
                        if(categoria.getNome().equals(cat2))
                        {
                            prodotti2.add(product);

                        }
                    }
                }

                request.getSession().setAttribute("prodotti1", prodotti1);
                request.getSession().setAttribute("cat1", cat1);

                request.getSession().setAttribute("prodotti2", prodotti2);
                request.getSession().setAttribute("cat2", cat2);



            RequestDispatcher dispatcher= request.getServletContext().getRequestDispatcher("/index.jsp");

            dispatcher.forward(request,response);


            }
            catch (SQLException e)
            {
                response.sendError(500, "Errore nell'elaborazione del server");
            }

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }}
