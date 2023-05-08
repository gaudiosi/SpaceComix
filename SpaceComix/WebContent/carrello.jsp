<html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<!DOCTYPE html>

<head>
    <%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProdottoCarrello,it.SpaceComix.model.Carrello"%>


    <title></title>

    <link href="carrello.css" rel="stylesheet" type="text/css">

    <meta charset="UTF-8">
    <style>
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
    </style>



</head>

<div class="container">
    <%
        Carrello cart = (Carrello) request.getSession().getAttribute("cart");
        double totale=0;
        double spedizione=2;

        if(cart!=null && !cart.getProducts().isEmpty())
        {
    %>
    <h1 class="title">Carrello</h1>
    <div class="main-container">
        <div class="rounded-container">
            <%
                    ArrayList<ProdottoCarrello> prodotti = cart.getProducts();
                    for(ProdottoCarrello prodotto: prodotti )
                    {
                        totale+=prodotto.getProdotto().getPrezzo()* prodotto.getQuantita();


            %>
            <div class="card-container">
                <img src=<%=prodotto.getProdotto().getImage()%> alt="<%=prodotto.getProdotto().getImage_alt()%>" class="card-image" />
                <div class="product-container">
                    <div class="product-details">
                        <h2 class="product-details"><%=prodotto.getProdotto().getTitolo()%></h2>
                        <p class="product-info"><%=prodotto.getProdotto().getDescrizione()%></p>
                    </div>
                    <div class="flex-container">
                        <div class="button-group">
                            <form action="<%=request.getContextPath()%>/carrello" method="post"></form>
                            <input type="hidden" name="id" value="<%= prodotto.getProdotto().getID() %>">

                            <span class="minus-btn" onclick="updateQuantity(-1)">-</span>
                            <input type="number" class="input-number" name="quantity" value="<%=prodotto.getQuantita()%>" min="1" max="<%=prodotto.getProdotto().getQuantita()%>" onchange="this.form.submit()">
                            <span class="plus-btn" onclick="updateQuantity(1)">+</span>

                            <script>
                                function updateQuantity(change) {
                                    var quantityInput = document.querySelector('input[name="quantity"]');
                                    var currentQuantity = parseInt(quantityInput.value);
                                    var newQuantity = currentQuantity + change;
                                    if (newQuantity >= parseInt(quantityInput.min) && newQuantity <= parseInt(quantityInput.max)) {
                                        quantityInput.value = newQuantity;
                                        quantityInput.onchange();
                                    }
                                }
                            </script>


                        </div>
                        <div class="price-container">
                            <p class="price"><%= String.format("%.2f",prodotto.getProdotto().getPrezzo())%></p>
                            <svg onclick="submitForm()" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="svg">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                            <form id="myForm" action="<%=request.getContextPath()%>/carrello" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="id" value="<%=prodotto.getProdotto().getID()%>">
                            </form>
                            <script>
                                function submitForm() {
                                    document.getElementById("myForm").submit();
                                }
                            </script>
                        </div>
                    </div>
                </div>
            </div>
            <%

                    }

             %>
        </div>
        <div class="total-container">
            <div class="subtotal-container">
                <p class="color-1">Prodotti</p>
                <p class="color-1"><%=totale%>€</p>
            </div>
            <div class="subtotal-container">
                <p class="color-1">Spedizione</p>
                <p class="color-1"><%=spedizione%>€</p>
            </div>
            <hr/>
            <div class="giustifica">
                <p class="my-text-lg">Totale</p>
                <div>
                        <p class="final-price-amount"><%=totale+spedizione%>€ </p>
                        <p class="color-1">Include IVA</p>
                </div>
            </div>
            <button class="check-out">Check Out</button>

        </div>

    </div>

    <%
        }
        //SE IL CARRELLO E VUOTO
        else {

            %>
    <div class="emptycart">
        <img src="https://blogzine.webestica.com/rtl/assets/images/icon/empty-cart.svg" class="svg-container" alt="svg">


        <h1 id="head"> Il carrello è vuoto.</h1>
        <p id="para">Per aggiungere un prodotto al carrello, ritorna alla Home</p>
    </div>


            <%
                }
            %>

</div>



</body>

</html>
