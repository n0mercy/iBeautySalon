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
import model.Bean.BeanUsuario;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoUsuario {
    
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    
     public void buscarUsuario(BeanUsuario usu){      
         try{           
           con=Conexao.getConnection();          
           String sql=" usu_email, tipo_desc from usuario inner join tipo_usuario on usu_tipo_codigo=tipo_codigo  where usu_status =? and usu_senha=? and usu_email = ?";           
           usu.setUsu_status("Ativo");
            pstm = con.prepareStatement(sql);           
            pstm.setString(1, usu.getUsu_status());
            pstm.setString(2, usu.getUsu_senha());
            pstm.setString(3, usu.getUsu_email());
            pstm.executeQuery();                
            System.out.println("Usuario encontrado com sucesso"+sql);                      
        }catch(SQLException | HeadlessException erro){
            System.out.println("Usuario não cadastrado" +erro.getMessage());            
        }       
    }
    
}
