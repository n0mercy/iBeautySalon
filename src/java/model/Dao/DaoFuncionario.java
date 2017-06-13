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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bean.BeanFuncionario;

/**
 *
 * @author VaiDiegoo
 */
public class DaoFuncionario extends BaseDao{
    Connection con;
    PreparedStatement pstm;
    ResultSet rs;
    BeanFuncionario funcionario = new BeanFuncionario();
    List<BeanFuncionario> list = new ArrayList<BeanFuncionario>();
    
    public List<BeanFuncionario> findByEmpresa(String cnpj) throws SQLException {
        try {
            con = getConnection();
            String sql = "select * from funcionario where fun_emp_cnpj = ?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, cnpj);
            rs = pstm.executeQuery();
            funcionario = createFuncionario(rs);//task list bairros
            return list;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Funcionario não encontrado" + erro.getMessage());
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
    
    private BeanFuncionario createFuncionario(ResultSet r){
        list = new ArrayList<BeanFuncionario>();
        try {
            while (r.next()) {
                funcionario = new BeanFuncionario();
                funcionario.setFun_matricula(r.getInt("fun_matricula"));
                funcionario.setFun_nome(r.getString("fun_nome"));
                funcionario.setFun_status(r.getString("fun_status"));
                funcionario.setFun_emp_cnpj(new DaoEmpresa().findByCnpj(r.getString("fun_emp_cnpj")));
                list.add(funcionario);
            }
            return funcionario;
        } catch (SQLException ex) {
            Logger.getLogger(DaoFones.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
     }
}
