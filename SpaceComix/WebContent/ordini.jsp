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
        <%if(((UserBean)request.getSession().getAttribute("user")).getRuolo().equals("admin"))
        {
    %>
        <label for="startDate">Start Date:</label>
        <input type="date" id="startDate">

        <label for="endDate">End Date:</label>
        <input type="date" id="endDate">

        <button onclick="filterDates()">Filter</button>

        <label for="inputid">Id utente:</label>
        <input type="text" id="inputid">
        <button onclick="filteruser()">Filter</button>



        <%
        }%>
    <table>
        <caption style="display: none;">Fattura</caption>



        <thead>
            <tr>
                <th>ID Utente</th>
                <th>ID Ordine</th>
                <th>Data Ordine</th>
                <th>Telefono</th>
            </tr>
        </thead>
        <tbody>
            <% for (OrdineBean ordine : ordini) { %>
                <tr>

                    <td class="id"><%= ordine.getIdUtente() %></td>

                    <td ><%= ordine.getId() %></td>
                    <td class="date-column"><%= ordine.getDataOrdine() %></td>
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
<script>
    function filterDates() {
        //ottieni la data dall'input
        const startDateValue = document.getElementById("startDate").value;
        const endDateValue = document.getElementById("endDate").value;

        // convertili correttamente
        const startDate = new Date(startDateValue);
        const endDate = new Date(endDateValue);

        //ottieni tutte le date
        const dateCells = document.querySelectorAll(".date-column"); // Use the unique class here

        dateCells.forEach(cell => {
            const rowDate = new Date(cell.textContent);

            // elimina tutta la riga
            const row = cell.parentNode;

            // nascondi tutte le righe che non soddisfano
            if (rowDate < startDate || rowDate > endDate) {
                row.style.display = "none";
            } else {
                row.style.display = "";
            }
        });
    }
    function filteruser() {
        //ottieni la data dall'input
        const idd = document.getElementById("inputid").value;

        // convertili correttamente

        //ottieni tutte le date
        const dateCells = document.querySelectorAll(".id"); // Use the unique class here

        dateCells.forEach(cell => {
            const rowDate =(cell.textContent);

            // elimina tutta la riga
            const row = cell.parentNode;

            // nascondi tutte le righe che non soddisfano
            if (!rowDate.includes(idd)) {
                row.style.display = "none";
            } else {
                row.style.display = "";
            }
        });
    }
</script>
    
    
</body>
<%@include file="Footer.jsp" %>
</html>
