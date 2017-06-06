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
                <title>Serviços do Salão | IBeautySalon</title>
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

                                        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
                                        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
                                        <!--[if lt IE 9]>
                                        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
                                        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
                                        <![endif]-->

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
                                        </head>

                                        <body  >

                                            <div class="wrapper">
                                                <!-- /.example-modal -->

                                                <div class="example-modal ">
                                                    <div class="modal">           
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span></button>
                                                                    <h4 class="modal-title">Salão</h4>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <div class="form-group">
                                                                        <label>Nome</label>
                                                                        <input type="text" disabled="disabled" class="form-control" placeholder="Razão">
                                                                    </div>
                                                                    <label>Bairro</label>
                                                                    <div class="input-group">
                                                                        <div class="input-group-addon">
                                                                            <i class="fa fa-university"></i>
                                                                        </div>
                                                                        <input type="text" disabled="disabled" name="bairro" class="form-control">
                                                                    </div>                                                
                                                                    <label>Rua</label>
                                                                    <div class="input-group">
                                                                        <div class="input-group-addon">
                                                                            <i class="fa fa-building-o"></i>
                                                                        </div>
                                                                        <input type="text" disabled="disabled" name="rua" class="form-control" >
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label>Fones</label>

                                                                        <div class="input-group">
                                                                            <div class="input-group-addon">
                                                                                <i class="fa fa-phone"></i>
                                                                            </div>
                                                                            <input type="text" disabled="disabled" class="form-control" data-inputmask='"mask": "(92) 99999-9999"' data-mask>

                                                                                <input type="text" disabled="disabled" class="form-control" data-inputmask='"mask": "(92) 99999-9999"' data-mask>
                                                                                    </div>                                                           
                                                                                    </div>
                                                                                    <div class="modal-footer">               
                                                                                        <button type="button" class="btn btn-block btn-default btn-flat btn btn-primary  pull-left">LISTA DE ATENDIMENTO EM TEMPO REAL</button>                               
                                                                                    </div>
                                                                                    <div class="box-header with-border">
                                                                                        <h3 class="box-title">Serviços</h3>        
                                                                                    </div>
                                                                                    <div class="box-body">
                                                                                        <table id="example1" class="table table-bordered table-striped">
                                                                                            <thead>
                                                                                                <tr>                 
                                                                                                    <th>Descrição</th>
                                                                                                    <th>Valor</th>
                                                                                                    <th>Adicionar</th>                  
                                                                                                </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                                <%
                                                                                                    BeanServico serv = new BeanServico();
                                                                                                    DaoServico daoserv = new DaoServico();
                                                                                                    Connection con = Conexao.getConnection();
                                                                                                    Integer codServ;
                                                                                                    ResultSet rs;
                                                                                                    Statement stm;
                                                                                                    PreparedStatement pstm;
                                                                                                    String sql = "select *from servico where serv_status = 'ativo';";
                                                                                                    pstm = con.prepareStatement(sql);
                                                                                                    rs = pstm.executeQuery(sql);
                                                                                                    rs.first();
                                                                                                    if (rs.first() == false) {
                                                                                                %>
                                                                                                <tr>
                                                                                                    <td colspan="6" align="center">
                                                                                                        <b><%out.println("Não existem serviços cadastrados");%></b>

                                                                                                    </td>                    
                                                                                                </tr>
                                                                                                <%
                                                                                                } else {
                                                                                                    do {
                                                                                                %>
                                                                                                <tr>                 
                                                                                                    <td ><%=rs.getString("serv_desc")%>
                                                                                                        <td ><%=rs.getString("serv_desc")%>
                                                                                                            <td> <input type="submit" value="Adicionar" name="Adicionar" class="btn btn-block btn-default btn-flat btn btn-primary pull-left" /> </td>
                                                                                                            </tr>
                                                                                                            <%
                                                                                                                    } while (rs.next());
                                                                                                                }%>                                               
                                                                                                            </tbody>               
                                                                                                            </table>
                                                                                                            </div>    
                                                                                                            </div>
                                                                                                            </div>
                                                                                                            <div class="modal-footer">                   
                                                                                                                <button type="button" class="fa fa-shopping-cart btn btn-block btn-default btn-flat btn btn-success pull-left"> CARRINHO</button>                               
                                                                                                            </div>

                                                                                                            </div>
                                                                                                            <!-- /.modal-content -->
                                                                                                            </div>
                                                                                                            <!-- /.modal-dialog -->
                                                                                                            </div>
                                                                                                            <!-- /.modal -->
                                                                                                            </div>

                                                                                                            </body>
                                                                                                            </html>
