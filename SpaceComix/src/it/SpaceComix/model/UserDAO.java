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

public class UserDAO implements DAO<UserBean> {

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
	    
	    private static final String TABLE_NAME = "cliente";
	    
	    @Override
	    public synchronized void doSave(UserBean user) throws SQLException {

	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        String insertSQL = "INSERT INTO " + UserDAO.TABLE_NAME
	                + " (username, pass, email, nome, cognome) VALUES (?, ?, ?, ?, ?)";

	        try {
	            connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(insertSQL);
	            preparedStatement.setString(1, user.getUsername());
	            preparedStatement.setString(2, user.getPassword());
	            preparedStatement.setString(3, user.getEmail());
	            preparedStatement.setString(4,user.getNome());
	            preparedStatement.setString(5, user.getCognome());


	            preparedStatement.executeUpdate();

	            //salvare le categorie del prodotto



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
	    public synchronized UserBean doRetrieveByKey(String username, String password) throws SQLException {
	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        UserBean bean = new UserBean();

	        String selectSQL = "SELECT * FROM " + UserDAO.TABLE_NAME + "AS C WHERE C.username = ? AND C.pass=?";

	        try {
	            connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(selectSQL);
	            preparedStatement.setString(1, username);
	            preparedStatement.setString(2, password);
	            

	            ResultSet rs = preparedStatement.executeQuery();

	            if (rs.next()) {
	            	bean.setId(rs.getInt("id"));
	            	bean.setUsername(rs.getString("username"));
	            	bean.setPassword(rs.getString("pass"));
	            	bean.setEmail(rs.getString("email"));
	            	bean.setRuolo(rs.getString("ruolo"));
	            	bean.setNome(rs.getString("nome"));
	            	bean.setCognome(rs.getString("cognome"));	
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
			 Connection connection = null;
		        PreparedStatement preparedStatement = null;

		        int result = 0;

		        String deleteSQL = "DELETE FROM " + UserDAO.TABLE_NAME + " WHERE id = ?";

		        try {
		            connection = ds.getConnection();
		            preparedStatement = connection.prepareStatement(deleteSQL);
		            preparedStatement.setInt(1, code);

		            result = preparedStatement.executeUpdate();

		        } finally {
		            try {
		                if (preparedStatement != null)
		                    preparedStatement.close();
		            } finally {
		                if (connection != null)
		                    connection.close();
		            }
		        }
		        return (result != 0);
		    }

		@Override
		public Collection<UserBean> doRetrieveAll(String order) throws SQLException {
			 Connection connection = null;
		        PreparedStatement preparedStatement = null;

		        Collection<UserBean> users = new LinkedList<UserBean>();

		        String selectSQL = "SELECT * FROM " + UserDAO.TABLE_NAME;

		        if (order != null && !order.equals("")) {
		            selectSQL += " ORDER BY " + order;
		        }

		        try {
		            connection = ds.getConnection();
		            preparedStatement = connection.prepareStatement(selectSQL);

		            ResultSet rs = preparedStatement.executeQuery();

		            boolean currentnext = rs.next();

		            while (currentnext) {       //Finché esiste una riga corrente crea un nuovo prodotto


		                UserBean bean = new UserBean();

		                bean.setId(rs.getInt("id"));
		            	bean.setUsername(rs.getString("username"));
		            	bean.setPassword(rs.getString("pass"));
		            	bean.setEmail(rs.getString("email"));
		            	bean.setRuolo(rs.getString("ruolo"));
		            	bean.setNome(rs.getString("nome"));
		            	bean.setCognome(rs.getString("cognome"));
		               
		                users.add(bean);
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
		        return users;
		    }

		@Override
		public UserBean doRetrieveByKey(int code) throws SQLException {
			// TODO Auto-generated method stub
			return null;
		}

	}