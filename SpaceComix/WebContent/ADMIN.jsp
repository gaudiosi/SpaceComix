<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>ADMIN</title>
	<%@include file="Header.jsp" %>
	<link rel="stylesheet" href="index.css">
</head>
<body>
<div class="quadrato">
	<% String success = (String) session.getAttribute("success");
       if (success != null) {
    	   out.print("<p class = \"success\">" + success + "</p>");
           session.setAttribute("success", null);
       }
       if (!user.getRuolo().equals("admin")) {
   		response.sendRedirect("index.jsp");
   	   }
    %>
    <a href="AddProdotto.jsp" class="navbar-button">AGGIUNGI PRODOTTO</a>
    
</div>
</body>
<%@include file="Footer.jsp" %>
</html>