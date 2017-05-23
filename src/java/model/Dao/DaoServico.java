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
import model.Bean.BeanEmpresa;
import model.Bean.BeanOferece;
import model.Bean.BeanServico;
import model.connection.Conexao;

/**
 *
 * @author VaiDiegoo
 */
public class DaoServico {
        
    Connection con = model.connection.Conexao.getConnection();
    PreparedStatement pstm;
    ResultSet rs;
    List<BeanServico> servicos = new ArrayList<BeanServico>();
    BeanServico servico = new BeanServico();
        
    public void salvarServico(BeanServico serv){
       try{
           con=Conexao.getConnection();          
           String sql="insert into servico(serv_desc,serv_status) values(?,?)";           
            pstm=con.prepareStatement(sql);
            pstm.setString(1, serv.getServ_nome());
            pstm.setString(2, serv.getServ_status());
            pstm.execute();
           System.out.println("Serviço Inserido"+sql);
        }catch(SQLException | HeadlessException erro){
            System.out.println("Erro ao inserir serviço " +erro.getMessage());            
        }
    }
    
    public void alterarStatusServico(BeanServico serv){
       try{
           con=Conexao.getConnection();          
           String sql="update servico set serv_desc = ?, serv_status = ? where serv_codigo=?";           
            pstm=con.prepareStatement(sql);
            pstm.setString(1, serv.getServ_nome());
            pstm.setString(2, serv.getServ_status());
            pstm.setInt(3, serv.getServ_cod());
            pstm.execute();
           System.out.println("Serviço Alterado"+sql);
        }catch(SQLException | HeadlessException erro){
            System.out.println("Erro ao alterar serviço " +erro.getMessage());            
        }       
    }
    
    public List<BeanServico> listarServicos(BeanServico serv) {
        con=Conexao.getConnection();            
        String sql = "SELECT * FROM servicos where serv_nome like '%"+serv.getServ_nome()+"%'";     
                          
        try {           
            pstm = con.prepareStatement(sql);
            rs = pstm.executeQuery();
            //Enquanto existir dados no banco de dados, faça
            while (rs.next()) {

                BeanServico servico = new BeanServico();
                //Recupera o codigo do banco e atribui ele ao objeto
                servico.setServ_cod(rs.getInt("serv_codigo"));
                //Recupera o nome do banco e atribui ele ao objeto
                servico.setServ_nome(rs.getString("serv_desc"));
                //Recupera o status do banco e atribui ele ao objeto
                servico.setServ_status(rs.getString("serv_status"));                
                //Adiciono o servico recuperado, a lista de contatos
                servicos.add(servico);
            }
        } catch (Exception e) {
            System.out.println("Erro ao listar servicos"+e);
        }        
        return servicos;
    }
    
    public BeanServico findByCodigo(int serv) throws SQLException {
        try {
            con = Conexao.getConnection();
            String sql = "select * from servico where serv_codigo = ?";
            pstm = con.prepareStatement(sql);
            pstm.setInt(1, serv);
            rs = pstm.executeQuery();
            servico = createServico(rs);
            return servico;
        } catch (SQLException | HeadlessException erro) {
            System.out.println("Serviço não encontrado" + erro.getMessage());
            return null;
        } finally {
            con.close();
            rs.close();
            pstm.close();
        }
    }
    
    private BeanServico createServico(ResultSet r) throws SQLException {
        while(rs.next()){           
            servico.setServ_cod(rs.getInt("serv_codigo"));
            servico.setServ_nome(rs.getString("serv_desc"));
            servico.setServ_status(rs.getString("serv_status"));
        }       
        return servico;
    }

}
