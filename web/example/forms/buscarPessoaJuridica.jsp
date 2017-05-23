<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="model.Dao.DaoBairro"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Bean.BeanBairro"%>
<%@page import="model.Dao.DaoZona"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Dao.DaoCep"%>
<%@page import="model.Dao.DaoEndereco"%>
<%@page import="model.Dao.DaoFones"%>
<%@page import="model.Bean.BeanZona"%>
<%@page import="model.Bean.BeanFones"%>
<%@page import="model.Bean.BeanCep"%>
<%@page import="model.Bean.BeanEndereco"%>
<%@page import="model.Bean.BeanTipoUsuario"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="model.Dao.DaoEmpresa"%>
<%@page import="model.Bean.BeanEmpresa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <title>Buscar Pessoa Juridica | IBeautySalon</title>
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
                                        </head>

                                        <body  >
                                            <%
                                                BeanEmpresa emp = new BeanEmpresa();
                                                BeanUsuario user = new BeanUsuario();
                                                BeanEndereco end = new BeanEndereco();
                                                BeanCep cep = new BeanCep();
                                                BeanFones fone = new BeanFones();

                                                if (request.getParameter("search_cnpj") != null) {
                                                    emp = new DaoEmpresa().findByCnpj(request.getParameter("search_cnpj"));
                                                    user = new DaoUsuario().findByCodigo(emp.getEmp_usu_codigo().getUsu_codigo());
                                                    end = new DaoEndereco().findByCodigo(user.getUsu_end_codigo().getEnd_codigo());
                                                    cep = new DaoCep().findByCodigo(end.getEnd_cep().getCep_cep());
                                                    fone = new DaoFones().findByUser(user.getUsu_codigo());
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
                                                                    <h4 class="modal-title">Buscar Pessoa Juridica</h4>
                                                                </div>
                                                                <div class="form-group"> 
                                                                    <form method="POST" action="#">
                                                                        <label>Cnpj</label>
                                                                        <div class="input-group">
                                                                            <input type="text" class="form-control" name="search_cnpj" />                    <span class="input-group-btn">
                                                                                <button type="submit" class="btn btn-info btn-flat">Pesquisar</button>
                                                                            </span>                                            
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                                <div class="modal-body">                                                                    
                                                                    <form method="POST" action="../../ControllerCliente">
                                                                        <input type="hidden" name="save" value="buscarPessoaJuridica"/>
                                                                        <input type="hidden" name="usuario_id" value="<%= user.getUsu_codigo()%>"/>
                                                                        <div class="form-group">
                                                                            <label>Razão Social</label>
                                                                            <input type="text" disabled="disabled" name="razao" value="<%= emp.getEmp_razao() != null ? emp.getEmp_razao() : ""%>" class="form-control" placeholder="Razão">
                                                                        </div>
                                                                        <label>Cnpj</label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon">
                                                                                <i class="fa fa-university"></i>
                                                                            </div>
                                                                            <input type="text" name="inscestadual" name="cnpj" value="<%= emp.getEmp_cnpj() != null ? emp.getEmp_cnpj() : ""%>" disabled="disabled" class="form-control" data-inputmask="'insc estadual'" data-mask>
                                                                        </div>                                                
                                                                        <label>Inscrição Estadual</label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon">
                                                                                <i class="fa fa-building-o"></i>
                                                                            </div>
                                                                            <input type="text" name="inscestadual" name="inscestadual" value="<%= emp.getEmp_insc_estadual() != null ? emp.getEmp_insc_estadual() : ""%>" disabled="disabled" class="form-control" data-inputmask="'insc estadual'" data-mask>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Fones</label>

                                                                            <div class="input-group">
                                                                                <div class="input-group-addon">
                                                                                    <i class="fa fa-phone"></i>
                                                                                </div>
                                                                                <input type="text" class="form-control" disabled="disabled" name="telefone1" value="<%= fone.getFon_fones() != null ? fone.getFon_fones() : ""%>"/>
                                                                            </div>                                                           
                                                                        </div>                
                                                                        <!-- SELECT2 EXAMPLE -->
                                                                        <div class="box box-default">
                                                                            <div class="box-header with-border">
                                                                                <h3 class="box-title">Endereço</h3>

                                                                                <div class="box-tools pull-right">
                                                                                    <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>            
                                                                                </div>
                                                                            </div>
                                                                            <!-- /.box-header -->
                                                                            <div class="box-body">
                                                                                <div class="row">
                                                                                    <div class="col-md-6">              
                                                                                        <!-- /.form-group -->
                                                                                        <div class="form-group">
                                                                                            <label>Referência</label>
                                                                                            <input type="text" class="form-control" name="ref" value="<%= end.getEnd_ref() != null ? end.getEnd_ref() : ""%>" disabled="disabled" placeholder="Ponto de Referência">
                                                                                        </div>

                                                                                        <div class="form-group">
                                                                                            <label>Número</label>
                                                                                            <input type="text" class="form-control" name="numero" value="<%= end.getEnd_num() != null ? end.getEnd_num() : ""%>" disabled="disabled" placeholder="N°">
                                                                                        </div>
                                                                                        <!-- /.form-group -->
                                                                                    </div>
                                                                                    <!-- /.col -->
                                                                                    <div class="col-md-6">
                                                                                        <div class="form-group">
                                                                                            <label>Bairro</label>
                                                                                            <select class="form-control select2" disabled="disabled" name="bairro" style="width: 100%;">                                                                                                
                                                                                                <option selected="selected"><%= cep.getCep_cep() != null ? cep.getCep_bai_codigo().getBai_nome() : ""%></option>                                                                                                  
                                                                                            </select>
                                                                                        </div>

                                                                                        <div class="form-group">
                                                                                            <label>Zona</label>
                                                                                            <select class="form-control select2" name="zona" disabled="disabled" style="width: 100%;">                                                                                                
                                                                                                <option selected="selected"><%= cep.getCep_cep() != null ? cep.getCep_bai_codigo().getBai_zona_cod().getZona_nome() : ""%></option>                                                                                                  
                                                                                            </select>
                                                                                        </div>            
                                                                                        <!-- /.form-group -->

                                                                                    </div>
                                                                                    <div class="form-group">
                                                                                        <div class="form-group">
                                                                                            <label>Rua</label>
                                                                                            <input type="text" class="form-control" name="rua" value="<%= cep.getRua() != null ? cep.getRua() : ""%>"  disabled="disabled" placeholder="Rua"/>
                                                                                        </div>

                                                                                    </div>
                                                                                    <!-- /.col -->            
                                                                                </div>
                                                                                <!-- /.row -->
                                                                            </div>
                                                                            <!-- /.box-body -->        
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="exampleInputEmail1">Email</label>
                                                                            <input type="email" class="form-control" disabled="disabled" name="email" value="<%= user.getUsu_email() != null ? user.getUsu_email() : ""%>" id="exampleInputEmail1" placeholder="Email">
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Status</label>
                                                                            <select class="form-control select2" name="status" style="width: 100%;">
                                                                                <%if (user.getUsu_status() != null) {
                                                                                        System.out.println(user.getUsu_status());
                                                                                        if (user.getUsu_status().equals("Ativo")) {
                                                                                %>                                                                            
                                                                                <option selected value="Ativo">Ativo</option>
                                                                                <option value="Desativado">Desativado</option>
                                                                                <% } else {%>
                                                                                <option value="Ativo">Ativo</option>
                                                                                <option selected value="Desativado">Desativado</option>
                                                                                <%
                                                                                        }
                                                                                    }%>
                                                                            </select>
                                                                        </div>
                                                                        <div class="modal-footer">               
                                                                            <button type="submit" class="btn btn-block btn-default btn-flat btn btn-primary pull-left">Salvar Empresa</button>                               
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>

                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>
                                                    <!-- /.modal-dialog -->
                                                </div>
                                                <!-- /.modal -->
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
