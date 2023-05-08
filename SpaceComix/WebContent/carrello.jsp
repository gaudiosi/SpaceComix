<!DOCTYPE html>
<html lang="it">

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>




<head>
    <%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProdottoCarrello,it.SpaceComix.model.Carrello"%>



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
            ArrayList<ProdottoCarrello> prodotti = cart.getProducts();
            for(ProdottoCarrello prodotto: prodotti )
            {
                totale+=prodotto.getProdotto().getPrezzo();


    %>
    <h1 class="title">Carrello</h1>
    <div class="main-container">
        <div class="rounded-container">
            <div class="card-container">
                <img src=<%=prodotto.getProdotto().getImage()%> alt="<%=prodotto.getProdotto().getImage_alt()%>" class="card-image" />
                <div class="product-container">
                    <div class="product-details">
                        <h2 class="product-details"><%=String.format("%.2f",prodotto.getProdotto().getTitolo())%>></h2>
                        <p class="product-info"><%=String.format("%.2f",prodotto.getProdotto().getDescrizione())%>></p>
                    </div>
                    <div class="flex-container">
                        <div class="button-group">
                            <span class="minus-btn">-</span>
                            <input type="number" class="input-number" value="<%=prodotto.getQuantita()%>" min="1" max="<%=prodotto.getProdotto().getQuantita()%>">
                            <span class="plus-btn">+</span>
                        </div>
                        <div class="price-container">
                            <p class="price"><%= String.format("%.2f",prodotto.getProdotto().getPrezzo())%></p>
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="svg">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                            </svg>
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
                <p class="color-1"><%=totale%>€/p>
            </div>
            <div class="subtotal-container">
                <p class="color-1">Spedizione</p>
                <p class="color-1"><%=spedizione%></p>
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
