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
import java.sql.Statement;
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
    
    public BeanCep findByCodigo(String codigo) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from cep where cep_cep = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setString(1, codigo);
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
     
     public void save(BeanCep cep, boolean up) throws SQLException {
        try {
            if (!up) {
                pstm = con.prepareStatement("insert into cep(cep_cep,cep_rua,cep_bai_codigo) values (?,?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                pstm = con.prepareStatement("update cep set cep_cep = ?, cep_rua = ?, cep_bai_codigo = ? where cep_cep = ?");
            }
            
            pstm.setString(1, cep.getCep_cep());
            pstm.setString(2, cep.getRua());
            pstm.setInt(3, cep.getCep_bai_codigo().getBai_codigo());
            if (up)//update
            {
                pstm.setString(4, cep.getCep_cep());
            }

            int count = pstm.executeUpdate();
            
            if (count == 0) {
                throw new SQLException("Erro ao inserir o cep");
            }
            
        } finally {
            if (pstm != null) {
                pstm.close();
            }

            if (con != null) {
                con.close();
            }

            if (rs != null) {
                rs.close();
            }
        }
    }
}
