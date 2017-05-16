/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Dao;

import java.sql.SQLException;
import model.Bean.BeanCep;

/**
 *
 * @author n0mercy
 */
public class TesteMain {
    public static void main(String args[]) throws SQLException{
        BeanCep b = new BeanCep();
        b.setCep_cep("69030052");
        b.setRua("Danilo de Matos Areosa 3");
        b.setCep_bai_codigo(new DaoBairro().findByCodigo(8));
        new DaoCep().save(b, false);
        System.out.println(b.getCep_cep());
    }
}
