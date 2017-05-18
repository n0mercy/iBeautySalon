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
import model.Bean.BeanTipoUsuario;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoTipoUsuario {
    
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanTipoUsuario tipo = new BeanTipoUsuario();
    
    public BeanTipoUsuario findByCodigo(int codigo) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from tipo_usuario where tipo_codigo = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            tipo = createZona(rs);
            return tipo;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Tipo não cadastrada" +erro.getMessage());            
            return null;
        } finally{
             con.close();
             rs.close();
             pstm.close();
         }       
    }        
     
     private BeanTipoUsuario createZona(ResultSet r){
        try {
            while (rs.next()) {
                tipo.setTipo_codigo(rs.getInt("tipo_codigo"));
                tipo.setTipo_desc(rs.getString("tipo_desc")); 
            }
            return tipo;
        } catch (SQLException ex) {
            Logger.getLogger(DaoTipoUsuario.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
}
