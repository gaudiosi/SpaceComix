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
	    private static final String UTENTE = "username";
	    private static final String PASS = "pass";
	    private static final String MAIL = "email";
	    private static final String ROLE = "ruolo";
	    private static final String NOME = "nome";
	    private static final String CNOME = "cognome";
	    
	    @Override
	    public synchronized void doSave(UserBean user) throws SQLException {

	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        String insertSQL = "INSERT INTO " + TABLE_NAME
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
	    public synchronized UserBean doRetrieveByKey(String email, String password) throws SQLException {
	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        UserBean bean = new UserBean();

	        String selectSQL = "SELECT * FROM cliente C WHERE C.email = ? AND C.pass = ?";

	        try {
	            connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(selectSQL);
	            preparedStatement.setString(1, email);
	            preparedStatement.setString(2, password);
	            
	            ResultSet rs = preparedStatement.executeQuery();
	            

	            if (rs.next()) {
	            	bean.setId(Integer.parseInt(rs.getString("id")));
	            	bean.setUsername(rs.getString(UTENTE));
	            	bean.setPassword(rs.getString(PASS));
	            	bean.setEmail(rs.getString(MAIL));
	            	bean.setRuolo(rs.getString(ROLE));
	            	bean.setNome(rs.getString(NOME));
	            	bean.setCognome(rs.getString(CNOME));	
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

	    public synchronized boolean doRetrieveByKey(String email) throws SQLException {
	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        UserBean bean = new UserBean();

	        String selectSQL = "SELECT * FROM cliente C WHERE C.email = ?";

	        try {
	            connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(selectSQL);
	            preparedStatement.setString(1, email);
	            
	            ResultSet rs = preparedStatement.executeQuery();
	            

	            if (rs.next()) {
	            	bean.setId(Integer.parseInt(rs.getString("id")));
	            	bean.setUsername(rs.getString(UTENTE));
	            	bean.setPassword(rs.getString(PASS));
	            	bean.setEmail(rs.getString(MAIL));
	            	bean.setRuolo(rs.getString(ROLE));
	            	bean.setNome(rs.getString(NOME));
	            	bean.setCognome(rs.getString(CNOME));	
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
	        if(bean.getUsername() != null)
	        	return true;
	        return false;
	    }
	    
		@Override
		public boolean doDelete(int code) throws SQLException {
			 Connection connection = null;
		        PreparedStatement preparedStatement = null;

		        int result = 0;

		        String deleteSQL = "DELETE FROM " + TABLE_NAME + " WHERE id = ?";

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


		                UserBean bean = new UserBean();

		                bean.setId(rs.getInt("id"));
		            	bean.setUsername(rs.getString(UTENTE));
		            	bean.setPassword(rs.getString(PASS));
		            	bean.setEmail(rs.getString(MAIL));
		            	bean.setRuolo(rs.getString(ROLE));
		            	bean.setNome(rs.getString(NOME));
		            	bean.setCognome(rs.getString(CNOME));
		               
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
			Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        UserBean bean = new UserBean();

	        String selectSQL = "SELECT * FROM "+ TABLE_NAME +" C WHERE C.id = ?";

	        try {
	            connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(selectSQL);
	            preparedStatement.setInt(1, code);
	            
	            ResultSet rs = preparedStatement.executeQuery();
	            
	            if (rs.next()) {
	            	bean.setId(Integer.parseInt(rs.getString("id")));
	            	bean.setUsername(rs.getString(UTENTE));
	            	bean.setPassword(rs.getString(PASS));
	            	bean.setEmail(rs.getString(MAIL));
	            	bean.setRuolo(rs.getString(ROLE));
	            	bean.setNome(rs.getString(NOME));
	            	bean.setCognome(rs.getString(CNOME));	
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
		
		public synchronized void doUpdate(UserBean user) throws SQLException {

	        Connection connection = null;
	        PreparedStatement preparedStatement = null;

	        String updateSQL = "UPDATE " + TABLE_NAME
	                + " SET username = ?, pass = ?, email = ?, nome = ?, cognome = ? WHERE id = ?";

	        try {
	            connection = ds.getConnection();
	            preparedStatement = connection.prepareStatement(updateSQL);
	            preparedStatement.setString(1, user.getUsername());
	            preparedStatement.setString(2, user.getPassword());
	            preparedStatement.setString(3, user.getEmail());
	            preparedStatement.setString(4,user.getNome());
	            preparedStatement.setString(5, user.getCognome());
	            preparedStatement.setInt(6, user.getId());

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
}