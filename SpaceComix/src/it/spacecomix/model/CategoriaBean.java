package it.spacecomix.model;

import java.util.Objects;

public class CategoriaBean {

    private String nome;
    private String descrizione;


    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescrizone() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public CategoriaBean()
    {
        nome= "";
        descrizione= "";
    }

    public CategoriaBean(String nome, String descrizone) {
        this.nome = nome;
        this.descrizione = descrizone;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CategoriaBean that = (CategoriaBean) o;
        return Objects.equals(nome, that.nome) && Objects.equals(descrizione, that.descrizione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, descrizione);
    }

    @Override
    public String toString() {
        return "CategoriaBean{" +
                "nome='" + nome + '\'' +
                ", descrizone='" + descrizione + '\'' +
                '}';
    }

}
