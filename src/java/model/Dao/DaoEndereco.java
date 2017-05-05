/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Dao;

import com.mysql.jdbc.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import model.Bean.BeanCep;
import model.Bean.BeanEndereco;

/**
 *
 * @author VaiDiegoo
 */
public class DaoEndereco {
    BeanCep cep = new BeanCep();
    BeanEndereco end = new BeanEndereco();
    
    PreparedStatement pstm;
    ResultSet rs;
    Connection con;
    
    public BeanCep buscarCep(BeanCep cep){
        
        return cep;
    }
}
