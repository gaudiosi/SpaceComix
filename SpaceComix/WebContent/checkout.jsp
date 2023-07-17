<!DOCTYPE html>
<html lang="it">
<head>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProdottoCarrello,it.SpaceComix.model.Carrello, it.SpaceComix.model.UserBean"%>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <!-- Includi eventuali file CSS e script JavaScript necessari -->

    <%@include file="Header.jsp" %>
</head>
<body>
    <h1>Checkout</h1>


         <%		 
         		 Carrello cart = (Carrello) request.getSession().getAttribute("cart");
         		 double totale = 0;
         		 double spedizione=2;
                 ArrayList<ProdottoCarrello> prodotti = cart.getProducts();
                 for(ProdottoCarrello prodotto: prodotti )
                 {
                     totale+=prodotto.getProdotto().getPrezzo()* prodotto.getQuantita();

                 }
         %>    
    <!-- Mostra il totale e l'IVA che si sta per pagare -->
    <p>Totale: <%=String.format("%.2f",totale+spedizione)%>€</p>
    <p>IVA: <%=String.format("%.2f",(totale+spedizione)*0.15)%>€</p>

    <h2>Metodi di pagamento</h2>
    <form action="" method="post">
        <input type="radio" name="metodoPagamento" value="cartaCredito" required> Carta di credito<br>
        <input type="radio" name="metodoPagamento" value="paypal"> PayPal<br>
        <input type="radio" name="metodoPagamento" value="bonificoBancario"> Bonifico bancario<br>
        <!-- Aggiungi altri metodi di pagamento se necessario -->

        <br>
        <a href="fattura.jsp">Procedi al pagamento</a>
    </form>

    <%@include file="Footer.jsp" %>
</body>
</html>
