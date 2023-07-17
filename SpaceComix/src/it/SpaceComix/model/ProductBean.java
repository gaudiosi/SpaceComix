package it.SpaceComix.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Objects;

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
        quantita = -1;

        iva = -1;

        prezzo = -1;

        titolo = "";

        descrizione = "";

        autore= "";

        editore = "";

        isbn="";

        sconto=-1;

        image="";

        image_alt="";


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
	
	public String stringify(){
		int i = 0;
		String json = "{";
		json += "\"id\":" + this.id + ",";
		json += "\"quantita\":" + this.quantita + ",";
		json += "\"iva\":" + this.iva + ",";
		json += "\"prezzo\":" + this.prezzo + ",";
		json += "\"titolo\":\"" + this.titolo + "\",";
		json += "\"descrizione\":\"" + this.descrizione + "\",";
		json += "\"autore\":\"" + this.autore + "\",";
		json += "\"editore\":\"" + this.editore + "\",";
		json += "\"isbn\":\"" + this.isbn + "\",";
		json += "\"sconto\":" + this.sconto + ",";
		json += "\"image\":\"" + this.image + "\",";
		json += "\"image_alt\":\"" + this.image_alt + "\",";
		json += "\"generi\":[";
		for(CategoriaBean c :generi) {
			if(i == 0) {
				json += c.stringify();
			} else {
				json += "," + c.stringify();
			}
			i++;
		}
		
		return json;
	 }

	@Override
    public String toString() {
        return titolo + " (" + id + "), " + prezzo + " " + quantita + ". " + descrizione;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductBean that = (ProductBean) o;
        return id == that.id && quantita == that.quantita && iva == that.iva && Float.compare(that.prezzo, prezzo) == 0 && sconto == that.sconto && titolo.equals(that.titolo) && descrizione.equals(that.descrizione) && autore.equals(that.autore) && editore.equals(that.editore) && isbn.equals(that.isbn) && image.equals(that.image) && image_alt.equals(that.image_alt) && generi.equals(that.generi);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, quantita, iva, prezzo, titolo, descrizione, autore, editore, isbn, sconto, image, image_alt, generi);
    }
    
    public int appartieneAGenere(String genere) {
        for(CategoriaBean categoria : generi) {
        	if(categoria.getNome().equals(genere)) {
        		return 1;
        	}
        }
        return 0;
    }
        
    }