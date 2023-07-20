<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- Importa le classi necessarie --%>
<%@ page import="it.SpaceComix.model.OrdineBean" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Date" %>
<%@ page import="it.SpaceComix.model.OrdineDAO" %>



<!DOCTYPE html>
<html>
<head>
    <title>Ordini dell'utente</title>
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
	<% if (ordini != null) {%>
    <h1>Ordini dell'utente</h1>
    <table>
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
                </tr>
            <% } %>
        </tbody>
    </table>
    <%} else if((ordini == null) && (session.getAttribute("verificato") != null)) { %>
    <p>NIENTE ORDINI<p>
    <%} else {
 	   	response.sendError(500, "Violazione modalità d'accesso");
    	
    }%>
    
    
</body>
<%@include file="Footer.jsp" %>
</html>
