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
import model.Bean.BeanBairro;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoBairro {
    Connection con = Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanBairro bairro = new BeanBairro();
    
    public BeanBairro findByCodigo(int codigo) throws SQLException{      
         try{           
            con = Conexao.getConnection();          
            String sql="select * from bairro where bai_codigo = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            bairro = createBairro(rs);
            return bairro;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Bairro não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }        
    }
     
     private BeanBairro createBairro(ResultSet r){
        try {
            while (rs.next()) {
                bairro.setBai_codigo(r.getInt("bai_codigo"));
                bairro.setBai_nome(r.getString("bai_nome")); 
                bairro.setBai_zona_cod(new DaoZona().findByCodigo(r.getInt("bai_zona_cod"))); 
            }
            return bairro;
        } catch (SQLException ex) {
            Logger.getLogger(DaoBairro.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
}
