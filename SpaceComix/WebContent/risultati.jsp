<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="it.SpaceComix.model.CategoriaDAO" %>
<%@ page import="it.SpaceComix.model.CategoriaBean" %>
<%@ page import="java.util.*" import = "java.text.DecimalFormat" %>


<!DOCTYPE html>
<html lang ="it">
<head>
	<meta charset="UTF-8">
	<title>Risultati Ricerca</title>
	<%@include file="Header.jsp" %>
	<link rel="stylesheet" href="Catalog.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="quadrato">
<div>
	<% String titolo = (String) request.getAttribute("titolo"); %>
	<input type="hidden" id="parametroNascosto" value="<%= titolo %>">
	<p id = "error" class = "error"></p>
	<div class="product-list" id="productList">
	</div>
</div>
</div>
<script>
$(document).ready(function() {
	
	var titolo = document.getElementById('parametroNascosto').value;
	
	 $.ajax({
		    url: 'Trova',
		    type: 'POST',
		    data: { titolo: titolo },
		    dataType: 'json',
		    success: function(data) {
		      var productList = $('#productList');
		      productList.empty();
		      var divTesto = $('<div>').css({
		    	  'min-width': '100vw',
		    	  'display': 'flex',
		    	  'justify-content': 'center'
		    	});
		      var h2 = $('<h2>').text('Risultati per la ricerca:');
		      h2.appendTo(divTesto);
		      productList.append(divTesto);
		      for (var i = 0; i < data.prodotti.length; i++) {
		          var prodotto = data.prodotti[i];
		          
		          var div = $('<div>').addClass('product').css('background-color', '#FFFFFF');
		          var link = $('<a>').attr('href', 'Prodotto?id=' + prodotto.id).css('text-decoration', 'none');
		          var productImage = $('<div>').addClass('product-image').css('min-height', '28rem');
		          var img = $('<img>').attr('src', 'Immagini/' + prodotto.image).attr('alt', prodotto.image_alt).attr('type', 'image/svg+xml');
		          var productDetails = $('<div>').addClass('product-details');
		          var productTitle = $('<div>').addClass('product-title').append($('<p>').text(prodotto.titolo));
		          var productPrice = $('<div>').addClass('product-price').append($('<p>').text(prodotto.prezzo.toFixed(2) + '€'));

		          img.appendTo(productImage);
		          productTitle.appendTo(productDetails);
		          productPrice.appendTo(productDetails);
		          productImage.appendTo(link);
		          productDetails.appendTo(link);
		          link.appendTo(div);
		          productList.append(div);
		      }
		    },
		    error: function(xhr, status, error) {
                if (xhr.status === 800) {
                    $("#error").text("Nessun prodotto trovato come risultato della ricerca.");
                } else {
                	$("#error").text("C'è stato un problema con la ricerca, Si prega di riprovare.");
                }
            }
	});
});
</script>
<%@include file="Footer.jsp" %>
</body>
</html>