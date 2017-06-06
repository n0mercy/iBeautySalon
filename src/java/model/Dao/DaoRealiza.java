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
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bean.BeanEmpresa;
import model.Bean.BeanRealiza;
import static model.Dao.BaseDao.getConnection;

/**
 *
 * @author VaiDiegoo
 */
public class DaoRealiza extends BaseDao {

    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanRealiza> list;
    BeanRealiza mensalidade = new BeanRealiza();

    public void save(BeanRealiza mens, boolean primeiroPagamento, boolean novaMensa) throws SQLException {
        con = getConnection();
        try {
            StringBuilder sb = new StringBuilder();
            if (novaMensa) {
                System.out.println("INSERT NOVA MENSALIDADE");
                sb.append("insert into realiza(real_datapag, real_valor, real_dtVenc, real_status, real_emp_cnpj, real_pag_codigo) values (?,?,?,?,?,?)");
            } else if (primeiroPagamento) {
                System.out.println("INSERT PRIMEIRA MENSALIDADE");
                sb.append("insert into realiza(real_datapag, real_valor, real_dtVenc, real_status, real_emp_cnpj) values (?,?,?,?,?)");
            } else {
                System.out.println("UPDATE MENSALIDADE");
                if(mens.getReal_pag_codigo().getPag_desc() == null){
                    System.out.println("PAG NULO");
                    sb.append("update realiza set real_datapag = ?, real_valor = ?, real_dtVenc = ?, real_status = ?, real_emp_cnpj = ? where real_codigo = ?");
                }else{
                    System.out.println("PAG NÂO NULO");
                    sb.append("update realiza set real_datapag = ?, real_valor = ?, real_dtVenc = ?, real_status = ?, real_emp_cnpj = ?, real_pag_codigo = ? where real_codigo = ?");
                }
            }
            if (mens.getReal_cod() == 0) {
                pstm = con.prepareStatement(sb.toString(), Statement.RETURN_GENERATED_KEYS);
            }else{
                pstm = con.prepareStatement(sb.toString());
            }

            if (primeiroPagamento) {
                pstm.setDate(1, null);
                pstm.setDouble(2, mens.getReal_valor());
                pstm.setDate(3, null);
                pstm.setString(4, mens.getReal_status());
                pstm.setString(5, mens.getReal_emp_cnpj().getEmp_cnpj());
            } else {
                if(mens.getReal_datapag() != null)
                    pstm.setDate(1, new java.sql.Date(mens.getReal_datapag().getTime()));
                else
                    pstm.setDate(1, null);
                
                pstm.setDouble(2, mens.getReal_valor());
                
                if(mens.getReal_dtVenc() != null)
                    pstm.setDate(3, new java.sql.Date(mens.getReal_dtVenc().getTime()));
                else
                    pstm.setDate(3, null);
                
                pstm.setString(4, mens.getReal_status());
                pstm.setString(5, mens.getReal_emp_cnpj().getEmp_cnpj());
                
                if (mens.getReal_pag_codigo().getPag_desc() != null)
                    pstm.setInt(6, mens.getReal_pag_codigo().getPag_codigo());
                
            }

            if (mens.getReal_cod() > 0)//update
            {
                if(mens.getReal_pag_codigo().getPag_desc() == null)
                    pstm.setLong(6, mens.getReal_cod());
                else
                    pstm.setLong(7, mens.getReal_cod());
            }

            int count = pstm.executeUpdate();

            if (count == 0) {
                throw new SQLException("Erro ao inserir o mensalidade");
            }

            if (mens.getReal_cod() == 0) {
                mens.setReal_cod(getGeneratedId(pstm));
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

    public BeanRealiza findByCnpj(String cnpj) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from realiza where real_emp_cnpj = ? and real_status = 'pendente'";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, cnpj);
            rs = pstm.executeQuery();
            mensalidade = createMensalidade(rs);
            return mensalidade;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Cep não encontrado" + erro.getMessage());
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

    private BeanRealiza createMensalidade(ResultSet r) {
        try {
            list = new ArrayList<>();
            while (rs.next()) {
                mensalidade = new BeanRealiza();
                mensalidade.setReal_cod(rs.getInt("real_codigo"));
                mensalidade.setReal_datapag(rs.getDate("real_datapag"));
                mensalidade.setReal_dtVenc(rs.getDate("real_dtVenc"));
                mensalidade.setReal_status(rs.getString("real_status"));
                mensalidade.setReal_valor(rs.getDouble("real_valor"));
                mensalidade.setReal_pag_codigo(new DaoPagamento().findByCodigo(rs.getInt("real_pag_codigo")));
                mensalidade.setReal_emp_cnpj(new DaoEmpresa().findByCnpj(rs.getString("real_emp_cnpj")));
                list.add(mensalidade);
            }
            return mensalidade;
        } catch (SQLException ex) {
            Logger.getLogger(DaoZona.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }
}
