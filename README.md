# SpaceComix

Sito e-commerce di manga e fumetti scritto in Tomcat con database MySQL.
## Funzionalità del sito

### Funzionalità lato guest
L'utente non registrato (guest) avrà la possibilità di:
- Visualizzare il catalogo
- Visualizzare il dettaglio di un prodotto
- Aggiungere e rimuovere dal carrello elementi
- Registrarsi/fare il log-in
- Ricercare fumetti e manga per le categorie sopra elencate
- La registrazione è richiesta per la finalizzazione dell'acquisto e verrà esplicitamente richiesta solo in questa fase. Naturalmente non potrà vedere gli ordini effettuati, in quanto non potrà averne completati.

### Funzionalità lato utente registrato
L'utente registrato avrà accesso alle stesse funzioni del guest con l'aggiunta della possibilità di:
- Aggiungere e rimuovere elementi alla lista dei desideri
- Finalizzare un acquisto
- Richiedere la fattura e scaricarla
- Visualizzare la lista degli ordini effettuati
- Modificare le informazioni utente (indirizzo di spedizione, nome, cognome, e-mail, metodo di pagamento, password)
- Inserire feedback su prodotti acquistati.

### Funzionalità lato amministrativo
Dal punto di vista dell'amministratore, il sito permetterà:
- L'aggiunta, la modifica e l'eliminazione degli articoli presenti sul sito. Questo significa che l'admin del sito non necessiterà di conoscenze di programmazione informatica, in quanto potrà avvalersi di questa interfaccia (naturalmente non accessibile agli utenti comuni) per gestire l'e-commerce.
- Gestione ordini (obbligatorio: l'amministratore visualizza gli ordini per data, per cliente)
- Possibilità di moderare i feedback (cancellarli/nasconderli).

### Team Member
> [gaudiosi](https://github.com/gaudiosi), [NewJoker1999](https://github.com/NewJoker1999), [sasibasi](https://github.com/sasibasi)
