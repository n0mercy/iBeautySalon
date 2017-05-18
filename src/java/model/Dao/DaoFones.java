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
import model.Bean.BeanFones;
import model.Bean.BeanUsuario;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoFones {
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    
    BeanFones fone = new BeanFones();
    BeanUsuario user = new BeanUsuario();
    DaoUsuario userDao = new DaoUsuario();
    
    public BeanFones findByUser(int codigo) throws SQLException{      
         try{                              
            con=Conexao.getConnection();          
            StringBuilder sb = new StringBuilder();
            sb.append("select * from fones where fone_usu_codigo = ?");            
            pstm = con.prepareStatement(sb.toString());           
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            fone = createFone(rs);
            return fone;                     
        }catch(SQLException | HeadlessException erro){
            System.out.println("Fone não encontrado" +erro.getMessage());            
            return null;
        }finally{
             con.close();
             rs.close();
             pstm.close();
         }        
    }
     
     private BeanFones createFone(ResultSet r){
        try {
            while (r.next()) {
                fone.setFon_fones(r.getString("fon_fones"));
                user = userDao.findByCodigo(r.getInt("fone_usu_codigo"));
                fone.setFon_usu_cod(user);
            }
            return fone;
        } catch (SQLException ex) {
            Logger.getLogger(DaoFones.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
     
     public void save(BeanFones fone, boolean update) throws SQLException {
        try {
            if (!update) {
                pstm = con.prepareStatement("insert into fones(fon_fones, fone_usu_codigo) values (?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                pstm = con.prepareStatement("update fones set fon_fones = ?, fone_usu_codigo = ? where fone_usu_codigo = ?");
            }
            
            pstm.setString(1, fone.getFon_fones());
            pstm.setInt(2, fone.getFon_usu_cod().getUsu_codigo());
            if (update)//update
            {
                pstm.setInt(3, fone.getFon_usu_cod().getUsu_codigo());
            }

            int count = pstm.executeUpdate();
            
            if (count == 0) {
                throw new SQLException("Erro ao salvar telefone");
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
