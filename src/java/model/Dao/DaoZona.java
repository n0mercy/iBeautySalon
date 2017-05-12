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
import model.Bean.BeanZona;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoZona {
    
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanZona zona = new BeanZona();
    
    public BeanZona findByCodigo(int codigo) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from zona where zona_cod = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            zona = createZona(rs);
            return zona;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Zona não cadastrada" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }       
    }
     
     private BeanZona createZona(ResultSet r){
        try {
            while (rs.next()) {
                zona.setZona_cod(r.getInt("zona_cod"));
                zona.setZona_nome(r.getString("zona_nome")); 
            }
            return zona;
        } catch (SQLException ex) {
            Logger.getLogger(DaoZona.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
    
}
