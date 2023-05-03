package it.SpaceComix.control;


import it.SpaceComix.model.Carrello;
import it.SpaceComix.model.DAO;
import it.SpaceComix.model.ProductBean;
import it.SpaceComix.model.ProductDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/cart")
public class CarrelloServlet {

    private static final long serialVersionUID = 1L;

    static DAO<ProductBean> model = new ProductDAO();

    public CarrelloServlet()
    {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Carrello cart = (Carrello)  request.getSession().getAttribute("cart");
        //request.setAttribute("active","cart");

        if(cart== null)
        {
            cart = new Carrello();
            request.getSession().setAttribute("cart", cart);


        }
        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("WEB-INF/views/site/cart.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Carrello cart = (Carrello) request.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new Carrello();
            request.getSession().setAttribute("cart", cart);
        }

        String action = request.getParameter("action");

        try {
             if(action!= null)
             {
                 if(action.equals("add"))
                 {
                     int id = Integer.parseInt(request.getParameter("id"));
                     cart.addProdotto((ProductBean) model.doRetrieveByKey(id));
                     //response.sendRedirect("Products");
                     return;

                 }
                 else if (action.equals("remove"))
                 {
                     int id = Integer.parseInt(request.getParameter("id"));
                     cart.removeProdotto((ProductBean) model.doRetrieveByKey(id));
                     //response.sendRedirect("Products");
                     return;
                 }
                 else if (action.equals("decrease"))
                 {
                     int id = Integer.parseInt(request.getParameter("id"));
                     cart.decreaseProdotto((ProductBean) model.doRetrieveByKey(id));



                 }
                 else if(action.equals("update"))
                 {
                     int id = Integer.parseInt(request.getParameter("id"));
                     int quantity = Integer.parseInt(request.getParameter("quantity"));
                     cart.updateProdotto((ProductBean) model.doRetrieveByKey(id),quantity);

                 }
                 else {
                     response.sendError(404);
                 }


             }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }


}
