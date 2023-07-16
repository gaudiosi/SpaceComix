package it.SpaceComix.control;


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

@WebServlet("/Prodotto")
public class Prodotto extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productid = request.getParameter("id");
        if(productid!=null)
        {
            try {

                ProductBean prodotto = new ProductDAO().doRetrieveByKey(Integer.parseInt(productid));
                request.setAttribute("prodotto", prodotto);
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
}}
