/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author VaiDiegoo
 */
public class Conexao {
    
    Statement stm;
    public static Connection getConnection(){
        Connection con=null;
        try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url="jdbc:mysql://localhost:3306/ibeautysalon";
            String login="root";
            String senha="cavalo14";
            con=DriverManager.getConnection(url, login, senha);
           // System.out.println("conectado");
        }catch(ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException erro){
            System.out.println("Erro de conexão BD" + erro.getMessage() );
            
        }               
        return con;
    }
    
}
