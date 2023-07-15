<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>Pagina di Login</title>
	<link rel="stylesheet" href="style.css">
	<%@include file="Header.jsp" %>
</head>
<body>
	<div class="quadrato">
	<div>
	<p id = error></p>
    <h1>Login Page</h1>
    <form action="Login" method="post" class ="login">
    <div class = "ordine">
        <label for="email">Email:	</label>
        <input type="email" class="email" name="email" required><br>
        <div class = "password-container" >
        	<label for="password">Password:	</label>
        	<input type="password" class="password" name="password" required>
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

<script>
$(document).ready(function() {
    $(".login").submit(function(event) {
        event.preventDefault(); 
        
        var email = $(".email").val();
        var password = $(".password").val();
        
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
            	 document.getElementById('error').innerHTML = 'Credenziali non valide. Riprova.';          
            }
        });
    });
});
</script>
</body>
<%@include file="Footer.jsp" %>
</html>