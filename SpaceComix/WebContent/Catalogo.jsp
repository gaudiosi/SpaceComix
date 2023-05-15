<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="it.SpaceComix.model.UserBean" %>
<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="java.util.*" import = "java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang ="it">
<head>
	<meta charset="UTF-8">
	<title>Il nostro catalogo prodotti</title>
	<%@include file="Header.jsp" %>
	<link rel="stylesheet" href="Catalog.css">

</head>
<body>



<form>
  <input type="checkbox" id="shonen" name="vehicle" value="shonen" onclick="submitForm()">
  <label for="vehicle1"> Shonen </label><br>
  <input type="checkbox" id="horror" name="vehicle" value="horror" onclick="submitForm()">
  <label for="vehicle2"> Horror </label><br>
  <input type="checkbox" id="shojo" name="vehicle" value="shojo" onclick="submitForm()">
  <label for="vehicle2"> Shojo </label><br>
</form>
	
	<div class="product-list">
<%
    // Recupera la lista di prodotti dal database o da un'altra fonte dati
    int contaitem = 0;
    ProductDAO dao = new ProductDAO();
    String order = "id DESC";
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
			}
				
		%>
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
	
<!--	FUNZIONA QUANDO USEREMO LE AJAX
<script>
  function submitForm() {
    var radioValue = document.querySelector('input[name="vehicle"]:checked').value;

    // Send an AJAX request to the server to update the order
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        // Update the content on the page if needed
      }
    };
    xhttp.open("GET", "Catalogo.jsp?genere=" + radioValue, true);
    xhttp.send();
    
    document.getElementById("genere").value = radioValue;
  }
</script>
-->

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


</body>
<%@include file="Footer.jsp" %>
</html>