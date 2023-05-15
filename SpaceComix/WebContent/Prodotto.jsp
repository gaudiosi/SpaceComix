<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="it">

<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProductDAO,it.SpaceComix.model.ProductBean"%>

<head>
    <meta charset="UTF-8">
    <link href="Prodotto.css" rel="stylesheet" type="text/css">
    
    <%
        ProductBean prodotto =(ProductBean) request.getAttribute("prodotto");


    %>
    <title><%=(String)prodotto.getTitolo()%></title>
    
    
    <%@include file="Header.jsp" %>
    
</head>

<body>



      <%
          if(prodotto!=null)
          {

      %>
      <section class="container-0">
          <div class="container-1">
              <div class="container-2">
                  <img src="Immagini/<%= prodotto.getImage() %>" alt="<%= prodotto.getImage_alt() %>" class="product-img">
                  <div class="container-nome-voto-autore">
                      <h2 class="autore"><%=prodotto.getAutore()%></h2>
                      <h1 class="nome"><%=prodotto.getTitolo()%></h1>
                      <% /*IF Prodotto.getRecensioni().size()!=0 Mostra le stelle*/%>
                      <div class="voto">
                          <span class="stelle">
                               <svg fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="stella" viewBox="0 0 24 24">
                                   <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path>
                               </svg>
                              <svg fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="stella" viewBox="0 0 24 24">
                                  <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path>
                              </svg>
                              <svg fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="stella" viewBox="0 0 24 24">
                                  <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path>
                              </svg>
                              <svg fill="currentColor" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="stella" viewBox="0 0 24 24">
                                  <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path>
                              </svg>
                              <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="stella" viewBox="0 0 24 24">
                                  <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path>
                              </svg>
                              <span id="numrecensioni">4 Reviews</span>
                          </span>
                      </div>
                      <%%>
                      <p class="descrizione"><%=prodotto.getDescrizione()%></p>
                      <hr class="my-horizontal-line">
                      <div class="prezzo-carrello-wish">
                          <span class="prezzo"><%= String.format("%.2f",prodotto.getPrezzo())%>€</span>
                          <form action="<%=request.getContextPath()%>/carrello" method="post">
                              <input type="hidden" name="action" value="add">
                              <input type="hidden" name="id" value="<%=prodotto.getID()%>">
                              <button type="submit" class="carrello" >
                              <svg aria-hidden="true" fill: currentColor; viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z"></path></svg>
                                  Aggiungi al carrello
                              </button>

                          </form>
                      </div>
                  </div>
              </div>
          </div>
      </section>

<%
    }
%>
   





</body>
<%@include file="Footer.jsp" %>
</html>