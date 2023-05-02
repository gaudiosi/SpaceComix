<html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<head>
    <%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProdottoCarrello,it.SpaceComix.model.Carrello"%>


    <link href="carrello.css" rel="stylesheet" type="text/css">

    <meta charset="UTF-8">



</head>
<body>

<div class="container">
    <h1 class="title">Carrello</h1>
        <div class="mainContainer">
            <div class="rounded-container">
                <div class="card-container">
                    <img src="someurl" alt="some alt" class="card-image" />
                    <div class="product-container">
                        <div class="product-details">
                            <div class="product-description">
                                <h2 class="product-details"> PRODOTTO</h2>
                                <p class="product-info">INFO BREVI PRODOTTO</p>
                            </div>
                            <div class="custom-class">
                                <div class="flex-container">
                                    <div class="input-group">
                                        <span class="minus-btn">-</span>
                                        <input type="number" class="input-number" value="1" min="1" max="999">
                                        <span class="plus-btn">+</span>
                                    </div>



                                </div>


                            </div>
                        </div>

                    </div>




                </div>
            </div>

        </div>
</div>


</body>

</html>
