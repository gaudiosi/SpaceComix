<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="it.SpaceComix.model.CategoriaDAO" %>
<%@ page import="it.SpaceComix.model.CategoriaBean" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <%@include file="Header.jsp" %>
    <link rel="stylesheet" href="EditProdotto.css">
</head>
<body>
	<% if (user == null || !user.getRuolo().equals("admin")) {
    	   response.sendError(401, "Soggetto non autorizzato ad accedere alla pagina");
   	   }
    %>
    <h1>Add Product</h1>
    <% String error = (String) session.getAttribute("error");
       if (error != null) {
    	   out.print("<p class = \"error\">" + error + "</p>");
           session.setAttribute("error", null);
       }
    %>




    <div class="quadrato">
        <div class="container">
            <form action="AddProduct" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">


                <h1 class="title">Aggiungi un prodotto</h1>

                <div class="grid">
                    <div class="form-group a">
                        <label for="titolo">Titolo</label>
                        <input id="titolo" type="text" name="titolo" required>
                    </div>

                    <div class="form-group b">
                        <label for="editore">Editore</label>
                        <input type="text" id="editore" name="editore" required >
                    </div>

                    <div class="form-group c">
                        <label for="autore">Autore</label>
                        <input type="text" id="autore" name="autore" required >
                    </div>

                    <div class="form-group d">
                        <label for="isbn">ISBN </label>
                        <input type="text" id="isbn" name="isbn" required >
                    </div>

                    <div class="textarea-group">
                        <label for="descrizione">Descrizione</label>
                        <textarea id="descrizione" name="descrizione" rows="4" cols="50" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="prezzo">Prezzo</label>
                        <input id="prezzo" name="prezzo" type="number" step="0.01" required >
                    </div>

                    <div class="form-group">
                        <label for="quantita">Quantita</label>
                        <input name="quantita" id="quantita" type="number" required >
                    </div>

                    <div class="form-group">
                        <label for="sconto">Sconto</label>
                        <input name="sconto" id="sconto" type="number" required >
                    </div>
                    <div class="form-group">
                        <label for="iva">Iva</label>
                        <input name="iva" id="iva" type="number" required >
                    </div>
                    <div class="form-group">
                        <div class="button-container">
                            <label class="button" for="file">Clicca per selezionare un'immagine</label>
                            <input id="file" type="file" name="file"  style="display:none;"/>
                        </div>

                    </div>
                </div>

                <div class="checkboxes" id="checkboxes">
                </div>

                <div class="button-container">
                    <button class="button" type="submit">Aggiungi</button>
                </div>
            </form>
        </div>
    </div>
    <script>
    $(document).ready(function() {
  	  $.ajax({
  	    url: 'GetCategorie',
  	    type: 'POST',
  	    dataType: 'json',
  	    success: function(data) {
  	      var checkboxes = $('#checkboxes');
  	      
  	        for (var i = 0; i < data.categorie.length; i++) {
  	          var categoria = data.categorie[i];
  	          
  	          var div = $('<div>').attr('class', 'checkbox-group');
  	          var input = $('<input>').attr('id', categoria.nome).attr('type', 'checkbox').attr('name', 'categorie').attr('value', categoria.nome);
  	          var label = $('<label>').attr('for', categoria.nome ).text(categoria.nome);
  	  
  	          input.appendTo(div);
  	          label.appendTo(div);
  	        checkboxes.append(div);
  	        console.log(checkboxes);
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
