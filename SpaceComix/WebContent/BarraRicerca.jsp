<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <meta charset="UTF-8">
<style>
* {
  box-sizing: border-box;
}

body {
  font: 16px Arial;  
}

/*the container must be positioned relative:*/
.autocomplete {
  position: relative;
  display: inline-block;
}

input:not(#login):not(#login *):not(#registration-form):not(#registration-form *):not(#profile):not(#profile *) {
  border: 1px solid transparent;
  background-color: #f1f1f1;
  padding: 10px;
  font-size: 16px;
}

input[type=text]:not(#login):not(#login *):not(#registration-form):not(#registration-form *):not(#profile):not(#profile *) {
  background-color: #f1f1f1;
  width: 100%;
}

input[type=submit]:not(#login):not(#login *):not(#registration-form):not(#registration-form *):not(#profile):not(#profile *) {
  background-color: DodgerBlue;
  color: #fff;
  cursor: pointer;
}

.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  /*position the autocomplete items to be the same width as the container:*/
  top: 100%;
  left: 0;
  right: 0;
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff; 
  border-bottom: 1px solid #d4d4d4; 
}

.autocomplete-items div:hover {
  background-color: #e9e9e9; 
}

.autocomplete-active {
  background-color: DodgerBlue !important; 
  color: #ffffff; 
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>     
<body>
<form id="ricerca" autocomplete="off" action="Cerca">
  <div class="autocomplete" style="width:300px;">
    <input id="myInput" type="text" name="myCountry">
  </div>
  <input type="submit">
</form>

<script>
function autocomplete(inp, arr) {
  var currentFocus;
  inp.addEventListener("input", function(e) {
      var a, b, i, val = this.value;
      closeAllLists();
      if (!val) { return false;}
      currentFocus = -1;
      a = document.createElement("DIV");
      a.setAttribute("id", this.id + "autocomplete-list");
      a.setAttribute("class", "autocomplete-items");
      this.parentNode.appendChild(a);
      for (i = 0; i < arr.length; i++) {
        if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {
          b = document.createElement("DIV");
          b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
          b.innerHTML += arr[i].substr(val.length);
          b.innerHTML += "<input class='suggerimenti' type='hidden' value='" + arr[i] + "'>";
          b.addEventListener("click", function(e) {
              inp.value = this.getElementsByTagName("input")[0].value;
              closeAllLists();
          });
          a.appendChild(b);
        }
      }
  });
  inp.addEventListener("keydown", function(e) {
      var x = document.getElementById(this.id + "autocomplete-list");
      if (x) x = x.getElementsByTagName("div");
      if (e.keyCode == 40) {
        currentFocus++;
        addActive(x);
      } else if (e.keyCode == 38) { //up
        currentFocus--;
        addActive(x);
      } else if (e.keyCode == 13) {
        e.preventDefault();
        if (currentFocus > -1) {
          if (x) x[currentFocus].click();
        }
      }
  });
  function addActive(x) {
    if (!x) return false;
    removeActive(x);
    if (currentFocus >= x.length) currentFocus = 0;
    if (currentFocus < 0) currentFocus = (x.length - 1);
    x[currentFocus].classList.add("autocomplete-active");
  }
  function removeActive(x) {
    for (var i = 0; i < x.length; i++) {
      x[i].classList.remove("autocomplete-active");
    }
  }
  function closeAllLists(elmnt) {
    var x = document.getElementsByClassName("autocomplete-items");
    for (var i = 0; i < x.length; i++) {
      if (elmnt != x[i] && elmnt != inp) {
        x[i].parentNode.removeChild(x[i]);
      }
    }
  }
  document.addEventListener("click", function (e) {
      closeAllLists(e.target);
  });
}

$(document).ready(function() {
	 $.ajax({
		    url: 'GetProdotti',
		    type: 'POST',
		    dataType: 'json',
		    success: function(data) {
		      var titoli= [];
		      for (var i = 0; i < data.prodotti.length; i++) {
		          var prodotto = data.prodotti[i];
		          
		          titoli.push(prodotto.titolo);
		      }
		      
		  	  autocomplete(document.getElementById("myInput"), titoli);
			}
	 });
});
</script>
</body>