<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>SpaceComix</title>
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
    %>
</div>
</body>
<%@include file="Footer.jsp" %>
</html>



<!-- COSE DA FARE PRIMO (VORREI FARLO IO COSì FACCIO QUALCOSA E MI RENDO UTILE SE NON VI OFFENDE
INTEGRARE NELL'HEADER IL PULSANTE ADMIN SE L'UTENTE è ADMIN

 -->