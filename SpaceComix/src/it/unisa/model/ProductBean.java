package it.unisa.model;

import java.io.Serializable;

public class ProductBean implements Serializable {

    private static final long serialVersionUID = 1L;

    int id;

    String titolo;

    String descrizione;

    int prezzo;

    int quantita;

    public ProductBean() {
        id = -1;
        titolo = "";
        descrizione = "";

    }

    public int getID() { return id; }

    public void setID(int code) {
        this.id = code;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String name) {
        this.titolo = titolo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String description) {
        this.descrizione = description;
    }

    public int getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(int prezzo) {
        this.prezzo = prezzo;
    }

    public int getQuantita() {return quantita;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }

    @Override
    public String toString() {
        return titolo + " (" + id + "), " + prezzo + " " + quantita + ". " + descrizione;
    }


}
