package it.SpaceComix.model;

import java.sql.SQLException;
import java.util.Collection;

public interface DAO<T> {
    public void doSave(T product) throws SQLException;

    public boolean doDelete(int code) throws SQLException;

    public T doRetrieveByKey(int code) throws SQLException;
    
    public T doRetrieveByKey(String username, String password) throws SQLException;

    public Collection<T> doRetrieveAll(String order) throws SQLException;

    void doUpdate(T temproudct) throws SQLException;
}
