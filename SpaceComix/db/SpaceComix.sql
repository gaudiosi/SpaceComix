drop schema if exists SpaceComix;
create schema SpaceComix;
use SpaceComix;

create table Cliente(
id int auto_increment,
username varchar(16) not NULL,
pass varchar(100) not NULL,
email varchar(50) not NULL unique,
ruolo varchar(12) not NULL default "guest" check(ruolo in ("admin", "guest")),
nome varchar(20) not NULL,
cognome varchar(20) not NULL,
primary key(id)
);

create table Prodotto(
id int auto_increment,
quantita int not NULL,
iva int not NULL,
prezzo decimal(6,2) not NULL,
titolo varchar(200) not NULL,
descrizione text not NULL,
autore varchar(50) default NULL,
editore varchar(50) not NULL,
isbn char(17) not NULL unique check(REGEXP_LIKE(isbn, '^978-[0-9]{1,5}-[0-9]{1,7}-[0-9]{1,6}-[0-9]{1}$')),
sconto int not NULL,
immagine varchar(100),
image_alt varchar(200) not NULL,
primary key(id)
);

create table Categoria(
nome varchar(50),
descrizione varchar(100) not NULL,
primary key(nome)
);

create table Indirizzo(
idUtente int,
cap varchar(5) not NULL,
citta varchar(20) not NULL,
via varchar(50) not NULL,
civico int not NULL,
primary key(idUtente),
foreign key (idUtente) references Cliente(id)
on delete cascade
on update cascade
);

create table Metodo_di_pagamento(
numCarta char(16),
idUtente int,
scadenza date,
cvc int,
intestatario varchar(50),
primary key(numCarta, scadenza, cvc, intestatario, idUtente),
foreign key (idUtente) references Cliente(id)
on delete cascade
on update cascade
);

create table Ordine(
id int auto_increment,
idUtente int,
telefono varchar(16) not NULL,
dataOrdine date not NULL,
primary key(id),
foreign key (idUtente) references Cliente(id)
on delete no action
on update no action
);

create table Wishlist(
idUtente int,
idProdotto int,
primary key (idUtente, idProdotto),
foreign key (idUtente) references Cliente(id)
on delete cascade
on update cascade,
foreign key (idProdotto) references Prodotto(id)
on delete cascade
on update cascade
);

create table Appartenenza(
idCategoria varchar(50),
idProdotto int,
primary key (idCategoria, idProdotto),
foreign key (idCategoria) references Categoria(nome)
on delete cascade
on update cascade,
foreign key (idProdotto) references Prodotto(id)
on delete cascade
on update cascade
);

create table Recensione(
testo varchar(50) not NULL,
stelle int not NULL,
idUtente int,
idProdotto int,
primary key(idUtente, idProdotto),
foreign key (idUtente) references Cliente(id)
on delete cascade
on update cascade,
foreign key (idProdotto) references Prodotto(id)
on delete cascade
on update cascade
);

create table Composizione(
idOrdine int,
idProdotto int,
prezzo_vendita int,
iva int,
quantita int,
primary key(idOrdine, idProdotto),
foreign key (idProdotto) references Prodotto(id)
on delete no action
on update no action,
foreign key (idOrdine) references Ordine(id)
on delete no action
on update no action
);
