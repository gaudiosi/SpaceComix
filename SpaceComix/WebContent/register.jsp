<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>SignIn Page</title>
	<link rel="stylesheet" href="style.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha384-vtXRMe3mGCbOeY7l30aIg8H9p3GdeSe4IFlP6G8JMa7o7lXvnz3GFKzPxzJdPfGK" crossorigin="anonymous"></script>
</head>
<%@include file="Header.jsp" %>
<body>
<div class="quadrato">
<div>
	<h1>Register Page</h1>
    <form id="registration-form" action="Signin" method="post" class="register" onsubmit="return validate();">
    <div class = "ordine">
    	<div class ="campi1">
    		<label for="text">Nome:	</label>
        	<input type="text" id="nome" name="nome" required>
        	<label for="text">Cognome:	</label>
        	<input type="text" id="cognome" name="cognome" required>
        </div>
        <br>
        <div class ="campi2">
        	<label for="text">Username:	</label>
        	<input type="text" id="username" name="username" required>
        	<label for="email">Email:	</label>
        	<input type="email" id="email" name="email" required><br>
        </div>
        <br>
        <div class = "password-container" >
        	<label for="password">Password:	</label>
        	<input type="password" id="password1" name="password1" required>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility('password1')">V</button>
 		</div>
 		<div class = "password-container" >
        	<label for="password">Conferma Password:	</label>
        	<input type="password" id="password2" name="password2" required>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility('password2')">V</button>
 		</div>
 	</div>
 		<br>
        	<div class="button-container">
        <div class="button-color">
        	<input type="submit" value="Registrati" class="button">
        </div>
        <div class="button-color">
        	<input type="reset" value="Reset" class="button">
        </div>
    </div>
    
  	</form>
  	 <% String error = (String) session.getAttribute("error");
       if (error != null) {
    	   out.print("<p class = \"error\">" + error + "</p>");
           session.setAttribute("error", null);
       }
    %>
  	<p id="error-message" class="error"></p>
</div>
</div>
<script>
function togglePasswordVisibility(pass) {
    var passwordField = document.getElementById(pass);
    if (passwordField.type === "password") {
        passwordField.type = "text";
    } else {
        passwordField.type = "password";
    }
}

function validate() {

	var error = "";
	var email = $("#email").val();
	var password1 =$("#password1").val();
	var password2 =$("#password2").val();
	var controllo = true;
	
	var emailRegex = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	if (!emailRegex.test(email)) {
		error += "L'email non rispetta la sua normale costruzione.\n";
		controllo = false;
	}
	
	if (!(password1 === password2)) {
		error += "Password non coincidenti.\n";
		controllo = false;
	}
	
	if (controllo === false){
		$("#error-message").text(error);
		return false;
	}
		
	
	$.ajax({
		url: "EmailAvailabilityServlet",
		method: "POST",
		data: { email: email },
		dataType: "json",
		async: false,
		success: function(response) {
			var result = response.result;
			if (result === true) {
				controllo = true;
			} else {
				$("#error-message").text("L'email è già registrata. Si prega di utilizzare un'altra email.");
				controllo = false;
			}
		},
		error: function() {
			$("#error-message").text("Si è verificato un errore nella richiesta. Si prega di riprovare.");
			controllo = false;
		}
	});
	return controllo;
};
</script>
</body>
<%@include file="Footer.jsp" %>
</html>