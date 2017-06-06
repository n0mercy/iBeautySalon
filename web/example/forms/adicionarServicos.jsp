<%-- 
    Document   : AdicionarServicos
    Created on : 02/06/2017, 17:19:08
    Author     : n0mercy
--%>
<%@page import="model.Dao.DaoEmpresa"%>
<%@page import="model.Bean.BeanEmpresa"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="model.Dao.DaoOferece"%>
<%@page import="model.Bean.BeanOferece"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.Connection.Conexao"%>
<%@page import="model.Dao.DaoServico"%>
<%@page import="model.Bean.BeanServico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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

        <script src="../../bootstrap/js/validator.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $("input[type=checkbox]").change(function () {
                    calc();
                })
            });

            function calc() {
                $("input[type=checkbox]:checked").each(function () {

                });
            }
        </script>
    </head>
    <body>
        <%
            String param = request.getParameter("txtserv");
            List<BeanServico> listServ = new ArrayList<BeanServico>();
            List<BeanOferece> list = new ArrayList<BeanOferece>();
            BeanOferece ofe = new BeanOferece();
            BeanUsuario usuario = new BeanUsuario();
            BeanEmpresa emp = new BeanEmpresa();

            if (request.getSession().getAttribute("user") != null) {
                usuario = new DaoUsuario().findByUserSession(request.getSession().getAttribute("user").toString());
                emp = new DaoEmpresa().findByEmail(usuario.getUsu_email());
            }

            if (param != null && !param.trim().isEmpty() && request.getParameter("btnBuscar") != null) {
                listServ = new DaoServico().findServWithoutRelation(param, emp);
            }

            if (usuario.getUsu_codigo() > 0) {
                list = new DaoOferece().findOffersByEmpresa(emp.getEmp_cnpj(), null, false);
            }

            if (request.getParameter("ativar") != null) {
                int code = Integer.parseInt(request.getParameter("ativar"));
                if (code > 0) {
                    ofe = new BeanOferece();
                    ofe = new DaoOferece().findByCodigo(code);
                    ofe.setOfe_status("Ativo");
                    new DaoOferece().save(ofe);

                    if (usuario.getUsu_codigo() > 0) {
                        list = new DaoOferece().findOffersByEmpresa(emp.getEmp_cnpj(), null, false);
                    }
                }
            } else if (request.getParameter("desativar") != null) {
                int code = Integer.parseInt(request.getParameter("desativar"));
                if (code > 0) {
                    ofe = new BeanOferece();
                    ofe = new DaoOferece().findByCodigo(code);
                    ofe.setOfe_status("Desativado");
                    new DaoOferece().save(ofe);

                    if (usuario.getUsu_codigo() > 0) {
                        list = new DaoOferece().findOffersByEmpresa(emp.getEmp_cnpj(), null, false);
                    }
                }
            }

        %>
        <div class="wrapper">
            <!-- /.example-modal -->
            <div class="example-modal ">
                <div class="modal">           
                    <div class="modal-dialog"> 
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">Adicionar Serviços</h4>
                            </div>
                            <form action="adicionarServicos.jsp" method="POST"> 
                                <div class="login-box-body">
                                    <p class="login-box-msg">Preencha o nome do serviço abaixo</p>
                                    <div class="input-group input-group-sm">
                                        <input type="text" name="txtserv" class="form-control"></input>
                                        <span class="input-group-btn">
                                            <button type="submit" name="btnBuscar" class="btn btn-info btn-flat">Buscar</button>
                                        </span>                                            
                                    </div>
                                    <!-- /.col -->
                                </div>
                                <!-- /.modal-content -->
                            </form>            
                            <div class="box">
                                <%                                    if (listServ.size() > 0) {
                                %>
                                <div class="box-header">
                                    <h3 class="box-title">Serviços Econtrados</h3>
                                </div>
                                <!-- /.box-header -->            
                                <!-- /.Começa a div da tabela -->

                                <div class="box-body" class="form-group has-feedback">
                                    <form method="POST" action="../../ControllerServico" data-toggle="validator">
                                        <input type="hidden" name="page" value="adicionarServicos"/>
                                        <input type="hidden" name="empresa_cnpj" value="<%= emp.getEmp_cnpj()%>"/>
                                        <table id="example1" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>                 
                                                    <th> Descrição</th>  
                                                    <th>Status</th>  
                                                    <th>Valor</th>  
                                                    <th>Adicionar</th>      
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (BeanServico serv : listServ) {
                                                %>
                                                <tr>                 
                                                    <td><%= serv.getServ_nome()%></td>
                                                    <td><%= serv.getServ_status()%></td>
                                                    <td><input name="preco_servico" id="preco_servico"></td>
                                                    <td> 
                                                        <div class="checkbox icheck pull-right">
                                                            <label>
                                                                <input type="checkbox" value="<%= serv.getServ_cod()%>" id="selected_service" title="<%= serv.getServ_cod()%>" name="selected_services"/>  
                                                            </label>
                                                        </div>
                                                    </td>
                                                </tr>  
                                                <%
                                                    }
                                                %>
                                            </tbody>               
                                        </table>
                                        <span class="input-group-btn">
                                            <button type="submit" id="btnSubmit" name="btnSubmit" class="btn btn-block btn-default btn-flat btn btn-primary pull-left" >Salvar</button>
                                        </span> 
                                    </form>
                                </div>
                                <%
                                    }
                                %>
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Serviços Ativos</h3>
                                    </div>
                                    <!-- /.box-header -->            
                                    <!-- /.Começa a div da tabela -->
                                    <div class="box-body">
                                        <form method="POST" action="#">
                                            <table id="example1" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>                 
                                                        <th>Descrição</th> 
                                                        <th>Valor</th>  
                                                        <th>Status</th> 
                                                        <td colspan="3" align="center"><strong>Ações</strong></td>  
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        if (list.size() == 0) {
                                                    %>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                            <b><%out.println("Não existem serviços adicionados");%></b>
                                                        </td>                    
                                                    </tr>
                                                    <%
                                                    } else {
                                                        for (BeanOferece o : list) {
                                                    %>
                                                    <tr>                 
                                                        <td ><%= o.getOfe_serv_codigo().getServ_nome()%></td>
                                                        <td ><%= o.getOfe_valor()%></td>
                                                        <td><%= o.getOfe_status()%></td>
                                                        <%
                                                            if (o.getOfe_status().equals("Desativado")) {
                                                        %>
                                                        <td> 
                                                            <button type="submit" value="<%= o.getOfe_codigo()%>" name="ativar" class="btn btn-block btn-default btn-flat btn btn-primary pull-left">Ativar</button>
                                                        </td>
                                                        <%
                                                        } else {
                                                        %>
                                                        <td>
                                                            <button type="submit" value="<%= o.getOfe_codigo()%>" name="desativar" class="btn btn-block btn-default btn-flat btn btn-danger pull-left">Desativar</button>
                                                        </td>
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
