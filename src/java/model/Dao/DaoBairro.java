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
import model.Bean.BeanBairro;

/**
 *
 * @author VaiDiegoo
 */
public class DaoBairro extends BaseDao{

    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    BeanBairro bairro;
    List<BeanBairro> list;

    public BeanBairro findByDescricao(String desc) throws SQLException {
        try {
            con = getConnection();
            String sql = "select * from bairro where bai_nome = ?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, desc);
            rs = pstm.executeQuery();
            bairro = createBairro(rs);
            return bairro;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Bairro não encontrado" + erro.getMessage());
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
    
    public BeanBairro findByCodigo(int codigo) throws SQLException {
        try {
            con = getConnection();
            String sql = "select * from bairro where bai_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            bairro = createBairro(rs);
            return bairro;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Bairro não encontrado" + erro.getMessage());
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

    private BeanBairro createBairro(ResultSet r) {
        try {
            list = new ArrayList<>();
            while (rs.next()) {
                bairro = new BeanBairro();
                bairro.setBai_codigo(r.getInt("bai_codigo"));
                bairro.setBai_nome(r.getString("bai_nome"));
                bairro.setBai_zona_cod(new DaoZona().findByCodigo(r.getInt("bai_zona_cod")));
                list.add(bairro);
            }
            return bairro;
        } catch (SQLException ex) {
            Logger.getLogger(DaoBairro.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public List<BeanBairro> findAll() throws SQLException {
        try {
            con = getConnection();
            String sql = "select * from bairro";
            pstm = con.prepareStatement(sql);
            rs = pstm.executeQuery();
            bairro = createBairro(rs);//task list bairros
            return list;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Bairro não encontrado" + erro.getMessage());
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
    
    public void save(BeanBairro bairro) throws SQLException {
        con = getConnection();
        try {
            if (bairro.getBai_codigo()== 0) {
                pstm = con.prepareStatement("insert into bairro(bai_nome, bai_zona_cod) values (?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                pstm = con.prepareStatement("update bairro set bai_nome = ?, bai_zona_cod = ? where bai_codigo = ?");
            }

            pstm.setString(1, bairro.getBai_nome());
            pstm.setInt(2, bairro.getBai_zona_cod().getZona_cod());
            if (bairro.getBai_codigo()> 0)//update
            {
                pstm.setInt(3, bairro.getBai_codigo());
            }

            int count = pstm.executeUpdate();
            
            if (count == 0) {
                throw new SQLException("Erro ao inserir o bairro");
            }

            if (bairro.getBai_codigo()== 0) {
                bairro.setBai_codigo(getGeneratedId(pstm));
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
}
