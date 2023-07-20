<!DOCTYPE html>
<html lang="it">
<head>
<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ page import="it.SpaceComix.model.*" %>
    <%@ page import="java.util.ArrayList" %>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
            integrity="sha384-vtXRMe3mGCbOeY7l30aIg8H9p3GdeSe4IFlP6G8JMa7o7lXvnz3GFKzPxzJdPfGK" crossorigin="anonymous"> </script>

    <%@include file="Header.jsp" %>
</head>
<body>
<div class="quadrato">
<div id="container">
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
    <form action="<%=request.getContextPath()%>/checkout" method="post">
        <label for="ccn">Credit Card Number:</label>
        <input id="ccn" type="text" inputmode="numeric" name="numcarta" pattern="[0-9]{13,16}" autocomplete="cc-number" placeholder="xxxx xxxx xxxx xxxx" required> Scadenza<br>
        <input type="month" name="scadenza"  required>cvc<br>
        <input type="text" name="cvc"  placeholder="XXX"  pattern="[0-9]{3}" required>Intestatario<br>
        <input type="text" name="intestatario"  required><br>


        <!-- Aggiungi altri metodi di pagamento se necessario -->



        <h2>Indirizzo di spedizione</h2>
        <label for="ccap">Cap</label>
        <% IndirizzoBean indirizzo = (IndirizzoBean) request.getSession().getAttribute("alreadyindirizzo"); %>
        <input id="ccap" type="text" name="cap" pattern="[0-9]{1-5}" required <%if(indirizzo!=null){ %>value="<%=indirizzo.getCap()%>"<%}%>> <br>
        <label for="cita">Citta</label><input id="cita" type="text" name="citta" required <%if(indirizzo!=null){ %>value="<%=indirizzo.getCitta()%>"<%}%>> <br>
        <label for="via">Via</label><input id="via" type="text" name="via" required <%if(indirizzo!=null){ %>value="<%=indirizzo.getVia()%>"<%}%>> <br>
        <label for="civico"> Civico</label><input id="civico" type="text" pattern="[0-9]{1-3}" name="civico" required <%if(indirizzo!=null){ %>value="<%=indirizzo.getCivico()%>"<%}%>><br>
        <label for="tel">Recapito telefonico</label><input id="tel" type="text" name="telefono" required><br>



        <br>
        <div class="button-container">
            <button type="submit" class="button-color">Procedi al pagamento</button>
        </div>



    </form>
	</div>
    </div>
    <script>
    $(document).ready(function() {
    	  $("#container").css({
    	    "max-width": "600px",
    	    "margin": "200px auto",
    	    "background-color": "#fff",
    	    "padding": "2rem",
    	    "border-radius": "5px",
    	    "box-shadow": "0px 0px 10px rgba(0,0,0,0.1)"
    	  });
    	  
    	  $(".button-container").css({
    		    "display": "flex",
    		    "justify-content": "space-between",
    		    "align-items": "center",
    		    "max-width": "200px",
    		    "margin-left": "auto",
    		    "margin-right": "auto",
    		    "margin-bottom": "5px"
    		  });

    		  $(".button-color").css({
    		    "color": "#61BDD1",
    		    "padding": "0.3em 0.6em",
    		    "border": "none",
    		    "border-radius": "3px",
    		    "font-weight": "bold",
    		    "text-transform": "uppercase",
    		    "text-decoration": "none",
    		    "transition": "all 1000ms",
    		    "font-size": "15px",
    		    "position": "relative",
    		    "overflow": "hidden",
    		    "outline": "3px solid #61BDD1"
    		  });

    		  $(".button-color").hover(function() {
    		    $(this).css({
    		      "color": "#273862",
    		      "transform": "scale(1.05)",
    		      "outline": "3px solid #70bdca",
    		      "box-shadow": "4px 5px 17px -4px #61BDD1"
    		    });
    		  }, function() {
    		    $(this).css({
    		      "color": "#61BDD1",
    		      "transform": "none",
    		      "outline": "3px solid #61BDD1",
    		      "box-shadow": "none"
    		    });
    		  });
    });
    </script>
    <%@include file="Footer.jsp" %>
</body>
</html>
