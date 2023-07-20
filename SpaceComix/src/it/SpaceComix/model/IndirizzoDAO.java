package it.SpaceComix.model;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

public class IndirizzoDAO implements DAO<IndirizzoBean>{

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

    private static final String TABLE_NAME = "Indirizzo";

    @Override
    public synchronized void doSave(IndirizzoBean indirizzo) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + IndirizzoDAO.TABLE_NAME
                + " (cap, citta, via, civico, idUtente) VALUES (?, ?, ?, ?, ?)";
        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, indirizzo.getCap());
            preparedStatement.setString(2, indirizzo.getCitta());
            preparedStatement.setString(3, indirizzo.getVia());
            preparedStatement.setInt(4,indirizzo.getCivico());
            preparedStatement.setInt(5,indirizzo.getIdUtente());





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
    public synchronized IndirizzoBean doRetrieveByKey(int code) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        IndirizzoBean bean = new IndirizzoBean();

        String selectSQL = "SELECT * FROM " + IndirizzoDAO.TABLE_NAME +
                "  WHERE idUtente = ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setInt(1, code);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {

                bean.setCap(rs.getString("cap"));
                bean.setCitta(rs.getString("citta"));
                bean.setVia(rs.getString("via"));
                bean.setCivico(rs.getInt("civico"));
                bean.setIdUtente(rs.getInt("idUtente"));



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
    public synchronized boolean doDelete(int code) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        int result = 0;

        String deleteSQL = "DELETE FROM " + IndirizzoDAO.TABLE_NAME + " WHERE idUtente = ?";

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
    public synchronized Collection<IndirizzoBean> doRetrieveAll(String order) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        Collection<IndirizzoBean> products = new LinkedList<IndirizzoBean>();

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

            while (rs.next()) {
                IndirizzoBean bean = new IndirizzoBean();


                bean.setCap(rs.getString("cap"));
                bean.setCitta(rs.getString("citta"));
                bean.setVia(rs.getString("via"));
                bean.setCivico(rs.getInt("civico"));
                bean.setIdUtente(rs.getInt("idUtente"));



                products.add(bean);
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
    public IndirizzoBean doRetrieveByKey(String username, String password) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }


}
