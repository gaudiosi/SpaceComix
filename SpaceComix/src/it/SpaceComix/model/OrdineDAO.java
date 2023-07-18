package it.SpaceComix.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.util.Date;

public class OrdineDAO implements DAO<OrdineBean> {
	

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
    
    private static final String TABLE_NAME = "ordine";
    private static final String UTENTE = "idUtente";
    private static final String DATA = "dataOrdine";
    private static final String TELEFONO = "telefono";
    Date data = new Date();
    
    @Override
    public synchronized void doSave(OrdineBean order) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + TABLE_NAME
                + " (idUtente, dataOrdine, telefono) VALUES (?, ?, ?)";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setInt(1, order.getIdUtente());
            preparedStatement.setDate(2, (java.sql.Date) data);
            preparedStatement.setString(3, order.getTelefono());
            preparedStatement.executeUpdate();

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
	public OrdineBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
        PreparedStatement preparedStatement = null;

        OrdineBean bean = new OrdineBean();

        String selectSQL = "SELECT * FROM"+ TABLE_NAME +"C WHERE C.id = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, code);
            
            ResultSet rs = preparedStatement.executeQuery();
            
            if (rs.next()) {
            	bean.setId(Integer.parseInt(rs.getString("id")));
            	bean.setIdUtente(Integer.parseInt(rs.getString(UTENTE)));
            	bean.setDataOrdine(rs.getDate(DATA));
            	bean.setTelefono(rs.getString(TELEFONO));
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
	public Collection<OrdineBean> doRetrieveAll(String order) throws SQLException {
		 Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        Collection<OrdineBean> ordini = new LinkedList<OrdineBean>();

	        String selectSQL = "SELECT * FROM " + TABLE_NAME;
	        if (order != null && !order.equals("")) {
	            selectSQL += " ORDER BY ?";
	        }

	        try {
	            connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(selectSQL);
	            
	            if (order != null && !order.equals("")) {
	                preparedStatement.setString(1, order);
	            }

	            ResultSet rs = preparedStatement.executeQuery();

	            boolean currentnext = rs.next();

	            while (currentnext) {


	                OrdineBean bean = new OrdineBean();

	            	bean.setId(Integer.parseInt(rs.getString("id")));
	            	bean.setIdUtente(Integer.parseInt(rs.getString(UTENTE)));
	            	bean.setDataOrdine(rs.getDate(DATA));
	            	bean.setTelefono(rs.getString(TELEFONO));
	               
	                ordini.add(bean);
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
	        return ordini;
	    }

	@Override
	public boolean doDelete(int code) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public OrdineBean doRetrieveByKey(String username, String password) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
}