<%-- 
    Document   : cadServico
    Created on : 17/04/2017, 10:26:07
    Author     : VaiDiegoo
--%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.connection.Conexao"%>
<%@page import="model.Dao.DaoServico"%>
<%@page import="model.Bean.BeanServico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Cadastro Serviço | IBeautySalon</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="../../dist/css/skins/_all-skins.min.css">
  
  <style>
    .example-modal .modal {
      position: relative;
      top: auto;
      bottom: auto;
      right: auto;
      left: auto;
      display: block;
      z-index: 1;
    }

    .example-modal .modal {
      background: transparent !important;
    }
  </style>
  
    </head>
    <body>        
        <div class="wrapper">
<!-- /.example-modal -->
      <div class="example-modal ">
        <div class="modal">           
          <div class="modal-dialog"> 
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Cadastro de Serviços</h4>
              </div>
               <form action="../../ControllerServico" method="POST"> 
              <div class="modal-body">
                <div class="form-group">
                    <label>Serviço</label>
                    <input type="text" name="txtdesc" class="form-control" placeholder="Descrição">
                </div>
                  
              <div class="modal-footer">               
                  <button type="submit" value="cadastrar servico" class="btn btn-block btn-default btn-flat btn btn-primary pull-left">Salvar Serviço</button>                  
              </div>                
            </div>
            <!-- /.modal-content -->
               </form>            
                <div class="box">
            <div class="box-header">
              <h3 class="box-title">Serviços Ativos</h3>
            </div>
            <!-- /.box-header -->            
             <!-- /.Começa a div da tabela -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>                 
                  <th>Descrição</th>                  
                </tr>
                </thead>
                <tbody>
                     <%
                         BeanServico serv = new BeanServico();
                         DaoServico daoserv = new DaoServico();
                         Connection con=Conexao.getConnection();
                         Integer codServ;                         
                         ResultSet rs;
                         Statement stm;                        
                         PreparedStatement pstm;
                         String sql ="select *from servico where serv_status='ativo';";
                            pstm=con.prepareStatement(sql);
                            rs=pstm.executeQuery(sql);
                            rs.first();                                                       
                       if(rs.first()==false){
                    %>
                <tr>
                    <td colspan="6" align="center">
                        <b><%out.println("Não existem serviços cadastrados");%></b>
                        
                    </td>                    
                </tr>
                <%
                        }else{
                        do{
                    %>
                <tr>                 
                   <td ><%=rs.getString("serv_desc")%>
                </tr>
                                    <%
                        }while(rs.next());
}%>                                               
                </tbody>               
              </table>
            </div>
            <!-- /.box-body -->
          </div>
          </div>
          <!-- /.modal-dialog -->          
        </div>
        <!-- /.modal -->        
      </div>
      </div>  
        </div>
      <!-- ./wrapper -->
        <!-- jQuery 2.2.3 -->
       
<script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="../../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
    </body>
</html>
