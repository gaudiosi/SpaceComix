<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="java.util.*" import = "java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang ="it">
<%@include file="Header.jsp" %>
<head>
	<meta charset="UTF-8">
	<title>Il nostro catalogo prodotti</title>
	
	<link rel="stylesheet" href="Catalog.css">

</head>
<body>


 <form>
  <input type="checkbox" id="vehicle1" name="vehicle1" value="shonen">
  <label for="vehicle1"> shonen</label><br>
  <input type="checkbox" id="vehicle2" name="vehicle2" value="shojo">
  <label for="vehicle2"> shojo</label><br>
</form>
	
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
						<p><%= String.format("%.2f",prodotto.getPrezzo())%>€</p>
					</div>
				</div>
			</a>
		</div>
		<%
			}
		%>
	</div>
	<div class="pagination">
		<a href="#">Precedente</a>
		<a href="#">1</a>
		<a href="#">2</a>
		<a href="#">3</a>
		<a href="#">4</a>
		<a href="#">Successiva</a>
	</div>
	<script>
	const products = document.querySelectorAll('.product');
	const itemsPerPage = 24;
	let currentPage = 1;

	function showPage(page) {
	  const startIndex = (page - 1) * itemsPerPage;
	  const endIndex = startIndex + itemsPerPage;

	  for (let i = 0; i < products.length; i++) {
	    if (i >= startIndex && i < endIndex) {
	      products[i].style.display = 'block';
	    } else {
	      products[i].style.display = 'none';
	    }
	  }
	}

	showPage(currentPage);

	document.querySelector('.pagination').addEventListener('click', function(event) {
	  if (event.target.tagName === 'A') {
		  if(event.target.textContent == "Precedente")
			  currentPage--;
		  else if(event.target.textContent == "Successiva")
			  currentPage++;
		  else 
			  currentPage = parseInt(event.target.textContent);
	    showPage(currentPage);
	  }
	});
	</script>
</body>
<%@include file="Footer.jsp" %>
</html>