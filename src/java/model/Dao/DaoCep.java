/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Dao;

import java.awt.HeadlessException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bean.BeanCep;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoCep {
    
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanCep cep = new BeanCep();
    
    public BeanCep findByCodigo(int codigo) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from cep where cep_cep = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            cep = createBairro(rs);
            return cep;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Cep não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }       
    }
     
     private BeanCep createBairro(ResultSet r){
        try {
            while (rs.next()) {
                cep.setCep_cep(r.getString("cep_cep"));
                cep.setRua(r.getString("cep_rua")); 
                cep.setCep_bai_codigo(new DaoBairro().findByCodigo(r.getInt("cep_bai_codigo"))); 
            }
            return cep;
        } catch (SQLException ex) {
            Logger.getLogger(DaoCep.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
}
