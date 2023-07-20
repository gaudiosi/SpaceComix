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

public class PagamentoDAO implements DAO<PagamentoBean>{

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

    private static final String TABLE_NAME = "Metodo_di_pagamento";

    @Override
    public synchronized void doSave(PagamentoBean pagamento) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + PagamentoDAO.TABLE_NAME
                + " (numCarta, idUtente,scadenza,cvc,intestatario) VALUES (?, ?, ?, ?, ?)";
        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, pagamento.getNumCarta());
            preparedStatement.setInt(2,pagamento.getIdUtente());
            preparedStatement.setDate(3,pagamento.getScadenza());
            preparedStatement.setInt(4,pagamento.getCvc());
            preparedStatement.setString(5, pagamento.getIntestatario());



            preparedStatement.executeUpdate();

            //salvare le categorie del prodotto



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


    public synchronized PagamentoBean doRetrieveByKey(String code) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        PagamentoBean bean = new PagamentoBean();

        String selectSQL = "SELECT * FROM " + PagamentoDAO.TABLE_NAME +
                "  WHERE numCarta LIKE ?";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);
            preparedStatement.setString(1,"%" + code + "%");

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {

                bean.setNumCarta(rs.getString("numCarta"));
                bean.setIdUtente(rs.getInt("idUtente"));
                bean.setScadenza(rs.getDate("scadenza"));
                bean.setCvc(rs.getInt("cvc"));
                bean.setIntestatario(rs.getString("intestatario"));


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

        String deleteSQL = "DELETE FROM " + PagamentoDAO.TABLE_NAME + " WHERE idUtente = ?";

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
    public PagamentoBean doRetrieveByKey(int code) throws SQLException {
        return null;
    }

    @Override
    public synchronized Collection<PagamentoBean> doRetrieveAll(String order) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        Collection<PagamentoBean> products = new LinkedList<PagamentoBean>();

        String selectSQL = "SELECT * FROM " + PagamentoDAO.TABLE_NAME;
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
                PagamentoBean bean = new PagamentoBean();


                bean.setNumCarta(rs.getString("numCarta"));
                bean.setIdUtente(rs.getInt("idUtente"));
                bean.setScadenza(rs.getDate("scadenza"));
                bean.setCvc(rs.getInt("cvc"));
                bean.setIntestatario(rs.getString("intestatario"));


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
    public void doUpdate(PagamentoBean temproudct) throws SQLException {

    }

    @Override
    public PagamentoBean doRetrieveByKey(String username, String password) throws SQLException {
        // TODO Auto-generated method stub
        return null;
    }


}