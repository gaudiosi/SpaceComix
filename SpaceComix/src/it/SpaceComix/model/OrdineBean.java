package it.SpaceComix.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

public class OrdineBean implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;

    private int idUtente;

    private String telefono;

    private Date dataOrdine;

    private ArrayList<ProductsOrdineBean> prodotti;

    public OrdineBean() {
        id = -1;
        idUtente = -1;
        telefono = "";
        dataOrdine = new Date();
        prodotti = new ArrayList<ProductsOrdineBean>();

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

    public ArrayList<ProductsOrdineBean> getProdotti() {
        return prodotti;
    }

    public void setProdotti(ArrayList<ProductsOrdineBean> prodotti) {
        this.prodotti = prodotti;
    }



    //vedere meglio come conviene implementare addProduct
    public void addProduct(ProductsOrdineBean prodotto)
    {
        //if(!prodotti.contains(prodotto))
        prodotti.add(prodotto);

    }

}
