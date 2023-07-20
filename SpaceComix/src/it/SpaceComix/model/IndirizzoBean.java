package it.SpaceComix.model;

import java.io.Serializable;
import java.util.Objects;

public class IndirizzoBean implements Serializable {

    private String cap;
    private String citta;
    private String via;
    private int civico;
    private int idUtente;

    public IndirizzoBean() {
        cap = "";
        citta = "";
        via = "";
        civico = -1;
        idUtente = -1;
    }

    // Getters and Setters (you can generate them automatically in most IDEs)
    public String getCap() {
        return cap;
    }

    public void setCap(String cap) {
        this.cap = cap;
    }

    public String getCitta() {
        return citta;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public String getVia() {
        return via;
    }

    public void setVia(String via) {
        this.via = via;
    }

    public int getCivico() {
        return civico;
    }

    public void setCivico(int civico) {
        this.civico = civico;
    }

    public int getIdUtente() {
        return idUtente;
    }

    public void setIdUtente(int idUtente) {
        this.idUtente = idUtente;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        IndirizzoBean that = (IndirizzoBean) o;
        return civico == that.civico && idUtente == that.idUtente && Objects.equals(cap, that.cap) && Objects.equals(citta, that.citta) && Objects.equals(via, that.via);
    }


    @Override
    public int hashCode() {
        return Objects.hash(cap, citta, via, civico, idUtente);
    }

    @Override
    public String toString() {
        return "IndirizzoBean{" +
                "cap='" + cap + '\'' +
                ", citta='" + citta + '\'' +
                ", via='" + via + '\'' +
                ", civico=" + civico +
                ", idUtente=" + idUtente +
                '}';
    }
}
