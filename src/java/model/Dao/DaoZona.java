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
import model.Bean.BeanZona;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoZona {

    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanZona zona;
    List<BeanZona> list;

    

    public BeanZona findByCodigo(int codigo) throws SQLException {
        try {
            con = Conexao.getConnection();
            String sql = "select * from zona where zona_cod = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            zona = createZona(rs);
            return zona;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Zona não cadastrada" + erro.getMessage());
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

    private BeanZona createZona(ResultSet r) {
        try {
            list = new ArrayList<>();
            while (rs.next()) {
                zona = new BeanZona();
                zona.setZona_cod(r.getInt("zona_cod"));
                zona.setZona_nome(r.getString("zona_nome"));
                list.add(zona);
            }
            return zona;
        } catch (SQLException ex) {
            Logger.getLogger(DaoZona.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public List<BeanZona> findAll() throws SQLException {
        try {
            con = Conexao.getConnection();
            String sql = "select * from zona";
            pstm = con.prepareStatement(sql);
            rs = pstm.executeQuery();
            zona = createZona(rs);//task list zonas
            return list;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Zona não encontrado" + erro.getMessage());
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
    
    public void save(BeanZona zona) throws SQLException {
        try {
            if (zona.getZona_cod() == 0) {
                pstm = con.prepareStatement("insert into zona(zona_nome) values (?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                pstm = con.prepareStatement("update zona set zona_nome = ? where zona_cod = ?");
            }

            pstm.setString(1, zona.getZona_nome());
            if (zona.getZona_cod() > 0)//update
            {
                pstm.setLong(2, zona.getZona_cod());
            }

            int count = pstm.executeUpdate();
            
            if (count == 0) {
                throw new SQLException("Erro ao inserir a zona");
            }

            if (zona.getZona_cod() == 0) {
                zona.setZona_cod(getGeneratedId(pstm));
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
