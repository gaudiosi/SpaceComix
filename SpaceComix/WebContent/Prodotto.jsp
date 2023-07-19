<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="it">

<%@ page contentType="text/html; charset=UTF-8" import="java.util.*,it.SpaceComix.model.ProductDAO,it.SpaceComix.model.ProductBean"%>

<head>
    <meta charset="UTF-8">
    <link href="Prodotto.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">




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
              <%
                  if (user != null) {
                      if (user.getRuolo().equals("admin")) {
                         %>
              <form action="<%=request.getContextPath()%>/AddProduct" method="get">
                  <input type="hidden" name="id" value="<%=prodotto.getID()%>">
                  <button class="button" name="action" value="modifica" type="submit">
                  <svg class="svg-icon" fill="none" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><g stroke="#a649da" stroke-linecap="round" stroke-width="2"><path d="m20 20h-16"></path><path clip-rule="evenodd" d="m14.5858 4.41422c.781-.78105 2.0474-.78105 2.8284 0 .7811.78105.7811 2.04738 0 2.82843l-8.28322 8.28325-3.03046.202.20203-3.0304z" fill-rule="evenodd"></path></g></svg>
                  <span class="lable">Edit</span>
              </button>
              </form>
              <form action="<%=request.getContextPath()%>/AddProduct" method="post">
                  <input type="hidden" name="id" value="<%=prodotto.getID()%>">
                  <button class="button" name="action" value="delete" type="submit" id="button2">
                      <svg class="svg-icon" fill="none" height="24" viewBox="0 0 24 24" width="43" xmlns="http://www.w3.org/2000/svg"><g stroke="#c93a07" stroke-linecap="round" stroke-width="2"><path d="M6 7V18C6 19.1046 6.89543 20 8 20H16C17.1046 20 18 19.1046 18 18V7M6 7H5M6 7H8M18 7H19M18 7H16M10 11V16M14 11V16M8 7V5C8 3.89543 8.89543 3 10 3H14C15.1046 3 16 3.89543 16 5V7M8 7H16" fill-rule="evenodd"></path></g></svg>
                      <span class="lable1">Rimuovi</span>
                  </button>
              </form>


              <%
                      }

                  }
              %>
              <div class="container-2">
                  <img src="Immagini/<%= prodotto.getImage() %>" alt="<%= prodotto.getImage_alt() %>" class="product-img" type="image/svg+xml">
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

      <%--Prodotti simili--%>

      <section class="section shop" id="shop" aria-label="shop" data-section>
          <div class="container">
              <div class="title-wrapper">
                  <h2 class="h2 section-title">Prodotti simili</h2>
                  <a href="Catalogo.jsp" class="btn-link">
                      <span class="span">Vedi altro</span>
                      <ion-icon name="arrow-forward" aria-hidden="true"></ion-icon>
                  </a>
              </div>
              <div class="wrapper">
                  <i id="left" class="fa-solid fa-angle-left"></i>
                  <div class="carousel">

                      <%
                          Collection<ProductBean> prodotti = (Collection<ProductBean>) request.getSession().getAttribute("simili");
                          Iterator collection = prodotti.iterator();

                          ProductBean temp = (ProductBean) collection.next();

                          for (int i=0; i<10 && collection.hasNext(); i++, temp= (ProductBean) collection.next())
                          {
                              if(!prodotto.equals(temp))
                              {
                      %>
                      <img src="Immagini/<%=temp.getImage()%>" alt="<%=temp.getImage_alt()%>" data-id="<%=temp.getID()%>"  />


                      <%
                              }
                          }%>

                  </div>
                  <i id="right" class="fa-solid fa-angle-right"></i>
              </div>

          </div>
      </section>

<%
    }
%>

</body>
<%@include file="Footer.jsp" %>

<script>
    const carousels = document.querySelectorAll(".carousel");

    carousels.forEach((carousel) => {
        const images = carousel.querySelectorAll("img");

        images.forEach((image) => {
            image.addEventListener("click", (event) => {
                const imageUrl = event.target.dataset.id;
                if (imageUrl) {
                    let adress = "Prodotto?id=";
                    window.location.href = adress.concat(imageUrl); // Redirect to the custom URL
                }
            });
        });




        const firstImg = carousel.querySelector("img");
        const arrowIcons = carousel.parentElement.querySelectorAll(".wrapper i");

        const showHideIcons = () => {
            let scrollWidth = carousel.scrollWidth - carousel.clientWidth;
            arrowIcons[0].style.display = carousel.scrollLeft == 0 ? "none" : "block";
            arrowIcons[1].style.display = carousel.scrollLeft == scrollWidth ? "none" : "block";
        };

        arrowIcons.forEach((icon) => {
            icon.addEventListener("click", () => {
                let firstImgWidth = firstImg.clientWidth + 14;
                carousel.scrollLeft += icon.id == "left" ? -firstImgWidth : firstImgWidth;
                setTimeout(() => showHideIcons(), 60);
            });
        });

        const autoSlide = () => {
            if (
                carousel.scrollLeft - (carousel.scrollWidth - carousel.clientWidth) > -1 ||
                carousel.scrollLeft <= 0
            )
                return;
        };

        carousel.addEventListener("mousedown", (e) => {
            if (e.target.tagName !== "IMG") {
                e.preventDefault();
            }
        });

        carousel.addEventListener("touchstart", (e) => {
            if (e.target.tagName !== "IMG") {
                e.preventDefault();
            }
        });
    });

</script>


<%--  Freccia SLider Prodotti--%>
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>


</html>