<%@page import="model.Dao.DaoCliente"%>
<%@page import="model.Bean.BeanCliente"%>
<%@page import="model.Bean.BeanEndereco"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.Connection.Conexao"%>
<%@page import="model.Dao.DaoEmpresa"%>
<%@page import="model.Bean.BeanEmpresa"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" charset="utf-8" content="IE=edge"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <title>Buscar Salão | IBeautySalon</title>
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
                                <!-- iCheck -->
                                <link rel="stylesheet" href="../../plugins/iCheck/square/blue.css">

                                    <link jsf:library="bootstrap" jsf:name="bootstrap.min.css" />

                                    <!-- jQuery 2.2.3 -->
                                    <script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
                                    <!-- Bootstrap 3.3.6 -->
                                    <script src="../../bootstrap/js/bootstrap.min.js"></script>
                                    <!-- iCheck -->
                                    <script src="../../plugins/iCheck/icheck.min.js"></script>
                                    <script>
                                        $(function () {
                                            $('input').iCheck({
                                                checkboxClass: 'icheckbox_square-blue',
                                                radioClass: 'iradio_square-blue',
                                                increaseArea: '20%' // optional
                                            });
                                        });
                                    </script>
                                    </head>
                                    <body>
                                        <div class="login-box">
                                            <div class="login-logo">
                                                <a href="../../index2.html"><b>IBeauty</b>Salon</a>
                                            </div>
                                            <!-- /.login-logo -->
                                            <div class="login-box-body">
                                                <p class="login-box-msg">Preencha o seu cep abaixo</p>
                                                <form method="GET" action="buscarCep.jsp">
                                                    <div class="input-group input-group-sm">
                                                        <input type="text" name="txtcep" class="form-control">
                                                            <span class="input-group-btn">
                                                                <button type="submit" class="btn btn-info btn-flat">Buscar</button>
                                                            </span>                                            
                                                    </div>
                                                </form>
                                                <!-- /.col -->
                                            </div>   
                                        </div>
                                        <!-- /.login-box-body -->
                                        </div>  <!-- /.Começa a div da tabela -->
                                        <div class="box-body">
                                            <table id="example1" class="table table-bordered table-striped">
                                                <thead>
                                                    <tr>                 
                                                        <th>Nome</th>
                                                        <th>Cep</th> 
                                                        <th>Rua</th>
                                                        <th>Bairro</th>
                                                        <th>Referência</th>
                                                        <th>Ações</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        BeanEmpresa emp = new BeanEmpresa();
                                                        List<BeanEmpresa> listEmpresa = new ArrayList<BeanEmpresa>();
                                                        BeanCliente cliente = new BeanCliente();
                                                        BeanEndereco endereco = new BeanEndereco();
                                                        String cep = null;
                                                        if(request.getSession().getAttribute("user") != null){
                                                            String user = request.getSession().getAttribute("user").toString();
                                                            cliente = new DaoCliente().findByCupomPendente(user);
                                                        }
                                                        //Se for diferente de nulo e for digitado algo no campo de busca
                                                        if (request.getParameter("txtcep") != null && !request.getParameter("txtcep").trim().isEmpty()){
                                                            cep = request.getParameter("txtcep");
                                                            listEmpresa = new DaoEmpresa().findEmpresasByCEP(cep);
                                                        }else{
                                                            if(cliente.getCli_cpf() != null){
                                                                System.out.println("CPF pendente not null: "+cliente.getCli_cpf());
                                                                listEmpresa = new DaoEmpresa().findByCpfStatusPendente(cliente.getCli_cpf());
                                                            }else{
                                                                System.out.println("CPF pendente Nulo");
                                                                listEmpresa = new DaoEmpresa().findAllEmpresas();
                                                            }
                                                        }
                                                        if (listEmpresa.size() == 0) {
                                                    %>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                            <b><%out.println("Não existem empresas cadastrados");%></b>

                                                        </td>                    
                                                    </tr>
                                                    <%
                                                    } else {
                                                        for(BeanEmpresa e: listEmpresa){
                                                    %>
                                                    <form style="display: hidden" action="../forms/cadClienteJuridica.jsp" method="POST" id="form">
                                                        <tr>                 
                                                            <td ><%= e.getEmp_razao() %></td>
                                                            <td ><%= e.getEmp_usu_codigo().getUsu_end_codigo().getEnd_cep().getCep_cep() %></td>
                                                            <td ><%= e.getEmp_usu_codigo().getUsu_end_codigo().getEnd_cep().getRua() %></td>
                                                            <td ><%= e.getEmp_usu_codigo().getUsu_end_codigo().getEnd_cep().getCep_bai_codigo().getBai_nome() %></td>
                                                            <td ><%= e.getEmp_usu_codigo().getUsu_end_codigo().getEnd_ref() %></td>
                                                            <td>
                                                                <span class="input-group-btn">
                                                                    <!-- /bloco desativado -->
                                                                    <button type="button" name="btn_edit" class="btn btn-danger btn-sm" onClick="href:location = '../forms/itensSalao.jsp?sValue=<%= e.getEmp_cnpj() %>'">Selecionar</button>                                                                                        
                                                                </span>
                                                            </td>
                                                        </tr> 
                                                    </form>
                                                    <%
                                                            }
                                                        }%>                                               
                                                </tbody>               
                                            </table>
                                        </div>


                                    </body>
                                    </html>
