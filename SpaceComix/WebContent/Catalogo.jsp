<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="java.util.*" import = "java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
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
		<a href="Prodotto.jsp?id=<%= prodotto.getID() %>" class="product" style="background-color:#FFFFFF">
			<div>
				<div class="product-image">
					<img src="<%= prodotto.getImage() %>" alt="<%= prodotto.getImage_alt() %>">
				</div>
				<div class="product-details">
					<div class="product-title"><%= prodotto.getTitolo() %></div>
					<div class="product-description"><%= prodotto.getDescrizione()%></div>
					<div class="product-price">
						<% DecimalFormat formato = new DecimalFormat("0.00");
						   String numeroFormattato = formato.format(prodotto.getPrezzo());%>
						<%= numeroFormattato + (char) 128 %>
					</div>
				</div>
			</div>
		</a>
		<%
			}
		%>
	</div>
</body>
</html>