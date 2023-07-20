package it.SpaceComix.model;

import java.io.Serializable;
import java.util.Objects;

public class ProductOrdineBean implements Serializable {
    private float prezzo_vendita;
    private int iva;
    private int quantita;
    private int idProdotto;

    private String titolo;

    public ProductOrdineBean() {
        prezzo_vendita = -1;
        iva = -1;
        quantita = -1;
        idProdotto = -1;
    }



    public float getPrezzo_vendita() {
        return prezzo_vendita;
    }


    public int getIva() {
        return iva;
    }

    public void setIva(int iva) {
        this.iva = iva;
    }

    public int getQuantita() {
        return quantita;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }



    public int getIdProdotto() {
        return idProdotto;
    }

    public void setIdProdotto(int idProdotto) {
        this.idProdotto = idProdotto;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setPrezzo_vendita(float prezzo_vendita) {
        this.prezzo_vendita = prezzo_vendita;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    @Override
    public String toString() {
        return "ProductOrdineBean{" +
                "prezzo_vendita=" + prezzo_vendita +
                ", iva=" + iva +
                ", quantita=" + quantita +
                ", idProdotto=" + idProdotto +
                ", titolo='" + titolo + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductOrdineBean that = (ProductOrdineBean) o;
        return prezzo_vendita == that.prezzo_vendita && iva == that.iva && quantita == that.quantita && idProdotto == that.idProdotto;
    }

    @Override
    public int hashCode() {
        return Objects.hash(prezzo_vendita, iva, quantita, idProdotto, titolo);
    }
}
