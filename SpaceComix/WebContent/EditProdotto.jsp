<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="java.util.Collection" %>
<%@ page import="it.SpaceComix.model.CategoriaBean" %>

<!DOCTYPE html>
<html lang ="it">
<head>
    <meta charset="UTF-8">
    <title>Il nostro catalogo prodotti</title>
    <%@include file="Header.jsp" %>
    <link rel="stylesheet" href="EditProdotto.css">
</head>
<body>

<%
    ProductBean prodotto =(ProductBean) request.getAttribute("prodotto");

    Collection<CategoriaBean> categorie =  (Collection<CategoriaBean>) request.getAttribute("categorie");

    if (prodotto!=null)
    {


%>



<div class="quadrato">
<div class="container">
    <form action="<%=request.getContextPath()%>/AddProduct" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="modifica">
        <input type="hidden" name="id" value="<%=prodotto.getID()%>">


        <h1 class="title">Modifica il prodotto</h1>

    <div class="grid">
        <div class="form-group a">
            <label for="titolo">Titolo</label>
            <input id="titolo" type="text" value="<%=prodotto.getTitolo()%>" name="titolo" required>
        </div>

        <div class="form-group b">
            <label for="editore">Editore</label>
            <input type="text" id="editore" name="editore" required value="<%=prodotto.getEditore()%>">
        </div>

        <div class="form-group c">
            <label for="autore">Autore</label>
            <input type="text" id="autore" name="autore" required value="<%=prodotto.getAutore()%>">
        </div>

        <div class="form-group d">
            <label for="isbn">ISBN </label>
            <input type="text" id="isbn" name="isbn" required value="<%=prodotto.getIsbn()%>">
        </div>

        <div class="textarea-group">
            <label for="descrizione">Descrizione</label>
            <textarea id="descrizione" name="descrizione" rows="4" cols="50" required><%=prodotto.getDescrizione()%></textarea>
        </div>

        <div class="form-group">
            <label for="prezzo">Prezzo</label>
            <input id="prezzo" name="prezzo" type="number" step="0.01" required value="<%=prodotto.getPrezzo()%>">
        </div>

        <div class="form-group">
            <label for="quantita">Quantita</label>
            <input name="quantita" id="quantita" type="number" required value="<%=prodotto.getQuantita()%>">
        </div>

        <div class="form-group">
            <label for="sconto">Sconto</label>
            <input name="sconto" id="sconto" type="number" required value="<%=prodotto.getSconto()%>">
        </div>
        <div class="form-group">
            <label for="iva">Iva</label>
            <input name="iva" id="iva" type="number" required value="<%=prodotto.getIva()%>">
        </div>
        <div class="form-group">
            <div class="button-container">
            <label class="button" for="file">Clicca per selezionare un'immagine</label>
            <input id="file" type="file" name="file" value="<%=prodotto.getImage()%>"  style="display:none;"/>
            </div>

        </div>
    </div>



        <div class="checkboxes">

        <% for(CategoriaBean cat: categorie){

                %>
        <div class="checkbox-group">
            <input id="<%=cat.getNome()%>" type="checkbox" name="categorie" value="<%=cat.getNome()%>"<% if(prodotto.getGeneri().contains(cat)){%> checked <% }%> >
            <label for="<%=cat.getNome()%>"><%=cat.getNome()%></label>
        </div>


<%
    }
%>

    </div>

    <div class="button-container">
        <button class="button" type="submit">Conferma modifica</button>
    </div>
    </form>
</div>
</div>

<% } %>

</body>
</html>
