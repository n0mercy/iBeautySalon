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
import model.Bean.BeanEmpresa;
import model.Bean.BeanServico;

/**
 *
 * @author VaiDiegoo
 */
public class DaoServico extends BaseDao {

    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanServico> servicos = new ArrayList<BeanServico>();
    BeanServico servico = new BeanServico();

    public void salvarServico(BeanServico serv) throws SQLException {
        con = getConnection();
        try {
            String sql = "insert into servico(serv_desc,serv_status) values(?,?)";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, serv.getServ_nome());
            pstm.setString(2, serv.getServ_status());
            pstm.execute();
            System.out.println("Serviço Inserido" + sql);
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Erro ao inserir serviço " + erro.getMessage());
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

    public void alterarStatusServico(BeanServico serv) {
        con = getConnection();
        try {
            String sql = "update servico set serv_desc = ?, serv_status = ? where serv_codigo=?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, serv.getServ_nome());
            pstm.setString(2, serv.getServ_status());
            pstm.setInt(3, serv.getServ_cod());
            pstm.execute();
            System.out.println("Serviço Alterado" + sql);
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Erro ao alterar serviço " + erro.getMessage());
        }
    }

    public List<BeanServico> listarServicos(BeanServico serv) throws SQLException {
        con = getConnection();
        String sql = "SELECT * FROM servicos where serv_nome like '%" + serv.getServ_nome() + "%'";

        try {
            pstm = con.prepareStatement(sql);
            rs = pstm.executeQuery();
            //Enquanto existir dados no banco de dados, faça
            while (rs.next()) {

                BeanServico servico = new BeanServico();
                //Recupera o codigo do banco e atribui ele ao objeto
                servico.setServ_cod(rs.getInt("serv_codigo"));
                //Recupera o nome do banco e atribui ele ao objeto
                servico.setServ_nome(rs.getString("serv_desc"));
                //Recupera o status do banco e atribui ele ao objeto
                servico.setServ_status(rs.getString("serv_status"));
                //Adiciono o servico recuperado, a lista de contatos
                servicos.add(servico);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar servicos" + e);
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
        return servicos;
    }

    public BeanServico findByCodigo(int serv) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from servico where serv_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, serv);
            rs = pstm.executeQuery();
            servico = createServico(rs);
            return servico;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Serviço não encontrado" + erro.getMessage());
            return null;
        } finally {
            con.close();
            rs.close();
            pstm.close();
        }
    }

    public List<BeanServico> findAll() throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from servico";
            pstm = con.prepareStatement(sql);
            rs = pstm.executeQuery();
            servico = createServico(rs);
            return servicos;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Serviço não encontrado" + erro.getMessage());
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

    public List<BeanServico> findByDescricao(String descricao) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from servico where serv_desc like ?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, "%" + descricao + "%");
            rs = pstm.executeQuery();
            servico = createServico(rs);
            return servicos;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Serviço não encontrado" + erro.getMessage());
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

    public List<BeanServico> findServWithoutRelation(String descricao, BeanEmpresa emp) throws SQLException {
        con = getConnection();
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("select * from servico ");
            sb.append("where serv_desc like ? and serv_codigo NOT IN( ");
            sb.append("select s.serv_codigo from servico c ");
            sb.append("inner join oferece o ON o.ofe_serv_codigo = c.serv_codigo ");
            sb.append("inner join empresa_usuario e ON e.emp_cnpj = o.ofe_emp_cnpj ");
            sb.append("inner join servico s on s.serv_codigo = o.ofe_serv_codigo ");
            sb.append("where e.emp_cnpj = ? ) and serv_status = 'Ativo'");
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, "%" + descricao + "%");
            pstm.setString(2, emp.getEmp_cnpj());
            rs = pstm.executeQuery();
            servico = createServico(rs);
            return servicos;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Serviço não encontrado" + erro.getMessage());
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

    private BeanServico createServico(ResultSet r) throws SQLException {
        servicos = new ArrayList<BeanServico>();
        while (rs.next()) {
            servico = new BeanServico();
            servico.setServ_cod(rs.getInt("serv_codigo"));
            servico.setServ_nome(rs.getString("serv_desc"));
            servico.setServ_status(rs.getString("serv_status"));
            servicos.add(servico);
        }
        return servico;
    }

}
