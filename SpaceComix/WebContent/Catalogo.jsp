<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="java.util.*" import = "java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang ="it">
<head>
	<meta charset="ISO-8859-1">
	<title>Il nostro catalogo prodotti</title>
	<%@include file="Header.jsp" %>
	<%@include file="Footer.jsp" %>
	<link rel="stylesheet" href="Catalog.css">
</head>
<body>
	
	<div class="product-list">
		<%
			// Recupera la lista di prodotti dal database o da un'altra fonte dati
			ProductDAO dao = new ProductDAO();
			Collection <ProductBean> listaProdotti = dao.doRetrieveAll("id DESC");
			
			// Itera attraverso la lista di prodotti e genera i div per ciascun prodotto
			for (ProductBean prodotto : listaProdotti) {
		%>
		<div class="product" style="background-color:#FFFFFF">
			<a href="Prodotto?id=<%= prodotto.getID() %>" style="text-decoration:none">
				<div class="product-image">
					<img src="Immagini/<%= prodotto.getImage() %>" alt="<%= prodotto.getImage_alt() %>">
				</div>
				<div class="product-details">
					<div class="product-title"><p><%= prodotto.getTitolo() %></p></div>
					<div class="product-description"><p><%= prodotto.getDescrizione()%></p></div>
					<div class="product-price">
						<p><% DecimalFormat formato = new DecimalFormat("0.00");
						   String numeroFormattato = formato.format(prodotto.getPrezzo());%>
						<%= numeroFormattato + (char) 128 %></p>
					</div>
				</div>
			</a>
		</div>
		<%
			}
		%>
	</div>
</body>
</html>