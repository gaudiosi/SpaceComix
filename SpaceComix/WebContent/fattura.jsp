<!DOCTYPE html>
<html lang="it">
<head>
<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProdottoCarrello,it.SpaceComix.model.Carrello, it.SpaceComix.model.UserBean"%>
    <meta charset="UTF-8">
    <title>Fattura</title>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>


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
                <th>Prezzo</th>
                <th>Quantità</th>
                <th>Importo netto</th>
                <th>IVA</th>
            </tr>
        </thead>
        <tbody>
            <% 
            // Itera sui prodotti nel carrello e mostra i dettagli nella tabella
            for (ProdottoCarrello prodotto : prodotti) {
                double importoNetto = prodotto.getProdotto().getPrezzo() * prodotto.getQuantita();
                double iva = importoNetto * 0.15;
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
        <p>Imponibile: <%= String.format("%.2f", totale) %>€</p>
        <p>IVA sul prezzo: <%= String.format("%.2f", totale * 0.15) %>€</p>
        <p>Totale: <%= String.format("%.2f", totale + (totale * 0.15)) %>€</p>
    </div>
    
    
    
    </div>
	<button onclick="stampaPDF()">Stampa</button>
	<script>
    function stampaPDF() {
      var doc = new jsPDF();
      var html = document.querySelector('#FATTURA').innerHTML;

      doc.fromHTML(html, 15, 15, {
        'width': 170
      });

      doc.save('pagina.pdf');
    }
  </script>
    <%@include file="Footer.jsp" %>
</body>
</html>
