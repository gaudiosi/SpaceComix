<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Importa le classi necessarie --%>
<%@ page import="it.SpaceComix.model.OrdineBean" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Date" %>
<%@ page import="it.SpaceComix.model.OrdineDAO" %>



<!DOCTYPE html>
<html lang="it">
<head>
    <title>Ordini</title>
    <%@include file="Header.jsp" %>
    <%
	if (user == null) {
 	   	response.sendError(401, "Soggetto non autorizzato ad accedere alla pagina");
	}
    // Recupera l'idUtente dalla sessione
    int idUtente = (int) user.getId();

    Collection<OrdineBean> ordini = (Collection<OrdineBean>) request.getAttribute("ordiniUtente");
    
	%>
</head>
<body>
<div class="quadrato">
<div>
	<div id="Ordini">
	<% if (ordini != null) {%>
    <h1>Ordini dell'utente</h1>
    <table>
        <caption style="display: none;">Fattura</caption>

        <thead>
            <tr>
                <th>ID Ordine</th>
                <th>Data Ordine</th>
                <th>Telefono</th>
            </tr>
        </thead>
        <tbody>
            <% for (OrdineBean ordine : ordini) { %>
                <tr>
                    <td><%= ordine.getId() %></td>
                    <td><%= ordine.getDataOrdine() %></td>
                    <td><%= ordine.getTelefono() %></td>
                    <td>
                    	<form action="ComposizioneOrdine" method="post">
                    		<input type="hidden" name="idOrdine" value="<%= ordine.getId() %>">
                    		<input type="submit" value="Vedi fattura">
                    	</form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
    <%} else if((ordini == null) && (session.getAttribute("verificato") != null)) { %>
    <p>NIENTE ORDINI</p>
    <%} else {
 	   	response.sendError(500, "Violazione modalità d'accesso");
    	
    }%>
    </div>
</div>
</div>
    
<script>
$(document).ready(function() {
	  $("body").css({
	    "font-family": "Arial, sans-serif"
	  });

	  $("#Ordini").css({
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
</script>
    
    
</body>
<%@include file="Footer.jsp" %>
</html>
