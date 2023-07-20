package it.SpaceComix.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.sql.Date;
import it.SpaceComix.model.ProductOrdineBean;

public class OrdineBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;

    private int idUtente;

    private String telefono;

    private Date dataOrdine;

    private String indirizzo;
    private String numCarta;

    private ArrayList<ProductOrdineBean> prodotti;

    public OrdineBean() {
        id = -1;
        idUtente = -1;
        telefono = "";
        dataOrdine = new Date(0,0,0);
        prodotti = new ArrayList<ProductOrdineBean>();
        indirizzo= "";
        numCarta ="";


    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public Date getDataOrdine() {
        return dataOrdine;
    }

    public void setDataOrdine(Date dataOrdine) {
        this.dataOrdine = dataOrdine;
    }

    public ArrayList<ProductOrdineBean> getProdotti() {
        return prodotti;
    }

    public void setProdotti(ArrayList<ProductOrdineBean> prodotti) {
        this.prodotti = prodotti;
    }

    public void setNumCarta(String numCarta) {
        this.numCarta = numCarta;
    }

    public String getNumCarta() {
        return numCarta;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public void addProductOrdine(ProductOrdineBean prod)
    {
        int contenuto = 0;

      for (ProductOrdineBean cat : prodotti)
        {
            if (cat.equals(prod))
            {
                contenuto = 1;
                break;
            }
        }
        if(contenuto==0) prodotti.add(prod);

    }

}
