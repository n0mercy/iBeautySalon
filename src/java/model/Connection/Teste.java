package model.Connection;


import model.connection.Conexao;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.Connection;
/**
 *
 * @author VaiDiegoo
 */
public class Teste {
 
    public static void main(String args[]){
        Connection c = Conexao.getConnection();
        System.out.println(c);
        
    }
}
