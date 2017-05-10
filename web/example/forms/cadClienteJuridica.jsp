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
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <title>Cadastro Empresa | IBeautySalon</title>
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
                                        DaoEmpresa daoemp = new DaoEmpresa();
                                        Connection con = Conexao.getConnection();
                                        String usuario = null;
                                        ResultSet rs;
                                        String sql = null;
                                        PreparedStatement pstm;
                                        if(request.getSession().getAttribute("user") != null){
                                            usuario = request.getSession().getAttribute("user").toString();
                                        }
                                        if (usuario != null) {
                                            sql = "select * from empresa_usuario inner join "
                                                    + "usuario on emp_usu_codigo = usu_codigo left join "
                                                    + "fones on fone_usu_codigo = usu_codigo inner join "
                                                    + "tipo_usuario on usu_tipo_codigo= tipo_codigo inner join "
                                                    + "endereco on usu_end_cep = end_codigo inner join "
                                                    + "cep on end_cep= cep_cep inner join "
                                                    + "bairro on cep_bai_codigo=bai_codigo inner join "
                                                    + "zona on bai_zona_cod=zona_cod "
                                                    + "where usu_status='Ativo' and usu_email = '" + usuario + "';";
                                        } else {
                                            out.println("Usuario nulo");
                                        }
                                        pstm = con.prepareStatement(sql);
                                        rs = pstm.executeQuery(sql);
                                        rs.first();
                                        if (rs.first() == false) {
                                                out.println("Error");
                                        } else {
                                            do {
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
                                                            <h4 class="modal-title">Cadastro Pessoa Jurídica</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="form-group">
                                                                <label>Razão Social</label>
                                                                <input type="text" value="<%=rs.getString("emp_razao")%>"  class="form-control" placeholder="Razão"/>
                                                            </div>
                                                            <label>Cnpj</label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon">
                                                                    <i class="fa fa-university"></i>
                                                                </div>
                                                                <input type="text" name="inscestadual" value="<%=rs.getString("emp_cnpj")%>" class="form-control"  data-inputmask="'insc estadual'" data-mask/>
                                                            </div>                                                
                                                            <label>Inscrição Estadual</label>
                                                            <div class="input-group">
                                                                <div class="input-group-addon">
                                                                    <i class="fa fa-building-o"></i>
                                                                </div>
                                                                <input type="text" name="inscestadual" value="<%=rs.getString("emp_insc_estadual")%>" class="form-control"  data-inputmask="'insc estadual'" data-mask>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Fones</label>

                                                                <div class="input-group">
                                                                    <div class="input-group-addon">
                                                                        <i class="fa fa-phone"></i>
                                                                    </div>
                                                                    <input type="text" class="form-control" value="<%=rs.getString("fon_fones")%>"  data-inputmask='"mask": "(92) 99999-9999"' data-mask/>

                                                                    <input type="text" class="form-control" data-inputmask='"mask": "(92) 99999-9999"' data-mask/>
                                                                </div>                                                           
                                                            </div>
                                                            <div class="form-group">                
                                                                <label>Cep</label>
                                                                <div class="input-group">
                                                                    <input type="text"  class="form-control" value="<%=rs.getString("cep_cep")%>" data-inputmask='"mask": "99999-999"' data-mask/>                    <span class="input-group-btn">
                                                                        <button type="button" class="btn btn-info btn-flat">Buscar</button>
                                                                    </span>                                            
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
                                                                                <input type="text" value="<%=rs.getString("end_ref")%>" class="form-control" placeholder="Ponto de Referência"/>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <label>Número</label>
                                                                                <input type="text" class="form-control" value="<%=rs.getString("end_num")%>" placeholder="N°"/>
                                                                            </div>
                                                                            <!-- /.form-group -->
                                                                        </div>
                                                                        <!-- /.col -->
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <label>Bairro</label>
                                                                                <select class="form-control select2" disabled="disabled" style="width: 100%;">
                                                                                    <option selected="selected">Compensa 1</option>
                                                                                    <option>Alvorada</option>
                                                                                    <option>Colonia</option>                  
                                                                                </select>
                                                                            </div>

                                                                            <div class="form-group">
                                                                                <label>Zona</label>
                                                                                <select class="form-control select2" disabled="disabled" style="width: 100%;">
                                                                                    <option selected="selected">Oeste</option>
                                                                                    <option>Norte</option>
                                                                                    <option>Sul</option>                  
                                                                                </select>
                                                                            </div>            
                                                                            <!-- /.form-group -->

                                                                        </div>
                                                                        <div class="form-group">
                                                                            <div class="form-group">
                                                                                <label>Rua</label>
                                                                                <input type="text" value="<%=rs.getString("cep_rua")%>" class="form-control" disabled="disabled" placeholder="Rua">
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
                                                                <input type="email" class="form-control" value="<%=rs.getString("usu_email")%>" id="exampleInputEmail1" placeholder="Email"/>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="exampleInputPassword1">Senha</label>
                                                                <input type="password" class="form-control" value="<%=rs.getString("usu_senha")%>" id="exampleInputPassword1" placeholder="Senha"/>
                                                            </div>     
                                                            <div class="form-group">
                                                                <label for="exampleInputPassword1">Confirmar Senha</label>
                                                                <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Senha">
                                                            </div>    
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">               
                                                        <button type="button" class="btn btn-block btn-default btn-flat btn btn-primary pull-left">Salvar Empresa</button>                               
                                                    </div>

                                                </div>
                                                <!-- /.modal-content -->
                                            </div>
                                            <!-- /.modal-dialog -->
                                        </div>
                                        <!-- /.modal -->
                                    </div>
                                    <%
                                                                                    } while (rs.next());
                                                                                }%> 
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
