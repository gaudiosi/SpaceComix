<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
  <head>
    <meta charset="ISO-8859-1">
    <title>NAVBAR AND FOOTER</title>
    <style>
	
      body {
        margin: 0;
        padding: 0;
        height: 100%;
      }


      .navbar {
        background-color: #333;
        color: #fff;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px;
      }


      .logo img {
		max-width: 100%; 
		height: auto;
	  }


      .navbar-button {
        background-color: #fff;
        color: #333;
        border: none;
        padding: 7px 17px;
        font-size: 16px;
        cursor: pointer;
        margin-left: 10px;
      }


      .footer {
        background-color: #333;
        color: #fff;
        padding: 10px;
        text-align: center;
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
      }
    </style>
  </head>
  <body>
    <nav class="navbar">
	<img src="../logo.png" alt="Logo del sito" class="logo">
      <div>
        <button onclick="../novita.jsp" class="navbar-button">Novità</button>
        <button onclick="../faq.jsp" class="navbar-button">FAQ</button>
		<button onclick="../carrello.jsp" class="navbar-button">Carrello</button>
		<%String name = (String) session.getAttribute("user");
			       if (name != null) {
			           out.print("<button onclick=\"profilo.jsp\" class=\"navbar-button\">" + Profilo + "</button>");
			           out.print("<form action=\"Logout\" method=\"get\" > " +
			        		     "<input type=\"submit\" value=\"Logout\"/>" +
			           "</form> ");
			       } else {
			    	   out.print("<button onclick=\"Login.jsp\" class=\"navbar-button\">" + Login + "</button>" +
			   				"<button onclick=\"register.jsp\" class=\"navbar-button\">" + Register + "</button>");
			       }
			    %>
      </div>
	  <!-- METTERE IL CODICE QUI -->
    <footer class="footer">
      &copy; 2023 SpaceComix, by Primo Vinicio Calabrese, Gabriele Gaudiosi, Salvatore Basilicata
    </footer>
  </body>
</html>
