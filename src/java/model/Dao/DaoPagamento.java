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
import model.Bean.BeanCupom;
import model.Bean.BeanPagamento;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoPagamento {
    
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanPagamento> list;
    BeanPagamento pag = new BeanPagamento();
    
    public BeanPagamento findByCodigo(int codigo) throws SQLException {
        try {
            con = Conexao.getConnection();
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
    
    private BeanPagamento createPagamento(ResultSet r) {
        try {
            list = new ArrayList<>();
            while (rs.next()) {
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
