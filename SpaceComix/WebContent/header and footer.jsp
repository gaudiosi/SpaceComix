<!DOCTYPE html>
<html>
  <head>
    <title>Navbar Example</title>
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
	<img src="../logo.svc" alt="Logo del sito" class="logo">
      <div>
        <button onclick="sito.html" class="navbar-button">Novità</button>
        <button onclick="sito.html" class="navbar-button">FAQ</button>
		<button onclick="sito.html" class="navbar-button">Carrello</button>
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