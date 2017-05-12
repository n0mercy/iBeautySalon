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
import model.Bean.BeanEmpresa;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoEmpresa {
    
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanEmpresa emp = new BeanEmpresa();
    
    public BeanEmpresa findByCnpj(String cnpj) throws SQLException{      
         try{           
            con=Conexao.getConnection();          
            String sql="select * from empresa_usuario where emp_cnpj = ?";            
            pstm = con.prepareStatement(sql);           
            pstm.setString(1, cnpj);
            rs = pstm.executeQuery();
            emp = createEmpresa(rs);
            return emp;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Cep não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }        
    }
     
     private BeanEmpresa createEmpresa(ResultSet r){
        try {
            while (rs.next()) {
                emp.setEmp_cnpj(rs.getString("emp_cnpj"));
                emp.setEmp_insc_estadual(rs.getString("emp_insc_estadual")); 
                emp.setEmp_razao(rs.getString("emp_razao")); 
                emp.setEmp_usu_codigo(new DaoUsuario().findByCodigo(rs.getInt("emp_usu_codigo")));
            }
            return emp;
        } catch (SQLException ex) {
            Logger.getLogger(DaoEmpresa.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
}
