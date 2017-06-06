<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Connection.Conexao"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.Connection.Conexao"%>
<%@page import="model.Dao.DaoServico"%>
<%@page import="model.Bean.BeanServico"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <title>Buscar Serviço | IBeautySalon</title>
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
                                                                    <h4 class="modal-title">Buscar de Serviços</h4>
                                                                </div>
                                                                <form action="buscarServico.jsp" method="POST"> 
                                                                    <div class="login-box-body">
                                                                        <p class="login-box-msg">Preencha o nome do serviço abaixo</p>
                                                                        <div class="input-group input-group-sm">
                                                                            <input type="text" name="txtserv" class="form-control"></input>
                                                                            <span class="input-group-btn">
                                                                                <button type="submit" class="btn btn-info btn-flat">Buscar</button>
                                                                            </span>                                            
                                                                        </div>
                                                                        <!-- /.col -->
                                                                    </div>
                                                                    <!-- /.modal-content -->
                                                                </form>            
                                                                <div class="box">
                                                                    <div class="box-header">
                                                                        <h3 class="box-title">Serviços Cadastrados</h3>
                                                                    </div>
                                                                    <!-- /.box-header -->            
                                                                    <!-- /.Começa a div da tabela -->
                                                                    <div class="box-body">
                                                                        <form method="POST" action="#">
                                                                            <table id="example1" class="table table-bordered table-striped">
                                                                                <thead>
                                                                                    <tr>                 
                                                                                        <th> Descrição</th>  
                                                                                        <th>Status</th>  
                                                                                        <th>Ações</th>      
                                                                                    </tr>
                                                                                </thead>
                                                                                <tbody>
                                                                                    <%
                                                                                        BeanServico serv = new BeanServico();
                                                                                        List<BeanServico> list = new ArrayList<BeanServico>();
                                                                                        if (request.getParameter("txtserv") == null) {
                                                                                            list = new DaoServico().findAll();
                                                                                        } else {
                                                                                            list = new DaoServico().findByDescricao(request.getParameter("txtserv"));
                                                                                        }

                                                                                        if (request.getParameter("ativar") != null) {
                                                                                            int servCode = Integer.parseInt(request.getParameter("ativar"));
                                                                                            if (servCode > 0) {
                                                                                                serv = new BeanServico();
                                                                                                serv = new DaoServico().findByCodigo(servCode);
                                                                                                serv.setServ_status("Ativo");
                                                                                                new DaoServico().alterarStatusServico(serv);
                                                                                                list = new DaoServico().findAll();
                                                                                            }
                                                                                        } else if (request.getParameter("desativar") != null) {
                                                                                            int servCode = Integer.parseInt(request.getParameter("desativar"));
                                                                                            if (servCode > 0) {
                                                                                                serv = new BeanServico();
                                                                                                serv = new DaoServico().findByCodigo(servCode);
                                                                                                serv.setServ_status("Desativado");
                                                                                                new DaoServico().alterarStatusServico(serv);
                                                                                                list = new DaoServico().findAll();
                                                                                            }
                                                                                        }                                                                                       
                                                                                        
                                                                                        if (list.size() == 0) {
                                                                                    %>
                                                                                    <tr>
                                                                                        <td colspan="6" align="center">
                                                                                            <b><%out.println("Não existem serviços cadastrados");%></b>

                                                                                        </td>                    
                                                                                    </tr>                    
                                                                                    <%
                                                                                    } else {
                                                                                        for(BeanServico s: list){
                                                                                    %>
                                                                                    <tr>                 
                                                                                        <td ><%= s.getServ_nome() %></td>
                                                                                        <td><%= s.getServ_status() %></td>
                                                                                        <%
                                                                                        if(s.getServ_status().equals("Desativado")){
                                                                                        %>
                                                                                        <td> <button type="submit" value="<%= s.getServ_cod() %>" name="ativar" class="btn btn-block btn-default btn-flat btn btn-primary pull-left" />Ativar</td>
                                                                                        <%
                                                                                        }else{                                                                                            
                                                                                        %>
                                                                                        <td> <button type="submit" value="<%= s.getServ_cod()%>" name="desativar" class="btn btn-block btn-default btn-flat btn btn-danger pull-left" />Desativar</td>
                                                                                        <%
                                                                                        }
                                                                                        %>
                                                                                    </tr>
                                                                                    <%
                                                                                        }
                                                                                    }%>                                               
                                                                                </tbody>               
                                                                            </table>
                                                                        </form>
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

                                        </body>
                                        </html>
