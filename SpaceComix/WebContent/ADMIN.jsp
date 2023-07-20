<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>ADMIN</title>
	<%@include file="Header.jsp" %>
	<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="quadrato">
	<%String success = (String) session.getAttribute("success");
       if (success != null) {
    	   out.print("<p class = \"success\">" + success + "</p>");
           session.setAttribute("success", null);
       }
       if (user == null || !user.getRuolo().equals("admin")) {
    	   response.sendError(401, "Soggetto non autorizzato ad accedere alla pagina");
   	   }
    %>
    
    <a href="AddProdotto.jsp" class="navbar-button">AGGIUNGI PRODOTTO</a>

	<a href="Catalogo.jsp" class="navbar-button"> MODIFICA/RIMUOVI PRODOTTO</a>
	
	<form action="Ordini" method="post">
    	<input type="submit" value="Vedi fattura">
    </form>

    
</div>
</body>
<%@include file="Footer.jsp" %>
</html>