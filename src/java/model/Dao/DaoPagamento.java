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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bean.BeanPagamento;

/**
 *
 * @author VaiDiegoo
 */
public class DaoPagamento extends BaseDao{
    
    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanPagamento> list;
    BeanPagamento pag = new BeanPagamento();
    
    public BeanPagamento findByCodigo(int codigo) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from pagamento where pag_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            pag = createPagamento(rs);
            return pag;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Pagamento não encontrado" + erro.getMessage());
            return null;
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
    
    public List<BeanPagamento> findAll() throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from pagamento p";
            pstm = con.prepareStatement(sql);
            rs = pstm.executeQuery();
            pag = createPagamento(rs);
            return list;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Pagamento não encontrado" + erro.getMessage());
            return null;
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
    
    private BeanPagamento createPagamento(ResultSet r) {
        try {
            list = new ArrayList<>();
            while (rs.next()) {
                System.out.println("RS: "+r.getInt("pag_codigo"));
                pag = new BeanPagamento();
                pag.setPag_codigo(r.getInt("pag_codigo"));
                pag.setPag_desc(r.getString("pag_desc"));
                //pagamento
                list.add(pag);
            }
            return pag;
        } catch (SQLException ex) {
            Logger.getLogger(DaoZona.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
}
