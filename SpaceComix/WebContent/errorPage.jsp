
<%@ page isErrorPage="true" %>
<%@ page import="javax.servlet.ServletException, javax.servlet.http.HttpServletResponse" %>
<!DOCTYPE html>
<html>
<html lang="it">

<head>
	<meta charset="UTF-8">
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
    	<div class="button-container">
    		<a href="index" class="button-color">Ritorna alla pagina iniziale</a>
    	</div>
    </div>
	</div>
</body>
</html>