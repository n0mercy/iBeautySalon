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
import model.Bean.BeanEndereco;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoEndereco {    
    BeanEndereco end = new BeanEndereco();
    PreparedStatement pstm;
    ResultSet rs;
    Connection con;
    
    public BeanEndereco findByCodigo(int codigo) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from endereco where end_codigo = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            end = createEndereco(rs);
            return end;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Endereço não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }        
    }
    
    public BeanEndereco findByCep(String cep) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from endereco where end_cep = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setString(1, cep);
            rs = pstm.executeQuery();
            end = createEndereco(rs);
            return end;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Endereço não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }        
    }
     
     private BeanEndereco createEndereco(ResultSet r){
        try {
            while (r.next()) {
                end.setEnd_codigo(r.getInt("end_codigo"));
                end.setEnd_compl(r.getString("end_compl")); 
                end.setEnd_ref(r.getString("end_ref"));
                end.setEnd_num(r.getString("end_num"));  
                end.setEnd_cep(new DaoCep().findByCodigo(rs.getInt("end_cep"))); 
            }
            return end;
        } catch (SQLException ex) {
            Logger.getLogger(DaoEndereco.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
}
