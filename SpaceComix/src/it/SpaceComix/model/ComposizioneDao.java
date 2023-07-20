package it.SpaceComix.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ComposizioneDao implements DAO<ComposizioneBean> {

    private static DataSource ds;

    static {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");

            ds = (DataSource) envCtx.lookup("jdbc/SpaceComix");

        } catch (NamingException e) {
            System.out.println("Error:" + e.getMessage());
        }
    }

    private static final String TABLE_NAME = "Composizione";

    @Override
    public synchronized void doSave(ComposizioneBean product) throws SQLException,NullPointerException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + ComposizioneDao.TABLE_NAME
                + " (idOrdine, idProdotto, prezzo_vendita, quantita, iva) VALUES (?, ?, ?, ?, ?)";

        try {
            connection = ds.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, product.getIdOrdine());
            preparedStatement.setInt(2, product.getIdProdotto());            
            preparedStatement.setInt(3, product.getPrezzo());
            preparedStatement.setInt(4, product.getQuantita());
            preparedStatement.setFloat(5, product.getIva());

            preparedStatement.executeUpdate();


            connection.commit();

        } finally {
            try {
            	if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
    }

    public synchronized Collection<ProductBean> doRetrieveByKey(String code) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        Collection<ProductBean> products = new LinkedList<ProductBean>();

        String selectSQL = "SELECT * FROM " + TABLE_NAME +
                " AS P LEFT JOIN Appartenenza AS A ON P.id = A.idProdotto" +
                " LEFT JOIN Categoria AS C ON A.idCategoria=C.nome WHERE P.titolo LIKE ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1,"%" + code + "%");

            ResultSet rs = preparedStatement.executeQuery();

            boolean currentnext = rs.next();

            while (currentnext) {       //Finché esiste una riga corrente crea un nuovo prodotto


                ProductBean bean = new ProductBean();

                bean.setID(rs.getInt("id"));
                bean.setQuantita(rs.getInt("quantita"));
                bean.setIva(rs.getInt("iva"));
                bean.setPrezzo(rs.getFloat("prezzo"));
                bean.setTitolo(rs.getString("titolo"));
                bean.setDescrizione(rs.getString("descrizione"));
                bean.setAutore(rs.getString("autore"));
                bean.setEditore(rs.getString("editore"));
                bean.setIsbn(rs.getString("isbn"));
                bean.setSconto(rs.getInt("sconto"));
                bean.setImage(rs.getString("immagine"));
                bean.setImage_alt(rs.getString("image_alt"));

                products.add(bean);

                if(rs.getString("C.nome") != null)
                {
                    do {  //Crea una nuova categoria
                        CategoriaBean c = new CategoriaBean();
                        c.setNome(rs.getString("C.nome"));
                        c.setDescrizione(rs.getString("C.descrizione"));
                        bean.addCategoria(c);
                        currentnext = rs.next();
                    } while(currentnext && rs.getInt("id")== bean.getID());
                    //FinchÃ© la nuova riga corrente ha lo stesso prodotto
                }
                else {
                    currentnext = rs.next();
                }

            }

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }
        
        return products;
    }

   

	
}
