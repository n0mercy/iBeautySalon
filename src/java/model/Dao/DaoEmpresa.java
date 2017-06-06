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
import model.Bean.BeanEmpresa;

/**
 *
 * @author VaiDiegoo
 */
public class DaoEmpresa extends BaseDao{

    Connection con = model.Dao.BaseDao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    BeanEmpresa emp = new BeanEmpresa();
    List<BeanEmpresa> list = new ArrayList<BeanEmpresa>();

    public BeanEmpresa findByCnpj(String cnpj) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from empresa_usuario where emp_cnpj = ?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, cnpj);
            rs = pstm.executeQuery();
            emp = createEmpresa(rs);
            return emp;
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
    
    public BeanEmpresa findByEmail(String email) throws SQLException {
        con = getConnection();
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("select * from empresa_usuario e ");
            sb.append("inner join usuario u ON u.usu_codigo = e.emp_usu_codigo ");
            sb.append("where u.usu_email = ?");
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, email);
            rs = pstm.executeQuery();
            emp = createEmpresa(rs);
            return emp;
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
    
    public List<BeanEmpresa> findByCpfStatusPendente(String cpf) throws SQLException {
        con = getConnection();
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT * FROM empresa_usuario INNER JOIN usuario u ON emp_usu_codigo = u.usu_codigo ");
            sb.append("INNER JOIN fones ON fone_usu_codigo = usu_codigo ");
            sb.append("INNER JOIN tipo_usuario ON usu_tipo_codigo = tipo_codigo ");
            sb.append("INNER JOIN endereco ON usu_end_codigo = end_codigo ");
            sb.append("INNER JOIN cep ON end_cep = cep_cep ");
            sb.append("INNER JOIN bairro ON cep_bai_codigo = bai_codigo ");
            sb.append("INNER JOIN zona ON bai_zona_cod = zona_cod ");
            sb.append("INNER JOIN oferece ON ofe_emp_cnpj = emp_cnpj ");
            sb.append("LEFT JOIN itemservico ON itemserv_ofe_codigo = ofe_codigo ");
            sb.append("LEFT JOIN cupom ON cupom_codigo = itemserv_cupom_codigo ");
            sb.append("WHERE usu_status = 'Ativo' and cupom_status = 'pendente' and cupom_clicpf = ? ");
            sb.append("GROUP BY emp_cnpj");
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, cpf);
            rs = pstm.executeQuery();
            emp = createEmpresa(rs);
            return list;
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
    
    public List<BeanEmpresa> findEmpresasByCEP(String cep) throws SQLException {
        con = getConnection();
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("SELECT *FROM empresa_usuario e ");
            sb.append("INNER JOIN usuario u ON u.usu_codigo = e.emp_usu_codigo ");
            sb.append("INNER JOIN endereco en ON en.end_codigo = u.usu_end_codigo ");
            sb.append("RIGHT JOIN cep c ON c.cep_cep = en.end_cep ");
            sb.append("INNER JOIN bairro b ON b.bai_codigo = c.cep_bai_codigo ");
            sb.append("INNER JOIN zona z ON z.zona_cod = b.bai_zona_cod ");
            sb.append("WHERE z.zona_cod IN ");
            sb.append("(SELECT zz.zona_cod FROM cep cc ");
            sb.append("INNER JOIN bairro bb ON bb.bai_codigo = cc.cep_bai_codigo ");
            sb.append("INNER JOIN zona zz ON zz.zona_cod = bb.bai_zona_cod AND cc.cep_cep = ? ");
            sb.append(") and e.emp_cnpj IS NOT NULL");
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, cep);
            rs = pstm.executeQuery();
            emp = createEmpresa(rs);
            return list;
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
    
    public List<BeanEmpresa> findAllEmpresas() throws SQLException {
        con = getConnection();
        try {
            StringBuilder sb = new StringBuilder();
            sb.append("select * from empresa_usuario inner join ");
            sb.append("usuario on emp_usu_codigo = usu_codigo left join ");
            sb.append("fones on fone_usu_codigo = usu_codigo inner join ");
            sb.append("tipo_usuario on usu_tipo_codigo= tipo_codigo inner join ");
            sb.append("endereco on usu_end_codigo = end_codigo inner join ");
            sb.append("cep on end_cep = cep_cep inner join ");
            sb.append("bairro on cep_bai_codigo=bai_codigo inner join ");
            sb.append("zona on bai_zona_cod=zona_cod where usu_status='Ativo'");
            pstm = con.prepareStatement(sb.toString());
            rs = pstm.executeQuery();
            emp = createEmpresa(rs);
            return list;
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

    private BeanEmpresa createEmpresa(ResultSet r) {
        list = new ArrayList<BeanEmpresa>();
        try {
            while (rs.next()) {
                emp = new BeanEmpresa();
                emp.setEmp_cnpj(rs.getString("emp_cnpj"));
                emp.setEmp_insc_estadual(rs.getString("emp_insc_estadual"));
                emp.setEmp_razao(rs.getString("emp_razao"));
                emp.setEmp_usu_codigo(new DaoUsuario().findByCodigo(rs.getInt("emp_usu_codigo")));
                list.add(emp);
            }
            return emp;
        } catch (SQLException ex) {
            Logger.getLogger(DaoEmpresa.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public void save(BeanEmpresa emp, boolean up) throws SQLException {
        con = getConnection();
        try {
            if (!up) {
                System.out.println("INSERT EMPRESA");
                pstm = con.prepareStatement("insert into empresa_usuario(emp_cnpj,emp_razao, emp_insc_estadual, emp_usu_codigo) values (?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                System.out.println("UPDATE EMPRESA: "+emp.getEmp_cnpj());
                pstm = con.prepareStatement("update empresa_usuario set emp_cnpj = ?, emp_razao = ?, emp_insc_estadual = ?, emp_usu_codigo = ? where emp_cnpj = ?");
            }
            pstm.setString(1, emp.getEmp_cnpj());
            pstm.setString(2, emp.getEmp_razao());
            pstm.setString(3, emp.getEmp_insc_estadual());
            pstm.setInt(4, emp.getEmp_usu_codigo().getUsu_codigo());
            if (up)//update
            {
                pstm.setString(5, emp.getEmp_cnpj());
            }

            int count = pstm.executeUpdate();

            if (count == 0) {
                throw new SQLException("Erro ao salvar empresa: ");
            }
            
            if(emp.getEmp_cnpj() == null){
                emp.setEmp_cnpj(getGeneratedId(pstm));
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
            System.out.println("CNPJ: "+id);
            return id;
        }
        return null;
    }
}
