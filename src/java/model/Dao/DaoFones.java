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
import model.Bean.BeanFones;
import model.Bean.BeanUsuario;

/**
 *
 * @author VaiDiegoo
 */
public class DaoFones extends BaseDao{
    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    
    BeanFones fone = new BeanFones();
    BeanUsuario usuario = new BeanUsuario();
    DaoUsuario userDao = new DaoUsuario();
    
    public BeanFones findByUser(int codigo) throws SQLException{      
        con = getConnection();
        try{        
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
     
     private BeanFones createFone(ResultSet r){
        try {
            while (r.next()) {
                fone.setFon_fones(r.getString("fon_fones"));
                usuario = userDao.findByCodigo(r.getInt("fone_usu_codigo"));
                fone.setFon_usu_cod(usuario);
            }
            return fone;
        } catch (SQLException ex) {
            Logger.getLogger(DaoFones.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
     
     public void save(BeanFones fone, boolean update) throws SQLException {
        con = getConnection();
         try {
            if (!update) {
                System.out.println("INSERT FONE");
                pstm = con.prepareStatement("insert into fones(fon_fones, fone_usu_codigo) values (?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                System.out.println("UPDATE FONE");
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
