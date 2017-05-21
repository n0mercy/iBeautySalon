/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Dao;

import java.sql.SQLException;
import java.util.Date;
import model.Bean.BeanCep;
import model.Bean.BeanCliente;

/**
 *
 * @author n0mercy
 */
public class TesteMain {
    public static void main(String args[]) throws SQLException{
        BeanCliente cliente = new BeanCliente();
        cliente = new DaoCliente().findByCpf("003.539.242-88");
        cliente.setCli_nome("Frank");
        cliente.setCli_dtnasc(new Date());
        cliente.setCli_usu_codigo(new DaoUsuario().findByCodigo(4));
        new DaoCliente().save(cliente, true);
    }
}
