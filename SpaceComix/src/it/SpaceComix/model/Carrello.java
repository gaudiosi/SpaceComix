package it.SpaceComix.model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {

    private ArrayList <ProdottoCarrello> prodotti;

    public Carrello() { prodotti = new ArrayList<ProdottoCarrello>();}


    public void updateProdotto(ProductBean prodotto, int quantita)
    {
        if (quantita>0)
        {
            for(ProdottoCarrello temp: prodotti)
            {
                if(temp.getProdotto().equals(prodotto))
                {
                    temp.setQuantita(quantita);
                }
            }

        }

    }



    //Aggiunge un prodotto al carrello, se esiste già, aumenta la quantità
    public void addProdotto(ProductBean prodotto)
    {
        ProdottoCarrello temp = new ProdottoCarrello(prodotto);
        if(!prodotti.contains(temp))
        {
            prodotti.add(temp);

        }
        else
        {
            for(ProdottoCarrello temp1 : prodotti)
            {
                if( temp1.getProdotto().getID()==prodotto.getID())
                {
                    temp1.setQuantita(temp1.getQuantita()+1);
                    break;
                }
            }
        }

    }

    public void decreaseProdotto(ProductBean prodotto)
    {
        ProdottoCarrello temp = new ProdottoCarrello(prodotto);

        for(ProdottoCarrello temp1 : prodotti)
        {
            if(temp1.equals(temp))
            {
                temp1.setQuantita(temp1.getQuantita()-1);
                if (temp1.getQuantita()==0) prodotti.remove(temp1);
            }
        }

    }



    //se esiste il prodotto lo rimuove dal carrello
    public void removeProdotto(ProductBean prodotto)
    {
        ProdottoCarrello temp = new ProdottoCarrello(prodotto);
        if(prodotti.contains(temp))
        {
            prodotti.remove(temp);

        }
    }



    public ArrayList<ProdottoCarrello> getProducts() {
        return  prodotti;
    }
}
