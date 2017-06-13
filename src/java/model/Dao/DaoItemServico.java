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
import model.Bean.BeanItemServico;

/**
 *
 * @author VaiDiegoo
 */
public class DaoItemServico extends BaseDao {

    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanItemServico> list;
    BeanItemServico item = new BeanItemServico();

    public void save(BeanItemServico i) throws SQLException {
        con = getConnection();
        try {
            if (i.getItemserv_codigo() == 0) {
                System.out.println("INSERT ITEMSERVICO");
                pstm = con.prepareStatement("insert into itemservico(itemserv_data, itemserv_ofe_codigo, itemserv_cupom_codigo) values (?,?,?)", Statement.RETURN_GENERATED_KEYS);
            } else {
                System.out.println("UPDATE ITEMSERVICO");
                pstm = con.prepareStatement("update itemservico set itemserv_data = ?, itemserv_ofe_codigo = ?, itemserv_cupom_codigo = ? where itemserv_codigo = ?");
            }

            pstm.setDate(1, new java.sql.Date(new Date().getTime()));
            pstm.setInt(2, i.getItemserv_ofe_cod().getOfe_codigo());
            pstm.setInt(3, i.getItemserv_cupom_cod().getCupom_codigo());
            //pstm.setString(4, null);
            if (i.getItemserv_codigo() > 0)//update
            {
                pstm.setInt(5, i.getItemserv_codigo());
            }

            int count = pstm.executeUpdate();

            if (count == 0) {
                throw new SQLException("Erro ao salvar cliente");
            }

            if (i.getItemserv_codigo() == 0) {
                i.setItemserv_codigo(getGeneratedId(pstm));
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
    
    public void remove(int codigo) throws SQLException {
        con = getConnection();
        try {
            if (codigo > 0) {
                System.out.println("REMOVE ITEMSERVICO");
                pstm = con.prepareStatement("delete from itemservico where itemserv_codigo = ?");
            }
            pstm.setInt(1, codigo);
            int count = pstm.executeUpdate();

            if (count == 0) {
                throw new SQLException("Erro ao remover item de serviço");
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

    public BeanItemServico findByCodigo(int codigo) throws SQLException {
        try {
            con = getConnection();
            String sql = "select * from itemservico where itemserv_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, codigo);
            rs = pstm.executeQuery();
            item = createServico(rs);
            return item;
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

    public List<BeanItemServico> findItensByCupom(int codigo, String status) throws SQLException {
        try {
            con = getConnection();
            StringBuilder sb = new StringBuilder();
            sb.append("select * from itemservico i ");
            sb.append("inner join cupom c on c.cupom_codigo = i.itemserv_cupom_codigo ");
            sb.append("where c.cupom_codigo = ? "); 
            if(status != null)
                sb.append("and c.cupom_status = ?");
            
            pstm = con.prepareStatement(sb.toString());
            pstm.setInt(1, codigo);            
            if(status != null)
                pstm.setString(2, status);
            
            rs = pstm.executeQuery();
            item = createServico(rs);
            return list;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Item não encontrado" + erro.getMessage());
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

    private BeanItemServico createServico(ResultSet r) {
        try {
            list = new ArrayList<>();
            while (rs.next()) {
                item = new BeanItemServico();
                item.setItemserv_codigo(r.getInt("itemserv_codigo"));
                item.setItemserv_data(new Date());
                item.setItemserv_ofe_cod(new DaoOferece().findByCodigo(rs.getInt("itemserv_ofe_codigo")));
                item.setItemserv_cupom_cod(new DaoCupom().findByCodigo(rs.getInt("itemserv_cupom_codigo")));
                list.add(item);
            }
            return item;
        } catch (SQLException ex) {
            Logger.getLogger(DaoZona.class.getName()).log(Level.SEVERE, null, ex);
            return null;
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
