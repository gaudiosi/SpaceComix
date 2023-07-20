package it.SpaceComix.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.Objects;

public class PagamentoBean implements Serializable {


    private String numCarta;
    private int idUtente;
    private Date scadenza;
    private int cvc;
    private String intestatario;

    public PagamentoBean(){
        numCarta="";
        idUtente = -1;
        scadenza = new Date(0,0,0) ;
        cvc = -1;
        intestatario = "";

    }

    public Date getScadenza() {
        return scadenza;
    }

    public void setCvc(int cvc) {
            this.cvc = cvc;
    }

    public int getCvc() {
        return cvc;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public String getIntestatario() {
        return intestatario;
    }

    public String getNumCarta() {
        return numCarta;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    public void setIntestatario(String intestatario) {
        this.intestatario = intestatario;
    }

    public void setNumCarta(String numCarta) {
        this.numCarta = numCarta;
    }

    public void setScadenza(Date scadenza) {
        this.scadenza = scadenza;
    }

    @Override
    public String toString() {
        return "PagamentoBean{" +
                "numCarta='" + numCarta + '\'' +
                ", idUtente=" + idUtente +
                ", scadenza=" + scadenza +
                ", cvc=" + cvc +
                ", intestatario='" + intestatario + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PagamentoBean that = (PagamentoBean) o;
        return idUtente == that.idUtente && cvc == that.cvc && numCarta.equals(that.numCarta) && intestatario.equals(that.intestatario);
    }

    @Override
    public int hashCode() {
        return Objects.hash(numCarta, idUtente, scadenza, cvc, intestatario);
    }

}
