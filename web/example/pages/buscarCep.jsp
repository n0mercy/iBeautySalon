<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.connection.Conexao"%>
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
                                                            <th>Complemento</th> 
                                                            <th>Rua</th>
                                                            <th>Bairro</th>
                                                            <th>Referência</th>
                                                            <th>Ações</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            BeanEmpresa emp = new BeanEmpresa();
                                                            DaoEmpresa daoemp = new DaoEmpresa();
                                                            Connection con = Conexao.getConnection();
                                                            Integer codEmp;
                                                            String cep = null;
                                                            ResultSet rs;
                                                            Statement stm;
                                                            String sql = null;
                                                            PreparedStatement pstm;
                                                            //Se for diferente de nulo e for digitado algo no campo de busca
                                                            if (request.getParameter("txtcep") != null && !request.getParameter("txtcep").trim().isEmpty()) {
                                                                cep = request.getParameter("txtcep");
                                                                sql = "select * from empresa_usuario inner join "
                                                                        + "usuario on emp_usu_codigo = usu_codigo left join "
                                                                        + "fones on fone_usu_codigo = usu_codigo inner join "
                                                                        + "tipo_usuario on usu_tipo_codigo= tipo_codigo inner join "
                                                                        + "endereco on usu_end_cep = end_codigo inner join "
                                                                        + "cep on end_cep= cep_cep inner join "
                                                                        + "bairro on cep_bai_codigo=bai_codigo inner join "
                                                                        + "zona on bai_zona_cod=zona_cod "
                                                                        + "where usu_status='Ativo' and cep.cep_cep = " + cep + "";
                                                            } else {
                                                                sql = "select * from empresa_usuario inner join "
                                                                        + "usuario on emp_usu_codigo = usu_codigo left join "
                                                                        + "fones on fone_usu_codigo = usu_codigo inner join "
                                                                        + "tipo_usuario on usu_tipo_codigo= tipo_codigo inner join "
                                                                        + "endereco on usu_end_cep = end_codigo inner join "
                                                                        + "cep on end_cep= cep_cep inner join "
                                                                        + "bairro on cep_bai_codigo=bai_codigo inner join "
                                                                        + "zona on bai_zona_cod=zona_cod  where usu_status='Ativo';";
                                                            }
                                                            pstm = con.prepareStatement(sql);
                                                            rs = pstm.executeQuery(sql);
                                                            rs.first();
                                                            if (rs.first() == false) {
                                                        %>
                                                        <tr>
                                                            <td colspan="6" align="center">
                                                                <b><%out.println("Não existem empresas cadastrados");%></b>

                                                            </td>                    
                                                        </tr>
                                                        <%
                                                        } else {
                                                            do {
                                                        %>
                                                        <form style="display: hidden" action="../forms/cadClienteJuridica.jsp" method="POST" id="form">
                                                        <tr>                 
                                                            <td ><%=rs.getString("emp_razao")%></td>
                                                                <td ><%=rs.getString("end_compl")%></td>
                                                                    <td ><%=rs.getString("cep_rua")%></td>
                                                                        <td ><%=rs.getString("bai_nome")%></td>
                                                                            <td ><%=rs.getString("end_ref")%></td>
                                                                                <td>
                                                                                    <span class="input-group-btn">
                                                                                        <!-- /bloco desativado -->
                                                                                        <button type="button" name="btn_edit" class="btn btn-danger btn-sm">Alterar</button> 
                                                                                        <input type="hidden" id="cep" name="cep" value="<%=rs.getString("emp_razao")%>"/>
                                                                                        <input type="hidden" id="cnpj" name="cnpj" value="<%=rs.getString("emp_cnpj")%>"/>
                                                                                        <input type="hidden" id="insc_estadual" name="insc_estadual" value="<%=rs.getString("emp_insc_estadual")%>"/>
                                                                                        <input type="hidden" id="fones" name="fones" value="<%=rs.getString("fon_fones")%>"/>
                                                                                    </span>
                                                                                </td>
                                                                                </tr> 
                                                        </form>
                                                                                <%
                                                                                        } while (rs.next());
                                                                                    }%>                                               
                                                                                </tbody>               
                                                                                </table>
                                                                                </div>
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

                                                                                </body>
                                                                                </html>
