package it.SpaceComix.model;

import java.util.ArrayList;
import java.util.List;

public class Carrello {

    private List<ProductBean> products;

    public Carrello() { products = new ArrayList<ProductBean>();}

    public void addProduct(ProductBean product) {products.add(product);}

    public void deleteProduct(ProductBean product) {
        for(ProductBean prod : products) {
            if(prod.getID() == product.getID()) {
                products.remove(prod);
                break;
            }
        }
    }

    public List<ProductBean> getProducts() {
        return  products;
    }
}
