/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author n0mercy
 */
public class Conexao {
    
    Statement stm;
    java.sql.Connection con;
    public static String user = "root";
    public static String pwd = "cavalo14";
    
    public static java.sql.Connection getConnection(){
        java.sql.Connection con=null;
        try{
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String url="jdbc:mysql://localhost:3306/ibeautysalon";
            con = DriverManager.getConnection(url, user, pwd);
        }catch(ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException erro){
            System.out.println("Erro de conexão BD" + erro.getMessage() );
            
        }               
        return con;
    }
    
}
