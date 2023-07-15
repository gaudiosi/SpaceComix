<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ page import="javax.servlet.ServletException, javax.servlet.http.HttpServletResponse" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
    <title>Pagina d'Errore</title>
    <link rel="stylesheet" href="Errore.css">
</head>
<body>
	<div class = "quadrato">
	<div class = "ordine">
    	<% Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code"); %>
        	<h1> Error Page <%= statusCode%> </h1>
    	<% String errorMessage = (String) request.getAttribute("javax.servlet.error.message"); %>
    		<p><%= errorMessage %></p>
    	
    		<a href="index.jsp" class="button-color">Ritorna alla pagina iniziale</a>
    </div>
	</div>
</body>
</html>