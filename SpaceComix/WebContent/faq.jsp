<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
	<meta charset="UTF-8">
	<title>SpaceComix</title>
	<%@include file="Header.jsp" %>
	<link rel="stylesheet" href="faq.css">
</head>
<body>
<div class="quadrato">

<div class="container">
	<h2> Hai bisogno di aiuto?</h2>
	<div class="accordion">
		<div class="accordion-item">
			<button id="accordion-button-1" aria-expanded="false"><span class="accordion-title">Quali sono i costi di spedizione?</span><span class="icon" aria-hidden="true"></span></button>
			<div class="accordion-content">
				<p>Le spese di spedizione dipendono dal peso e dalla destinazione del pacchetto. Durante il processo di checkout, potrai visualizzare le tariffe di spedizione applicate al tuo ordine.</p>
			</div>
		</div>
		<div class="accordion-item">
			<button id="accordion-button-2" aria-expanded="false"><span class="accordion-title">Quali sono le modalità di pagamento accettate?</span><span class="icon" aria-hidden="true"></span></button>
			<div class="accordion-content">
				<p>Accettiamo pagamenti tramite carta di credito, PayPal e bonifico bancario.</p>
			</div>
		</div>
		<div class="accordion-item">
			<button id="accordion-button-3" aria-expanded="false"><span class="accordion-title">Quanto tempo impiega la consegna?</span><span class="icon" aria-hidden="true"></span></button>
			<div class="accordion-content">
				<p> Il tempo di consegna dipende dalla tua posizione. In media, ci vogliono da 3 a 5 giorni lavorativi per le spedizioni nazionali.</p>
			</div>
		</div>
		<div class="accordion-item">
			<button id="accordion-button-4" aria-expanded="false"><span class="accordion-title">Cosa succede se il manga che cerco non è disponibile nel vostro negozio?</span><span class="icon" aria-hidden="true"></span></button>
			<div class="accordion-content">
				<p>Faremo del nostro meglio per fornire una vasta selezione di manga, ma potrebbe capitare che alcuni titoli non siano disponibili nel nostro negozio. Ti invitiamo a contattarci e faremo il possibile per aiutarti a trovare il manga che stai cercando.</p>
			</div>
		</div>
		<div class="accordion-item">
			<button id="accordion-button-5" aria-expanded="false"><span class="accordion-title">Avete una sezione dedicata ai manga usati o di seconda mano?</span><span class="icon" aria-hidden="true"></span></button>
			<div class="accordion-content">
				<p>Al momento non disponiamo di una sezione specifica per i manga usati o di seconda mano. Tuttavia, controlla regolarmente il nostro negozio, poiché potremmo offrire manga usati in futuro.</p>
			</div>
		</div>
	</div>
</div>
</div>
</body>
<%@include file="Footer.jsp" %>


<script>
	const items = document.querySelectorAll('.accordion button');

	function toggleAccordion() {
		const itemToggle = this.getAttribute('aria-expanded');

		for (i = 0; i < items.length; i++) {
			items[i].setAttribute('aria-expanded', 'false');
		}

		if (itemToggle == 'false') {
			this.setAttribute('aria-expanded', 'true');
		}
	}

	items.forEach((item) => item.addEventListener('click', toggleAccordion));
</script>
</html>