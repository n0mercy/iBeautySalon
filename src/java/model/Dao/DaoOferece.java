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
import model.Bean.BeanOferece;

/**
 *
 * @author VaiDiegoo
 */
public class DaoOferece extends BaseDao{

    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanOferece> offers = new ArrayList<BeanOferece>();
    BeanOferece offer = new BeanOferece();

    public List<BeanOferece> findOffersByEmpresa(String cnpj, String descricao, boolean all) throws SQLException {
        con = getConnection();
        StringBuilder sb = new StringBuilder();
        sb.append("select * from servico c ");
        sb.append("inner join oferece o ON o.ofe_serv_codigo = c.serv_codigo ");
        sb.append("inner join empresa_usuario e ON e.emp_cnpj = o.ofe_emp_cnpj ");
        sb.append("inner join servico s on s.serv_codigo = o.ofe_serv_codigo ");
        sb.append("where e.emp_cnpj = ? ");
        if(all)
            sb.append("and o.ofe_status = 'Ativo' ");
        
        if(descricao != null && !descricao.trim().isEmpty())
            sb.append("and s.serv_desc like ?");
        
        try {
            pstm = con.prepareStatement(sb.toString());
            pstm.setString(1, cnpj);
            if(descricao != null && !descricao.trim().isEmpty())
                pstm.setString(2, "%"+descricao+"%");
                
            rs = pstm.executeQuery();
            //Enquanto existir dados no banco de dados, faça
            offer = createOferece(rs);
        } catch (Exception e) {
            System.out.println("Erro ao listar servicos" + e);
        }finally{
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
        return offers;
    }
    
    public List<BeanOferece> findAllServicosOferecidos() throws SQLException {
        con = getConnection();
        StringBuilder sb = new StringBuilder();
        sb.append("select * from oferece o ");       
        
        try {
            pstm = con.prepareStatement(sb.toString());
            rs = pstm.executeQuery();
            offer = createOferece(rs);
        } catch (Exception e) {
            System.out.println("Erro ao listar servicos ofertados" + e);
        }finally{
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
        return offers;
    }

    private BeanOferece createOferece(ResultSet r) throws SQLException {
        while(rs.next()){
            offer = new BeanOferece();
            offer.setOfe_codigo(rs.getInt("ofe_codigo"));
            offer.setOfe_status(rs.getString("ofe_status"));
            offer.setOfe_valor(rs.getDouble("ofe_valor"));
            offer.setOfe_emp_cnpj(new DaoEmpresa().findByCnpj(rs.getString("ofe_emp_cnpj")));
            offer.setOfe_serv_codigo(new DaoServico().findByCodigo(rs.getInt("ofe_serv_codigo")));
            offers.add(offer);
        }
        return offer;

    }
    
    public void save(BeanOferece ofe) throws SQLException {
        con = getConnection();
        try {
            if (ofe.getOfe_codigo() == 0) {
                pstm = con.prepareStatement("insert into oferece(ofe_status, ofe_valor, ofe_emp_cnpj, ofe_serv_codigo) values (?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                pstm = con.prepareStatement("update oferece set ofe_status = ?, ofe_valor = ?, ofe_emp_cnpj = ?, ofe_serv_codigo = ? where ofe_codigo = ?");
            }
            
            pstm.setString(1, ofe.getOfe_status());
            pstm.setDouble(2, ofe.getOfe_valor());
            pstm.setString(3, ofe.getOfe_emp_cnpj().getEmp_cnpj());
            pstm.setInt(4, ofe.getOfe_serv_codigo().getServ_cod());
            if (ofe.getOfe_codigo() > 0)//update
            {
                pstm.setInt(5, ofe.getOfe_codigo());
            }

            int count = pstm.executeUpdate();
            
            if (count == 0) {
                throw new SQLException("Erro ao inserir o oferta");
            }
            
            if (ofe.getOfe_codigo() == 0) {
                ofe.setOfe_codigo(getGeneratedId(pstm));
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
    
    public BeanOferece findByCodigo(int codigo) throws SQLException {
        con = getConnection();
        try {
            String sql = "select * from oferece where ofe_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            offer = createOferece(rs);
            return offer;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Oferta não encontrada" + erro.getMessage());
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

}
