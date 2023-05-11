package it.SpaceComix.model;

import java.util.Objects;

public class ProdottoCarrello {

    private ProductBean prodotto;
    private int quantita;


    public ProdottoCarrello()
    {

    }
    public ProdottoCarrello(ProductBean prodotto)
    {
        this.prodotto = prodotto;
        quantita=1;
    }
    public ProductBean getProdotto() {
        return prodotto;
    }

    public int getQuantita() {
        return quantita;
    }

    public void setProdotto(ProductBean prodotto) {
        this.prodotto = prodotto;
    }

    public void setQuantita(int quantita) {
        this.quantita = quantita;
    }



    @Override   //TWO PRODOTTOCARRELLO ARE EQUALS IF THEY ARE THE SAME PRODUCT (NOT THE SAME QUANTITY)
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProdottoCarrello that = (ProdottoCarrello) o;
        return Objects.equals(prodotto, that.prodotto);
    }

    @Override
    public int hashCode() {
        return Objects.hash(prodotto, quantita);
    }

    @Override
    public String toString() {
        return "ProdottoCarrello{" +
                "prodotto=" + prodotto +
                ", quantita=" + quantita +
                '}';
    }
}
