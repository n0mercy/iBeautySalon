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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bean.BeanCupom;
import model.Bean.BeanZona;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoCupom {
    
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanCupom> list;
    BeanCupom cupom = new BeanCupom();
    
    public void save(BeanCupom cupom) throws SQLException {
        try {
            if (cupom.getCupom_codigo() == 0) {
                System.out.println("INSERT CUPOM");
                pstm = con.prepareStatement("insert into cupom(cupom_status, cupom_data, cupom_dtvalidade, cupom_clicpf, cupom_pag_codigo) values (?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                System.out.println("UPDATE CUPOM");
                pstm = con.prepareStatement("update cupom set cupom_status = ?, cupom_data = ?, cupom_dtvalidade = ?, cupom_clicpf = ?, cupom_pag_codigo = ? where cupom_codigo = ?");
            }

            pstm.setString(1, cupom.getCupom_status());
            pstm.setDate(2, new java.sql.Date(cupom.getCupom_data().getTime()));
            pstm.setDate(3, new java.sql.Date(cupom.getCupom_validade().getTime()));
            pstm.setString(4, cupom.getCupom_clicpf().getCli_cpf());
            pstm.setInt(5, cupom.getCupom_pag_cod().getPag_codigo());
            if (cupom.getCupom_codigo() > 0)//update
            {
                pstm.setLong(6, cupom.getCupom_codigo());
            }

            int count = pstm.executeUpdate();
            
            if (count == 0) {
                throw new SQLException("Erro ao inserir o cupom");
            }

            if (cupom.getCupom_codigo()== 0) {
                cupom.setCupom_codigo(getGeneratedId(pstm));
            }
        } finally {
            if (pstm != null) {
                pstm.close();
            }

            if (con != null) {
                con.close();
            }

        }
    }

    public static int getGeneratedId(Statement stmt) throws SQLException {
        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            int id = rs.getInt(1);
            return id;
        }
        return 0;
    }
    
    public BeanCupom findByCodigo(int codigo) throws SQLException {
        try {
            con = Conexao.getConnection();
            String sql = "select * from cupom where cupom_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            cupom = createCupom(rs);
            return cupom;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Cupom não encontrado" + erro.getMessage());
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
    
    private BeanCupom createCupom(ResultSet r) {
        try {
            list = new ArrayList<>();
            while (rs.next()) {
                cupom = new BeanCupom();
                cupom.setCupom_codigo(r.getInt("cupom_codigo"));
                cupom.setCupom_status(r.getString("cupom_status"));
                cupom.setCupom_data(r.getDate("cupom_data"));
                cupom.setCupom_validade(r.getDate("cupom_dtvalidade"));
                cupom.setCupom_clicpf(new DaoCliente().findByCpf(r.getString("cupom_clicpf")));
                cupom.setCupom_pag_codigo(new DaoPagamento().findByCodigo(rs.getInt("cupom_pag_codigo")));
                list.add(cupom);
            }
            return cupom;
        } catch (SQLException ex) {
            Logger.getLogger(DaoZona.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
    
}
