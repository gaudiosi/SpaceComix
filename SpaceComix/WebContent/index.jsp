<%@ page import="it.SpaceComix.model.ProductBean" %>
<%@ page import="java.util.Collection" %>
<%@ page import="it.SpaceComix.model.ProductDAO" %>
<%@ page import="java.util.Iterator" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="utf-8">
    <title>Homepage </title>
    <link rel="stylesheet" href="index.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

</head>
<%@include file="Header.jsp" %>

<body>
<%--
<div class="container2">
    <img src="Immagini/Banner_waifu2x_noise1_scale4x.png" alt="Your Image">
    <div class="fade-out"></div>
</div>--%>

<%
    ProductDAO dao = new ProductDAO();
    String order = "id DESC";
    Collection<ProductBean> listaProdotti = dao.doRetrieveAll(order);

%>



<%@include file="banner.jsp" %>

<%-- Slider Prodotti --%>
<section class="section shop" id="shop" aria-label="shop" data-section>
<div class="container">
    <div class="title-wrapper">
        <h2 class="h2 section-title">I migliori Shonen</h2>
        <a href="Catalogo.jsp?genere=shonen" class="btn-link">
            <span class="span">Vedi tutto</span>
            <ion-icon name="arrow-forward" aria-hidden="true"></ion-icon>
        </a>
    </div>
    <div class="wrapper">
        <i id="left" class="fa-solid fa-angle-left"></i>
        <div class="carousel">

            <%
                Iterator collection = listaProdotti.iterator();
                ProductBean prodotto = (ProductBean) collection.next();

                for (int i=0; i<9 && collection.hasNext(); i++, prodotto= (ProductBean) collection.next())
                {
            %>
            <img src="Immagini/<%=prodotto.getImage()%>" alt="<%=prodotto.getImage_alt()%>" data-id="<%=prodotto.getID()%>" />


            <%
                };%>

        </div>
        <i id="right" class="fa-solid fa-angle-right"></i>
    </div>
</div>
</section>

<%-- Slider Prodotti --%>
    <section class="section shop" id="shop" aria-label="shop" data-section>
        <div class="container">
            <div class="title-wrapper">
                <h2 class="h2 section-title">I migliori "..."</h2>
                <a href="#" class="btn-link">
                    <span class="span">Vedi tutto</span>
                    <ion-icon name="arrow-forward" aria-hidden="true"></ion-icon>
                </a>
            </div>
            <div class="wrapper">
                <i id="left" class="fa-solid fa-angle-left"></i>
                <div class="carousel">

                    <%
                        collection = listaProdotti.iterator();
                         prodotto = (ProductBean) collection.next();

                        for (int i=0; i<9 && collection.hasNext(); i++, prodotto= (ProductBean) collection.next())
                        {
                    %>
                    <img src="Immagini/<%=prodotto.getImage()%>" alt="<%=prodotto.getImage_alt()%>" data-id="<%=prodotto.getID()%>"  />


                    <%
                        };%>

                </div>
                <i id="right" class="fa-solid fa-angle-right"></i>
            </div>

        </div>
    </section>


</body>
<%@include file="Footer.jsp" %>

</html>
<script>
    const carousels = document.querySelectorAll(".carousel");

    carousels.forEach((carousel) => {
        const images = carousel.querySelectorAll("img");

        images.forEach((image) => {
            image.addEventListener("click", (event) => {
                const imageUrl = event.target.dataset.id;
                // Replace "customUrl" with your actual custom data attribute name
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

