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
            preparedStatement.setFloat(3, product.getPrezzo());
            preparedStatement.setInt(4, product.getQuantita());
            preparedStatement.setInt(5, product.getIva());

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

    @Override
	public ComposizioneBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
        PreparedStatement preparedStatement = null;

        ComposizioneBean bean = new ComposizioneBean();

        String selectSQL = "SELECT * FROM"+ TABLE_NAME +" C WHERE C.idOrdine = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, code);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
            	bean.setIdOrdine(Integer.parseInt(rs.getString("idOrdine")));
            	bean.setIdProdotto(Integer.parseInt(rs.getString("idProdotto")));
            	bean.setPrezzo(Integer.parseInt(rs.getString("prezzo_vendita")));
            	bean.setIva(Integer.parseInt(rs.getString("iva")));
            	bean.setQuantita(Integer.parseInt(rs.getString("quantita")));
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
        return bean;
    }

	@Override
	public boolean doDelete(int code) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ComposizioneBean doRetrieveByKey(String username, String password) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<ComposizioneBean> doRetrieveAll(String order) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

   

	
}
