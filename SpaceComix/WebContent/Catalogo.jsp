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
	<title>Il nostro catalogo prodotti</title>
	<%@include file="Header.jsp" %>
	<link rel="stylesheet" href="Catalog.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<div class="quadrato">

<div class="categorie">
<form>
<h4>Categorie</h4>
  <div class="checkBoxs-label" id="FormCategorie"></div>
</form>
</div>

	<hr>
	<div class="product-list" id="productList">
	</div>
</div>
<script>
var urlParams;

document.addEventListener("DOMContentLoaded", function() {
    var checkBoxes = document.getElementsByName('vehicle');
    urlParams = new URLSearchParams(window.location.search);

    checkBoxes.forEach(function(checkbox) {
    	checkbox.checked = selectedValues.includes(checkbox.value);
    });
  });

function submitForm() {
    var checkBoxes = document.getElementsByName('vehicle');
    var selectedValues = [];

    checkBoxes.forEach(function(checkbox) {
        if (checkbox.checked) {
            selectedValues.push(checkbox.value);
        }
    });

    if (selectedValues.length > 0) {
        urlParams.set('genere', selectedValues.join(','));
    }

    TrovaProdotti(selectedValues.join(","));
}
</script>
<script>
$(document).ready(function() {
	  $.ajax({
	    url: 'GetCategorie',
	    type: 'POST',
	    dataType: 'json',
	    success: function(data) {
	      var formCategorie = $('#FormCategorie');
	      
	      if (formCategorie.is(':empty')) {
	        for (var i = 0; i < data.categorie.length; i++) {
	          var categoria = data.categorie[i];
	          
	          var div = $('<div>');
	          var input = $('<input>').attr('type', 'checkbox').attr('id', categoria.nome).attr('name', 'vehicle').attr('value', categoria.nome).attr('onclick', 'submitForm()');
	          var label = $('<label>').attr('for', categoria.nome ).text(categoria.nome);
	  
	          input.appendTo(div);
	          label.appendTo(div);
	          formCategorie.append(div);
	        }
	      }
	    },
	    error: function(xhr, status, error) {
	      response.sendError(500);
	    }
	  });
	  
	  TrovaProdotti("");
	});

function TrovaProdotti(SelectedValues) {
	
	console.log(SelectedValues);
	
	 $.ajax({
		    url: 'GetProdotti',
		    type: 'POST',
		    data: { generi: SelectedValues },
		    dataType: 'json',
		    success: function(data) {
		      var productList = $('#productList');
		      productList.empty();
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
		      response.sendError(500);
		    }
		  });
}
</script>
<%@include file="Footer.jsp" %>
</body>
</html>