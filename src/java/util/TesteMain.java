/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import model.Bean.BeanOferece;
import model.Dao.DaoOferece;

/**
 *
 * @author n0mercy
 */
public class TesteMain {
    public static void main(String args[]) throws SQLException, IOException{
        
        BeanOferece o = new BeanOferece();
        o = new DaoOferece().findByCodigo(1);
        System.out.println(o.getOfe_emp_cnpj().getEmp_cnpj());
    }
}
