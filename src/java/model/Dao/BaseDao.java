/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Dao;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author VaiDiegoo
 */
public class BaseDao {
    
    
    public static Connection getConnection(){
        Connection con = null;
        con = model.Connection.Conexao.getConnection();               
        return con;
    }
    
}
