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
  <div class="checkBoxs-label" id="FormCategorie">
  </div>
</form>
</div>

	<hr>
	<div id="product-list" class="product-list">
<%
    // Recupera la lista di prodotti dal database o da un'altra fonte dati
    int contaitem = 0;
    ProductDAO dao = new ProductDAO();
	String order = "id DESC";
	if(request.getParameter("ordine") != null){
		order = request.getParameter("ordine");
	}
    String genere = request.getParameter("genere");
    Collection<ProductBean> listaProdotti = dao.doRetrieveAll(order);

    // Itera attraverso la lista di prodotti e genera i div per ciascun prodotto
    for (ProductBean prodotto : listaProdotti) {
        String[] generiRichiesti = null;

        if (genere != null && !genere.isEmpty()) {
            generiRichiesti = genere.split(",");
        }

        boolean isProdottoValido = true;

        if (generiRichiesti != null && generiRichiesti.length > 0) {
            // Controlla se il prodotto appartiene a almeno uno dei generi richiesti
            isProdottoValido = false;

            for (String genereRichiesto : generiRichiesti) {
                if (prodotto.appartieneAGenere(genereRichiesto) == 1) {
                    isProdottoValido = true;
                    break;
                }
            }
        }

        if (isProdottoValido) {
            contaitem++; //totale item per poi generare dinamicamente abbastanza pagine
%>
		
		<div class="product" style="background-color:#FFFFFF">
			<a href="Prodotto?id=<%= prodotto.getID() %>" style="text-decoration:none">
				<div class="product-image">
					<img src="Immagini/<%= prodotto.getImage() %>" alt="<%= prodotto.getImage_alt() %>" type="image/svg+xml">
				</div>
				<div class="product-details">
					<div class="product-title"><p><%= prodotto.getTitolo() %></p></div>
					<%--<div class="product-description"><p><%= prodotto.getDescrizione()%></p></div>--%>
					<div class="product-price">
						<p><%= String.format("%.2f",prodotto.getPrezzo())%>€</p>
					</div>
				</div>
			</a>
		</div>
		<%
				}
			}
				
		%>
	</div>
	</div>
		<%
	int itemsPerPage = 24;
	int max = contaitem/itemsPerPage;
	if ((contaitem % itemsPerPage) != 0) max++;
	if (max > 1) {
		%>
	<div class="pagination" data-items-per-page="<%= itemsPerPage %>">
		<a href="#">Precedente</a>
		<%
		for(int i = 1; i <= max; i++)
		{
		%>
		<a href="#"><%= i %></a>
		<% 
		}
		%>
		<a href="#">Successiva</a>
		<% 
		}
		%>
	</div>
	<script>
	const products = document.querySelectorAll('.product');
	let currentPage = 1;
	const itemsPerPage = parseInt(document.querySelector('.pagination').getAttribute('data-items-per-page'));
	const maxPage = <%= max %>;
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
		  if((event.target.textContent == "Precedente") && (currentPage > 1))
			  currentPage--;
		  else if((event.target.textContent == "Successiva") && (currentPage < maxPage))
			  currentPage++;
		  else if (!isNaN(parseInt(event.target.textContent))) {
			  const page = parseInt(event.target.textContent);
			  if (page >= 1 && page <= maxPage) {
			    currentPage = page;
			  }}
	    showPage(currentPage);
	  }
	});
</script>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    var checkBoxes = document.getElementsByName('vehicle');
    var urlParams = new URLSearchParams(window.location.search);
    var selectedValues = urlParams.get('genere') ? urlParams.get('genere').split(',') : [];

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

    var urlParams = new URLSearchParams(window.location.search);

    checkBoxes.forEach(function(checkbox) {
      if (!checkbox.checked) {
        urlParams.delete('genere', checkbox.value);
      }
    });

    if (selectedValues.length > 0) {
      urlParams.set('genere', selectedValues.join(','));
    }

    window.location.search = urlParams.toString();
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
	      for (var i = 0; i < data.categorie.length; i++) {
	        var categoria = data.categorie[i];

	        var div = $('<div>');
	        var input = $('<input>').attr('type', 'checkbox').attr('id', categoria.nome).attr('name', 'vehicle').attr('value', categoria.nome).attr('onclick', 'submitForm()');
	        var label = $('<label>').attr('for', categoria.nome ).text(categoria.nome);

	        input.appendTo(div);
	        label.appendTo(div);
	        formCategorie.append(div);
	      }
	    },
	    error: function(xhr, status, error) {
	      response.sendError(500);
	    }
	  });
});

$(document).ready(function() {
	  $.ajax({
	    url: 'GetProdotti',
	    type: 'POST',
	    dataType: 'json',
	    success: function(data) {
	      var formCategorie = $('#FormCategorie');
	      for (var i = 0; i < data.categorie.length; i++) {
	        var categoria = data.categorie[i];

	        var div = $('<div>');
	        var input = $('<input>').attr('type', 'checkbox').attr('id', categoria.nome).attr('name', 'vehicle').attr('value', categoria.nome).attr('onclick', 'submitForm()');
	        var label = $('<label>').attr('for', categoria.nome ).text(categoria.nome);

	        input.appendTo(div);
	        label.appendTo(div);
	        formCategorie.append(div);
	      }
	    },
	    error: function(xhr, status, error) {
	      response.sendError(500);
	    }
	  });
});
</script>

</body>
<%@include file="Footer.jsp" %>
</html>