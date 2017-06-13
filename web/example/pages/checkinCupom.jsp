<%-- 
    Document   : checkinCupom
    Created on : 12/06/2017, 09:24:09
    Author     : n0mercy
--%>

<%@page import="model.Dao.DaoFuncionario"%>
<%@page import="model.Bean.BeanFuncionario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="model.Dao.DaoFones"%>
<%@page import="model.Bean.BeanFones"%>
<%@page import="model.Dao.DaoEmpresa"%>
<%@page import="model.Bean.BeanEmpresa"%>
<%@page import="model.Dao.DaoItemServico"%>
<%@page import="model.Dao.DaoCupom"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Bean.BeanItemServico"%>
<%@page import="model.Bean.BeanCupom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Checkin Cupom | IBeautySalon</title>
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
    <body class="hold-transition skin-blue sidebar-mini">
        <%
            BeanCupom cupom = new BeanCupom();
            BeanEmpresa emp = new BeanEmpresa();
            BeanFones fone = new BeanFones();
            BeanUsuario usuario = new BeanUsuario();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            List<BeanItemServico> list = new ArrayList<BeanItemServico>();
            List<BeanFuncionario> listFuncionario = new ArrayList<BeanFuncionario>();
            if (request.getSession().getAttribute("user") != null) {
                emp = new DaoEmpresa().findByEmail(request.getSession().getAttribute("user").toString());
                usuario = new DaoUsuario().findByUserSession(request.getSession().getAttribute("user").toString());
                fone = new DaoFones().findByUser(usuario.getUsu_codigo());
            }

            if (request.getParameter("buscar") != null && request.getParameter("txt_cupom") != null && !request.getParameter("txt_cupom").trim().isEmpty()) {
                List<BeanCupom> tmp = new ArrayList<BeanCupom>();
                tmp = new DaoCupom().findByEmpStatusCheck(emp.getEmp_cnpj(), request.getParameter("txt_cupom"));
                if (tmp.size() > 0) {
                    cupom = tmp.get(0);
                }
            } else {
                System.out.println("CUPOM NULL: " + cupom.getCupom_codigo());
            }

            listFuncionario = new DaoFuncionario().findByEmpresa(emp.getEmp_cnpj());
        %>
        <section class="invoice">
            <!-- title row -->
            <div class="row">
                <div class="col-xs-12">
                    <h2 class="page-header">
                        <i class="fa fa-globe"></i> IBeautySalon 
                        <small class="pull-right"><strong>Bem-Vindo:</strong> ${user}</small>
                    </h2>
                </div>
                <!-- /.col -->
            </div>
            <div class="login-box-body">
                <p class="login-box-msg">Pesquisar cupom</p>
                <form method="POST" action="#">
                    <div class="input-group input-group-sm">
                        <input type="text" name="txt_cupom" class="form-control">
                        <span class="input-group-btn">
                            <button type="submit" name="buscar" class="btn btn-info btn-flat">Buscar</button>
                        </span>                                            
                    </div>
                </form>
            </div>
            <%if (cupom.getCupom_clicpf() != null) {
                    list = new DaoItemServico().findItensByCupom(cupom.getCupom_codigo(), null);
            %>
            <form method="POST" action="../../ControllerCupom">
                <input type="hidden" name="cupom_id" value="<%=cupom.getCupom_codigo()%>"/>
                <div class="col-xs-12 table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Cod</th>
                                <th>Descrição</th>              
                                <th>Valor</th>                                
                            </tr>
                        </thead>
                        <%
                            if (list != null && list.size() > 0) {
                                for (BeanItemServico item : list) {
                        %>
                        <tbody>                            
                            <tr>
                                <td><%= item.getItemserv_codigo()%></td>
                                <td><%= item.getItemserv_ofe_cod().getOfe_serv_codigo().getServ_nome()%></td>
                                <td><%= item.getItemserv_ofe_cod().getOfe_valor()%></td>                                 
                            </tr>

                        </tbody>
                        <%
                                }
                            }
                        %>
                    </table>
                    <div class="row">
                        <!-- accepted payments column -->
                        <div class="col-xs-6">
                            <p class="lead">QR Code</p>
                            <img src="../../images/<%=cupom.getCupom_codigo()%>.png" alt=""/>
                        </div>
                        <!-- /.col -->
                        <div class="col-xs-6">
                            <p class="lead"><b>Data Compra:</b> <%= sdf.format(cupom.getCupom_data())%></p> 
                            <p class="lead"><b>Data Validade:</b> <%= sdf.format(cupom.getCupom_validade())%></p> 
                            <p class="lead"><b>Status:</b> <%= cupom.getCupom_status()%></p> 
                            <br>
                            <div class="table-responsive">
                                <div class="form-group">
                                    <label>Cliente</label>
                                    <input type="text" disabled="disabled" value="<%= cupom.getCupom_clicpf().getCli_nome()%>" class="form-control" placeholder="Nome"/>
                                </div>
                                <label>CPF</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-child"></i>
                                    </div>
                                    <input type="text" name="cpf" disabled="disabled" value="<%= cupom.getCupom_clicpf().getCli_cpf()%>" class="form-control"/>
                                </div> 
                                <label>Fone</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-phone"></i>
                                    </div>
                                    <input type="text" disabled="disabled" value="<%= fone.getFon_fones()%>" class="form-control"/>
                                </div> 
                                <div class="form-group">
                                    <label>Status do Cupom</label>
                                    <select class="form-control select2" name="status" style="width: 100%;">
                                        <%
                                        if(cupom.getCupom_status().equalsIgnoreCase("fechado")){
                                        %>
                                        <option selected="true" value="em espera">Em espera</option>                                         
                                        <option value="em atendimento">Em atendimento</option>
                                        <%
                                        }else if(cupom.getCupom_status().equalsIgnoreCase("em espera")){
                                        %>
                                        <option value="em atendimento">Em atendimento</option>
                                        <%
                                        }else{
                                        %>
                                        <option value="finalizado">Finalizar</option>
                                        <%
                                        }
                                        %>
                                    </select>
                                    <label>Funcionario</label>
                                    <select class="form-control select2" name="funcionario" style="width: 100%;">                                        
                                        <%
                                            for (BeanFuncionario f : listFuncionario) {
                                        %>
                                        <option selected="selected" value="<%= f.getFun_matricula()%>"><%= f.getFun_nome()%></option>                                         
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-btn">
                                        <button type="submit" name="salvar" class="btn btn-info btn-flat">Salvar</button>
                                    </span>                                            
                                </div>
                                    <br>
                                    <br>
                            </div>
                        </div>
                        <!-- /.col -->
                    </div>
                </div>
            </form>
            <%
            } else if (request.getParameter("buscar") != null && !request.getParameter("txt_cupom").trim().isEmpty() && list.size() == 0) {
            %>
            <span style="text-align: center"><% out.print("Nenhum cupom encontrado!"); %></span>
            <%
                }
            %>
    </body>
</html>
