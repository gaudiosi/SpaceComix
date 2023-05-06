<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Il nostro catalogo prodotti</title>
</head>
<body>
	<h1>Il nostro catalogo prodotti</h1>
	
	<table>
		<thead>
			<tr>
				<th>Codice prodotto</th>
				<th>Nome prodotto</th>
				<th>Descrizione</th>
			</tr>
		</thead>
		<tbody>
			<%
				// Recupera la lista di prodotti dal database o da un'altra fonte dati
				ProductDAO dao = new ProductDAO();
				Collection <ProductBean> listaProdotti = dao.doRetrieveAll("id");
				
				// Itera attraverso la lista di prodotti e genera le righe della tabella
				for (ProductBean prodotto : listaProdotti) {
			%>
				<tr>
					<td><img src ="<%= prodotto.getImage() %>" alt ="<%= prodotto.getImage_alt() %>"></td>
					<td><%= prodotto.getTitolo() %></td>
					<td><%= prodotto.getDescrizione()%></td>
					<td><%= prodotto.getPrezzo() %></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
</body>
</html>