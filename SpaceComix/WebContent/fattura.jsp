<!DOCTYPE html>
<html lang="it">
<head>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProdottoCarrello,it.SpaceComix.model.Carrello, it.SpaceComix.model.UserBean"%>
    <meta charset="UTF-8">
    <title>Fattura</title>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <%@include file="Header.jsp" %>
</head>
<body>
<%
	double totale = 0;
	double spedizione = 2;
	Carrello cart = (Carrello) request.getSession().getAttribute("cart");
	ArrayList<ProdottoCarrello> prodotti = cart.getProducts();
    for(ProdottoCarrello prodotto: prodotti )
    {
        totale+=prodotto.getProdotto().getPrezzo()* prodotto.getQuantita();
    }
%>
<div class="quadrato">
<div>
<div id="FATTURA">
    <div id="logo">
        <!-- Inserisci qui il logo -->
    </div>

    <div id="destinatario">
        <!-- Mostra i dati del destinatario -->
    </div>

    <table>
        <thead>
            <tr>
                <th>Nome prodotto (codice prodotto)</th>
                <th>Prezzo (Singolo)</th>
                <th>Quantità</th>
                <th>Importo netto</th>
                <th>IVA</th>
            </tr>
        </thead>
        <tbody>
            <% 
            // Itera sui prodotti nel carrello e mostra i dettagli nella tabella
            for (ProdottoCarrello prodotto : prodotti) {
                double prezzo = prodotto.getProdotto().getPrezzo() * prodotto.getQuantita();
                double iva = prezzo * 0.15;
                double importoNetto = prezzo - iva;
            %>
            <tr>
                <td><%= prodotto.getProdotto().getTitolo() %> (<%= prodotto.getProdotto().getID() %>)</td>
                <td><%= String.format("%.2f", prodotto.getProdotto().getPrezzo()) %>€</td>
                <td><%= prodotto.getQuantita() %></td>
                <td><%= String.format("%.2f", importoNetto) %>€</td>
                <td><%= String.format("%.2f", iva) %>€</td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <div id="riepilogo">
        <p>Imponibile: <%= String.format("%.2f", totale * 0.85) %>€</p>
        <p>IVA sul prezzo: <%= String.format("%.2f", totale * 0.15) %>€</p>
        <p>Spedizione: 2,00€</p>
        <p>Totale: <%= String.format("%.2f", totale + 2) %>€</p>
    </div>
</div>
<div class = "button-container">
	<button id="button" onclick="stampaPDF()">Stampa</button>
</div>
</div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<script>
$(document).ready(function() {
	  $("body").css({
	    "font-family": "Arial, sans-serif"
	  });

	  $("#FATTURA").css({
	    "max-width": "500px",
	    "margin": "0 auto",
	    "padding": "20px",
	    "border": "1px solid #ccc",
	    "background-color": "#f9f9f9",
	    "margin-top": "7rem"
	  });

	  $("table").css({
	    "width": "100%",
	    "border-collapse": "collapse"
	  });

	  $("th, td").css({
	    "padding": "8px",
	    "text-align": "left",
	    "border-bottom": "1px solid #ccc"
	  });

	  $("#riepilogo").css({
	    "text-align": "right",
	    "font-weight": "bold"
	  });
	  
	  $(".button-container").css({
		    "display": "flex",
		    "justify-content": "space-between",
		    "align-items": "center",
		    "max-width": "200px",
		    "margin-left": "auto",
		    "margin-right": "auto",
		    "margin-bottom": "5px",
		    "margin-top": "20px"
		  });

		  $("#button").css({
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

		  $("#button").hover(function() {
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

function stampaPDF() {
	  var element = document.querySelector('#FATTURA');

	  html2pdf().set({
	    filename: 'Ricevuta.pdf',
	    margin: [15, 15, 15, 15],
	    image: { type: 'jpeg', quality: 0.98 },
	    html2canvas: { dpi: 192, letterRendering: true },
	    jsPDF: { unit: 'pt', format: 'a4', orientation: 'portrait' }
	  }).from(element).save();
	}
</script>
<%@include file="Footer.jsp" %>
</body>
</html>