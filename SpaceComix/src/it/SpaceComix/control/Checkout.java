package it.SpaceComix.control;


import it.SpaceComix.model.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;


@WebServlet("/checkout")
public class Checkout extends HttpServlet {

    private static final long serialVersionUID = 1L;

    static DAO<IndirizzoBean> modeli = new IndirizzoDAO();
    static DAO<OrdineBean> modelo = new OrdineDAO();
    static DAO<PagamentoBean> modelp = new PagamentoDAO();

    static DAO<ProductBean> modelD = new ProductDAO();




    public Checkout()
    {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean)  request.getSession().getAttribute("user");


        if(user == null || user.getId()==-1)
        {

            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Login.jsp");

            dispatcher.forward(request, response);


        }
        else {
            try { //Se l'utente ha già un indirizzo, mostraglielo
                IndirizzoBean indirizzo;

                indirizzo = modeli.doRetrieveByKey(user.getId());


                if (indirizzo.getIdUtente()==-1)
                {
                    request.getSession().setAttribute("alreadyindirizzo", null);
                }
                else{
                    request.getSession().setAttribute("alreadyindirizzo", indirizzo);
                }
            } catch (SQLException e) {
                response.sendError(500, "Errore nell'elaborazione del server");
            }


            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/checkout.jsp");
            dispatcher.forward(request, response);




    }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserBean user = (UserBean) request.getSession().getAttribute("user");
        Carrello cart = (Carrello) request.getSession().getAttribute("cart");

        if (user == null) {
            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/Login.jsp");
            dispatcher.forward(request, response);


        }
        else if(cart==null || cart.getProducts().isEmpty())
        {
            response.sendError(400, "Carrello vuoto");


        }

        else {


            try {
                OrdineBean newordine = new OrdineBean();
                newordine.setIdUtente(user.getId());
                newordine.setTelefono(request.getParameter("telefono"));
                newordine.setDataOrdine(Date.valueOf(LocalDate.now()));





                //AGGIORNO L'INDIRIZZO
                IndirizzoBean nuovoindirizzo = new IndirizzoBean();
                nuovoindirizzo.setCitta(request.getParameter("citta"));
                nuovoindirizzo.setCap(request.getParameter("cap"));
                nuovoindirizzo.setCivico(Integer.parseInt(request.getParameter("civico")));
                nuovoindirizzo.setVia(request.getParameter("via"));
                nuovoindirizzo.setIdUtente(user.getId());


                // rimuovo il vecchio indirizzo e conservo il nuovo
                IndirizzoBean vecchioindirizzo = modeli.doRetrieveByKey(user.getId());
                if(vecchioindirizzo.getIdUtente()!=-1 && !nuovoindirizzo.equals(vecchioindirizzo)){

                    modeli.doDelete(vecchioindirizzo.getIdUtente());
                    modeli.doSave(nuovoindirizzo);

                }


                newordine.setIndirizzo(nuovoindirizzo.getCap()+ " " + nuovoindirizzo.getCitta() + " " + nuovoindirizzo.getVia() + " " + nuovoindirizzo.getCivico());



                //SALVO IL PAGAMENTO
                PagamentoBean pagamento = new PagamentoBean();
                pagamento.setNumCarta(request.getParameter("numcarta"));
                pagamento.setIdUtente(user.getId());
                pagamento.setCvc(Integer.parseInt(request.getParameter("cvc")));
                pagamento.setIntestatario(request.getParameter("intestatario"));


                String inputMonth = request.getParameter("scadenza");
                if (inputMonth != null && !inputMonth.isEmpty()) {
                    LocalDate localDate = LocalDate.parse(inputMonth + "-01", DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                    java.sql.Date sqlDate = java.sql.Date.valueOf(localDate);
                    pagamento.setScadenza(sqlDate);
                } else {
                    response.sendError(401, "Data Incorretta");
                }
                Collection<PagamentoBean> carte = modelp.doRetrieveAll(null);
                if(!carte.contains(pagamento)) {
                    modelp.doSave(pagamento);
                }
                newordine.setNumCarta(pagamento.getNumCarta());


                //SALVO L'ORDINE E LA SUA COMPOSIZIONE
                ArrayList<ProductOrdineBean> prodotti = new ArrayList<ProductOrdineBean>();
                Collection<ProdottoCarrello> carrello = cart.getProducts();

                for (ProdottoCarrello element : carrello) {
                    ProductOrdineBean newp = new ProductOrdineBean();

                    ProductBean temproudct = element.getProdotto();

                    //Diminuisco la quantità rimanente del prodotto
                    temproudct.setQuantita(temproudct.getQuantita()- element.getQuantita());
                    if(temproudct.getQuantita()==0)
                    {
                        modelD.doDelete(temproudct.getID());
                    }
                    else {
                        modelD.doUpdate(temproudct);
                    }


                    newp.setTitolo(temproudct.getTitolo());
                    newp.setIva(temproudct.getIva());
                    newp.setIdProdotto(temproudct.getID());
                    newp.setPrezzo_vendita(temproudct.getPrezzo());
                    newp.setQuantita(element.getQuantita());

                    prodotti.add(newp);

                }
                newordine.setProdotti(prodotti);

                modelo.doSave(newordine);
                request.getSession().setAttribute("ordine", newordine);







            } catch (Exception e) {
                response.sendError(500, "Errore nell'elaborazione del server");
            }





            request.getSession().setAttribute("cart", null);
            RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/fattura.jsp");

            dispatcher.forward(request, response);


        }




    }


}
