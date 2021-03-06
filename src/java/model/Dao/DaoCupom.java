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

/**
 *
 * @author VaiDiegoo
 */
public class DaoCupom extends BaseDao{
    
    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanCupom> list;
    BeanCupom cupom = new BeanCupom();
    
    public void save(BeanCupom cupom) throws SQLException {
        con = getConnection();
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
        con = getConnection();
        try {            
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
    
    public List<BeanCupom> findByEmpStatus(String cnpj, String status) throws SQLException {
        con = getConnection();
        try {            
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT * FROM cupom ");
            sb.append("INNER JOIN itemservico ON itemserv_cupom_codigo = cupom_codigo ");
            sb.append("INNER JOIN oferece ON ofe_codigo = itemserv_ofe_codigo ");
            sb.append("WHERE cupom_status like ? ");                    
            sb.append("and ofe_emp_cnpj = ? "); 
            sb.append("group by cupom_codigo");
            pstm = con.prepareStatement(sb.toString());
            
            if(status.equalsIgnoreCase("em atendimento"))
                status = "em";
            
            pstm.setString(1, '%'+status+'%');
            pstm.setString(2, cnpj);
            rs = pstm.executeQuery();
            cupom = createCupom(rs);
            return list;
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
    
    public List<BeanCupom> findByEmpStatusCheck(String cnpj, String cupomID) throws SQLException {
        con = getConnection();
        try {            
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT * FROM cupom ");
            sb.append("INNER JOIN itemservico ON itemserv_cupom_codigo = cupom_codigo ");
            sb.append("INNER JOIN oferece ON ofe_codigo = itemserv_ofe_codigo ");
            sb.append("WHERE ofe_emp_cnpj = ? ");
            sb.append("AND cupom_codigo = ? ");
            sb.append("AND cupom_status <> 'finalizado' ");
            sb.append("group by cupom_codigo");
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, cnpj);
            pstm.setString(2, cupomID);
            rs = pstm.executeQuery();
            cupom = createCupom(rs);
            return list;
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
    
    public List<BeanCupom> findCuponsCompradosByCPF(String cpf) throws SQLException {
        con = getConnection();
        try {            
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT * FROM cupom where cupom_clicpf = ? and cupom_status <> 'cancelado'");
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, cpf);
            rs = pstm.executeQuery();
            cupom = createCupom(rs);
            return list;
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
    
    public BeanCupom findByCliente(String cpf) throws SQLException {
        con = getConnection();
        try {            
            StringBuilder sb = new StringBuilder();
            sb.append("select * from cupom where cupom_clicpf = ? and cupom_status = 'pendente'");
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, cpf);
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
