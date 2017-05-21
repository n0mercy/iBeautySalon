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
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bean.BeanCliente;
import model.Bean.BeanEmpresa;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoCliente {

    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanCliente cliente = new BeanCliente();

    public void save(BeanCliente c, boolean update) throws SQLException {
        con = Conexao.getConnection();
        try {
            if (!update) {
                System.out.println("INSERT CLIENTE");
                pstm = con.prepareStatement("insert into cliente_usuario(cli_cpf, cli_nome, cli_dtnasc, cli_usu_codigo) values (?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                System.out.println("UPDATE CLIENTE");
                pstm = con.prepareStatement("update cliente_usuario set cli_cpf = ?, cli_nome = ?, cli_dtnasc = ?, cli_usu_codigo = ? where cli_cpf = ?");
            }

            pstm.setString(1, c.getCli_cpf());
            pstm.setString(2, c.getCli_nome());
            pstm.setDate(3, new java.sql.Date(new Date().getTime()));
            pstm.setInt(4, c.getCli_usu_codigo().getUsu_codigo());
            if (update)//update
            {
                pstm.setString(5, c.getCli_cpf());
            }

            int count = pstm.executeUpdate();

            if (count == 0) {
                throw new SQLException("Erro ao salvar cliente");
            }

            if (c.getCli_cpf() == null) {
                c.setCli_cpf(getGeneratedId(pstm));
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

    public static String getGeneratedId(Statement stmt) throws SQLException {
        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            String id = rs.getString(1);
            return id;
        }
        return null;
    }
    
    public BeanCliente findByCpf(String cpf) throws SQLException {
        try {
            con = Conexao.getConnection();
            String sql = "select * from cliente_usuario where cli_cpf = ?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, cpf);
            rs = pstm.executeQuery();
            cliente = createCliente(rs);
            return cliente;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Cliente não encontrado" + erro.getMessage());
            return null;
        } finally {
            con.close();
            rs.close();
            pstm.close();
        }
    }

    private BeanCliente createCliente(ResultSet r) {
        try {
            while (rs.next()) {
                cliente.setCli_cpf(rs.getString("cli_cpf"));
                cliente.setCli_nome(rs.getString("cli_nome"));
                cliente.setCli_dtnasc(rs.getDate("cli_dtnasc"));
                cliente.setCli_usu_codigo(new DaoUsuario().findByCodigo(rs.getInt("cli_usu_codigo")));
            }
            return cliente;
        } catch (SQLException ex) {
            Logger.getLogger(DaoEmpresa.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

}
