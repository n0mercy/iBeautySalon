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
import model.Bean.BeanEndereco;

/**
 *
 * @author VaiDiegoo
 */
public class DaoEndereco extends BaseDao {

    BeanEndereco end = new BeanEndereco();
    PreparedStatement pstm;
    ResultSet rs;
    Connection con;

    public BeanEndereco findByCodigo(int codigo) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from endereco where end_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            end = createEndereco(rs);
            return end;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Endereço não encontrado" + erro.getMessage());
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

    public BeanEndereco findByCep(String cep) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from endereco where end_cep = ?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, cep);
            rs = pstm.executeQuery();
            end = createEndereco(rs);
            return end;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Endereço não encontrado" + erro.getMessage());
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

    private BeanEndereco createEndereco(ResultSet r) {
        try {
            while (r.next()) {
                end.setEnd_codigo(r.getInt("end_codigo"));
                end.setEnd_ref(r.getString("end_ref"));
                end.setEnd_num(r.getString("end_num"));
                end.setEnd_cep(new DaoCep().findByCodigo(rs.getString("end_cep")));
            }
            return end;
        } catch (SQLException ex) {
            Logger.getLogger(DaoEndereco.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void save(BeanEndereco end) throws SQLException {
        con = getConnection();
        try {
            if (end.getEnd_codigo() == 0) {
                System.out.println("INSERT Endereco");
                pstm = con.prepareStatement("insert into endereco(end_ref, end_num, end_cep) values (?,?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                System.out.println("UPDATE Endereco");
                pstm = con.prepareStatement("update endereco set end_ref = ?, end_num = ?, end_cep = ? where end_codigo = ?");
            }

            pstm.setString(1, end.getEnd_ref());
            pstm.setString(2, end.getEnd_num());
            pstm.setString(3, end.getEnd_cep().getCep_cep());
            if (end.getEnd_codigo() > 0)//update
            {
                pstm.setInt(4, end.getEnd_codigo());
            }

            int count = pstm.executeUpdate();

            if (count == 0) {
                throw new SQLException("Erro ao salvar enredeço");
            }

            if (end.getEnd_codigo() == 0) {
                end.setEnd_codigo(getGeneratedId(pstm));
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

    public static int getGeneratedId(Statement stmt) throws SQLException {
        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            int id = rs.getInt(1);
            return id;
        }
        return 0;
    }

}
