package it.SpaceComix.model;

import java.io.Serializable;
import java.util.ArrayList;

public class ProductBean implements Serializable {

    private static final long serialVersionUID = 1L;

    int id;

    int quantita;

    int iva;

    float prezzo;

    String titolo;

    String descrizione;
    
    String autore;
    
    String editore;
    
    String isbn;

    int sconto;

    String image;

    String image_alt;

    private ArrayList<CategoriaBean> generi;


    public ArrayList<CategoriaBean> getGeneri() {
        return generi;
    }

    public void setGeneri(ArrayList<CategoriaBean> generi) {
        this.generi = generi;
    }

    public void addCategoria(CategoriaBean categoria)
    {
        int contenuto = 0;
        for (CategoriaBean cat : generi)
        {
            if (cat.equals(categoria))
            {
                contenuto = 1;
                break;
            }
        }
        if(contenuto==0) generi.add(categoria);

    }

    public ProductBean() {
        id = -1;
        titolo = "";
        descrizione = "";
        generi = new ArrayList<CategoriaBean>();

    }

    public int getID() {
    	return id; 
    }

    public void setID(int code) {
    	this.id = code;
    }

    public int getIva() {
        return iva;
    }

    public void setIva(int iva) {
        this.iva = iva;
    }

    public int getSconto() {
        return sconto;
    }

    public void setSconto(int sconto) {
        this.sconto = sconto;
    }



    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String description) {
        this.descrizione = description;
    }

    public float getPrezzo() {
        return prezzo;
    }

    public void setPrezzo(float prezzo) {
        this.prezzo = prezzo;
    }

    public int getQuantita() {return quantita;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getImage() {
        return image;
    }

    public String getImage_alt() {
        return image_alt;
    }

    public void setImage_alt(String image_alt) {
        this.image_alt = image_alt;
    }

    public String getAutore() {
		return autore;
	}

	public void setAutore(String autore) {
		this.autore = autore;
	}

	public String getEditore() {
		return editore;
	}

	public void setEditore(String editore) {
		this.editore = editore;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	@Override
    public String toString() {
        return titolo + " (" + id + "), " + prezzo + " " + quantita + ". " + descrizione;
    }


}
