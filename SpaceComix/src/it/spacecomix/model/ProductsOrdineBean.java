package it.spacecomix.model;

import java.util.Objects;

public class ProductsOrdineBean {

    private int idOrdine;
    private int idProdotto;

    private int prezzo;

    private int iva;

    private int quantita;


    public ProductsOrdineBean() {
        idOrdine = -1;
        idProdotto = -1;
        prezzo = -1;
        iva = 4;

    }

    public int getIdOrdine() {
        return idOrdine;
    }

    public int getIdProdotto() {
        return idProdotto;
    }

    public int getPrezzo() {
        return prezzo;
    }

    public int getIva() {
        return iva;
    }

    public void setIdOrdine(int idOrdine) {
        this.idOrdine = idOrdine;
    }

    public void setIdProdotto(int idProdotto) {
        this.idProdotto = idProdotto;
    }

    public void setPrezzo(int prezzo) {
        this.prezzo = prezzo;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductsOrdineBean that = (ProductsOrdineBean) o;
        return idOrdine == that.idOrdine && idProdotto == that.idProdotto && prezzo == that.prezzo && iva == that.iva;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idOrdine, idProdotto, prezzo, iva);
    }

    @Override
    public String toString() {
        return "ProductsOrdineBean{" +
                "idOrdine=" + idOrdine +
                ", idProdotto=" + idProdotto +
                ", prezzo=" + prezzo +
                ", iva=" + iva +
                '}';
    }
}
