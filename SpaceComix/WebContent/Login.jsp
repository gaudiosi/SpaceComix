<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>Pagina di Login</title>
	<link rel="stylesheet" href="style.css">
	<%@include file="Header.jsp"%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div class="quadrato">
	<div>
    <h1>Login Page</h1>
    <form action="Login" method="post" class ="login" id ="login">
    <div class = "ordine">
        <label for="email">Email:	</label>
        <input type="email" id="email" class="email" name="email" required><br>
        <div class = "password-container" >
        	<label for="password">Password:	</label>
        	<input type="password" id="password" class="password" name="password" required>
        	<button type="button" class = "toggle-password" onclick="togglePasswordVisibility('password')">V</button>
 		</div>
 		<br>
 	</div>
 	<div class="button-container">
        <div class="button-color">
        	<input type="submit" value="Login" class="button">
        </div>
        <div class="button-color">
        	<input type="reset" value="Reset" class="button">
        </div>
    </div>
  	</form>
  		<p id = "error" class = "error"></p>
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

$(document).ready(function() {
    $(".login").submit(function(event) {
        event.preventDefault();
        
        var email = $("#email").val();
        var password = $("#password").val();
        
        var emailRegex = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
    	if (!emailRegex.test(email)) {
    		$("#error").text("L'email non rispetta la sua normale costruzione.");
    		return;
    	}
        
        $.ajax({
            type: "POST",
            url: "Login",
            data: {
                email: email,
                password: password
            },
    		success: function(response) {
   				window.location.href = 'index.jsp';
            },
            error: function(xhr, status, error) {
                if (xhr.status === 500) {
                    $("#error").text("Errore interno del server. Si prega di riprovare più tardi.");
                } else {
                	$("#error").text("Email o password invalidi. Si prega di riprovare.");
                }
            }
        });
    });
});
</script>
</body>
<%@include file="Footer.jsp" %>
</html>