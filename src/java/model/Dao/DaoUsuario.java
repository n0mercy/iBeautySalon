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
    BeanUsuario usuario = new BeanUsuario();
    
     public BeanUsuario buscarUsuario(BeanUsuario usu) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from usuario inner join tipo_usuario on usu_tipo_codigo=tipo_codigo  where usu_status = ? and usu_email = ?";           
            usu.setUsu_status("Ativo");
            pstm = con.prepareStatement(sql);           
            pstm.setString(1, usu.getUsu_status());
            pstm.setString(2, usu.getUsu_email());
            rs = pstm.executeQuery();
            usuario = createUsuario(rs);
            return usuario;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Usuario não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }       
    }
     
     public BeanUsuario findByCodigo(int codigo) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from usuario inner join tipo_usuario on usu_tipo_codigo=tipo_codigo  where usu_codigo = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            usuario = createUsuario(rs);
            return usuario;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Usuario não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }        
    }
     
     private BeanUsuario createUsuario(ResultSet r){
        try {
            while (rs.next()) {
                usuario.setUsu_codigo(rs.getInt("usu_codigo"));
                usuario.setUsu_email(rs.getString("usu_email"));
                usuario.setUsu_senha(rs.getString("usu_senha"));
                usuario.setUsu_status("usu_status"); 
                usuario.setUsu_end_cep(new DaoEndereco().findByCodigo(rs.getInt("usu_end_cep")));
                usuario.setUsu_tipo_codigo(new DaoTipoUsuario().findByCodigo(rs.getInt("usu_tipo_codigo")));
            }
            return usuario;
        } catch (SQLException ex) {
            Logger.getLogger(DaoUsuario.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
    
}
