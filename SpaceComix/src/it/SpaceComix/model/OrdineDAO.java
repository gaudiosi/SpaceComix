package it.SpaceComix.model;

import java.sql.*;
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

	@Override
	public synchronized void doSave(OrdineBean product) throws SQLException,NullPointerException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + OrdineDAO.TABLE_NAME
				+ " (idUtente, telefono, dataOrdine, numCarta, indirizzo) VALUES (?, ?, ?, ?, ?)";
		String insert2SQL = "INSERT INTO Composizione (prezzo_vendita,iva, quantita, idOrdine, idProdotto) VALUES (?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setInt(1, product.getIdUtente());
			preparedStatement.setString(2, product.getTelefono());
			preparedStatement.setDate(3, product.getDataOrdine());
			preparedStatement.setString(4, product.getNumCarta());
			preparedStatement.setString(5, product.getIndirizzo());



			preparedStatement.executeUpdate();


			if(product.getProdotti().size()>0)
			{
				ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
				int InsertedId = -1;
				if (generatedKeys.next()) {
					InsertedId = generatedKeys.getInt(1);
				}


				try (PreparedStatement preparedStatement2 = connection.prepareStatement(insert2SQL)) {
					for (ProductOrdineBean prod : product.getProdotti())
					{
						preparedStatement2.setFloat(1, prod.getPrezzo_vendita());
						preparedStatement2.setInt(2, prod.getIva());
						preparedStatement2.setInt(3, prod.getQuantita());
						preparedStatement2.setInt(4, InsertedId);
						preparedStatement2.setInt(5, prod.getIdProdotto());



						preparedStatement2.addBatch();

					}
					preparedStatement2.executeBatch();
				}

			}


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
	public synchronized boolean doDelete(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + OrdineDAO.TABLE_NAME + " WHERE id = ?";

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

	public synchronized OrdineBean doRetrieveByKey(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		OrdineBean bean = new OrdineBean();

		String selectSQL = "SELECT * FROM " + TABLE_NAME +
				" AS O LEFT JOIN Composizione AS C ON O.id = C.idOrdine" +
				" LEFT JOIN Prodotto AS P ON C.idProdotto=P.id WHERE O.id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				bean.setIdUtente(rs.getInt("idUtente"));
				bean.setTelefono(rs.getString("telefono"));
				bean.setDataOrdine(rs.getDate("dataOrdine"));
				bean.setNumCarta(rs.getString("numCarta"));
				bean.setIndirizzo((rs.getString("indirizzo")));
				bean.setId(rs.getInt("id"));

				if(rs.getString("C.idOrdine") != null)
				{
					do {

						ProductOrdineBean p = new ProductOrdineBean();
						p.setTitolo(rs.getString("P.titolo"));
						p.setPrezzo_vendita(rs.getInt("C.prezzo_vendita"));
						p.setIdProdotto(rs.getInt("C.idProdotto"));
						p.setQuantita(rs.getInt("C.quantita"));
						p.setIva(rs.getInt("C.iva"));

						bean.addProductOrdine(p);

					} while (rs.next());

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
		return bean;
	}

	@Override
	public synchronized Collection<OrdineBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<OrdineBean> products = new LinkedList<OrdineBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME +
				" AS O LEFT JOIN Composizione AS C ON O.id = C.idOrdine" +
				" LEFT JOIN Prodotto AS P ON C.idProdotto=P.id";

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

			while (currentnext) {       //Finché esiste una riga corrente crea un nuovo prodotto


				OrdineBean bean = new OrdineBean();

				bean.setIdUtente(rs.getInt("idUtente"));
				bean.setTelefono(rs.getString("telefono"));
				bean.setDataOrdine(rs.getDate("dataOrdine"));
				bean.setNumCarta(rs.getString("numCarta"));
				bean.setIndirizzo((rs.getString("indirizzo")));
				bean.setId(rs.getInt("O.id"));

				products.add(bean);

				if(rs.getString("C.idOrdine") != null)
				{
					do {  //Crea una nuova categoria
						ProductOrdineBean p = new ProductOrdineBean();
						p.setTitolo(rs.getString("P.titolo"));
						p.setPrezzo_vendita(rs.getInt("C.prezzo_vendita"));
						p.setIdProdotto(rs.getInt("C.idProdotto"));
						p.setQuantita(rs.getInt("C.quantita"));
						p.setIva(rs.getInt("C.iva"));

						bean.addProductOrdine(p);
						currentnext = rs.next();
					} while(currentnext && rs.getInt("idOrdine")== bean.getId());
					//FinchÃ© la nuova riga corrente ha lo stesso ordine
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

	public synchronized Collection<OrdineBean> doRetrievebyUser(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<OrdineBean> products = new LinkedList<OrdineBean>();

		String selectSQL = "SELECT * FROM " + TABLE_NAME +
				" AS O LEFT JOIN Composizione AS C ON O.id = C.idOrdine" +
				" LEFT JOIN Prodotto AS P ON C.idProdotto=P.id WHERE O.idUtente=?";



		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);


			ResultSet rs = preparedStatement.executeQuery();

			boolean currentnext = rs.next();

			while (currentnext) {       //Finché esiste una riga corrente crea un nuovo prodotto


				OrdineBean bean = new OrdineBean();

				bean.setIdUtente(rs.getInt("idUtente"));
				bean.setTelefono(rs.getString("telefono"));
				bean.setDataOrdine(rs.getDate("dataOrdine"));
				bean.setNumCarta(rs.getString("numCarta"));
				bean.setIndirizzo((rs.getString("indirizzo")));
				bean.setId(rs.getInt("O.id"));

				products.add(bean);

				if(rs.getString("C.idOrdine") != null)
				{
					do {  //Crea una nuova categoria
						ProductOrdineBean p = new ProductOrdineBean();
						p.setTitolo(rs.getString("P.titolo"));
						p.setPrezzo_vendita(rs.getInt("C.prezzo_vendita"));
						p.setIdProdotto(rs.getInt("C.idProdotto"));
						p.setQuantita(rs.getInt("C.quantita"));
						p.setIva(rs.getInt("C.iva"));

						bean.addProductOrdine(p);
						currentnext = rs.next();
					} while(currentnext && rs.getInt("idOrdine")== bean.getId());
					//FinchÃ© la nuova riga corrente ha lo stesso ordine
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

	@Override
	public OrdineBean doRetrieveByKey(String code, String code1) throws SQLException {
		return null;
	}

	
	
	
}