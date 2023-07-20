package it.SpaceComix.model;

import java.io.Serializable;

public class ComposizioneBean implements Serializable {

    private static final long serialVersionUID = 1L;

    int idOrdine;
    
    int idProdotto;
    
    int quantita;

    int iva;

    float prezzo;




    public ComposizioneBean() {
        idOrdine = -1;
        idProdotto = -1;
        quantita = -1;

        iva = -1;

        prezzo = -1;



    }

    public int getIdOrdine() {
    	return idOrdine; 
    }

    public void setIdOrdine(int id) {
    	this.idOrdine = id;
    }

    public int getIdProdotto() {
    	return idProdotto; 
    }

    public void setIdProdotto(int id) {
    	this.idProdotto = id;
    }

    public int getIva() {
        return iva;
    }

    public void setIva(int iva) {
        this.iva = iva;
    }

    public float getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(float prezzo) {
        this.prezzo = prezzo;
    }

    public int getQuantita() {
    	return quantita;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }


	

        
    }