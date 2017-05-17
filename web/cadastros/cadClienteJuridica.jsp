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
            <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
                <!-- Font Awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
                    <!-- Ionicons -->
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
                        <!-- Theme style -->
                        <link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
                            <!-- AdminLTE Skins. Choose a skin from the css/skins
                                 folder instead of downloading all of them to reduce the load. -->
                            <link rel="stylesheet" href="../dist/css/skins/_all-skins.min.css">

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
                                        BeanZona zona = new BeanZona();
                                        Connection con = Conexao.getConnection();
                                        String usuario = null;
                                        ResultSet rs;
                                        String sql = null;
                                        PreparedStatement pstm;
                                        if (request.getSession().getAttribute("user") != null) {
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
                                        }

                                        if (sql != null) {
                                            pstm = con.prepareStatement(sql);
                                            rs = pstm.executeQuery(sql);
                                            rs.first();

                                            if (rs.first() == false) {
                                                out.println("Error ao pegar user da session");
                                            } else {
                                                do {
                                                    emp = new DaoEmpresa().findByCnpj(rs.getString("emp_cnpj"));
                                                    user = new DaoUsuario().findByCodigo(rs.getInt("emp_usu_codigo"));
                                                    fone = new DaoFones().findByUser(rs.getInt("usu_codigo"));

                                                    if (request.getParameter("cep") != null) {
                                                        cep = new DaoCep().findByCodigo(Integer.parseInt(request.getParameter("cep")));
                                                        end = new DaoEndereco().findByCep(cep.getCep_cep());
                                                        out.println("1");
                                                    } else {
                                                        cep = new DaoCep().findByCodigo(rs.getInt("end_cep"));
                                                        end = new DaoEndereco().findByCep(rs.getString("end_cep"));
                                                        out.println("2");
                                                    }
                                                    zona = new DaoZona().findByCodigo(rs.getInt("bai_zona_cod"));
                                                } while (rs.next());

                                            }

                                        }
                                    %>
                                    <div class="wrapper">
                                        <!-- /.example-modal -->
                                        <form data-toggle="validator" role="form">
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
                                                                    <input type="text" name="razao" value="<%= (emp.getEmp_razao() != null) ? emp.getEmp_razao() : ""%>"  class="form-control" placeholder="Razão"/>
                                                                </div>
                                                                <label>Cnpj</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon">
                                                                        <i class="fa fa-university"></i>
                                                                    </div>
                                                                    <input type="text" placeholder="Cnpj" name="cnpj" value="<%= emp.getEmp_razao() != null ? emp.getEmp_razao() : ""%>" class="form-control"  data-inputmask="'insc estadual'" data-mask/>
                                                                </div>                                                
                                                                <label>Inscrição Estadual</label>
                                                                <div class="input-group">
                                                                    <div class="input-group-addon">
                                                                        <i class="fa fa-building-o"></i>
                                                                    </div>
                                                                    <input type="text" name="inscestadual" value="<%=emp.getEmp_insc_estadual() != null ? emp.getEmp_insc_estadual() : ""%>" placeholder="Inscrição Estadual" class="form-control"  data-inputmask="'insc estadual'" data-mask>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Fones</label>

                                                                    <div class="input-group">
                                                                        <div class="input-group-addon">
                                                                            <i class="fa fa-phone"></i>
                                                                        </div>
                                                                        <input type="text" name="telefone1" placeholder="Phone 1" class="form-control" value="<%= fone.getFon_fones() != null ? fone.getFon_fones() : ""%>"  data-inputmask='"mask": "(92) 99999-9999"' data-mask/>

                                                                        <input type="text" name="telefone2" placeholder="Phone 2" class="form-control" data-inputmask='"mask": "(92) 99999-9999"' data-mask/>
                                                                    </div>                                                           
                                                                </div>
                                                                <div class="form-group">                
                                                                    <label>Cep</label>
                                                                    <div class="input-group">
                                                                        <form method="GET" action="cadClienteJuridica.jsp">
                                                                            <input type="text" placeholder="Cep" class="form-control" name="cep" value="<%= cep.getCep_cep() != null ? cep.getCep_cep() : ""%>" data-inputmask='"mask": "99999-999"' data-mask/><span class="input-group-btn">
                                                                                <button type="submit" class="btn btn-info btn-flat">Buscar</button>
                                                                            </span> 
                                                                        </form>
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
                                                                                    <input type="text" name="ref" value="<%= end.getEnd_ref() != null ? end.getEnd_ref() : ""%>" class="form-control" placeholder="Ponto de Referência"/>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label>Número</label>
                                                                                    <input type="text" name="numero" class="form-control" value="<%= end.getEnd_num() != null ? end.getEnd_num() : ""%>" placeholder="N°"/>
                                                                                </div>
                                                                                <!-- /.form-group -->
                                                                            </div>
                                                                            <!-- /.col -->
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label>Bairro</label>
                                                                                    <select name="bairro" class="form-control select2" style="width: 100%;">
                                                                                        <%
                                                                                            List<BeanBairro> bairros = new ArrayList<BeanBairro>();
                                                                                            bairros = new DaoBairro().findAll();
                                                                                            for (BeanBairro b : bairros) {
                                                                                        %>
                                                                                        <option value="<%= b.getBai_codigo()%>" selected="selected"><%= b.getBai_nome()%></option>               
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                    </select>
                                                                                </div>

                                                                                <div class="form-group">
                                                                                    <label>Zona</label>
                                                                                    <select name="zona" class="form-control select2" style="width: 100%;">
                                                                                        <%
                                                                                            List<BeanZona> zonas = new ArrayList<BeanZona>();
                                                                                            zonas = new DaoZona().findAll();
                                                                                            for (BeanZona z : zonas) {
                                                                                        %>
                                                                                        <option value="<%= z.getZona_cod()%>" selected="selected"><%= z.getZona_nome()%></option>               
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                    </select>
                                                                                </div>            
                                                                                <!-- /.form-group -->

                                                                            </div>
                                                                            <div class="form-group">
                                                                                <div class="form-group">
                                                                                    <label>Rua</label>
                                                                                    <input type="text" name="rua" value="<%= cep.getRua() != null ? cep.getRua() : ""%>" class="form-control" placeholder="Rua">
                                                                                </div>

                                                                            </div>
                                                                            <!-- /.col -->            
                                                                        </div>
                                                                        <!-- /.row -->
                                                                    </div>
                                                                    <!-- /.box-body -->        
                                                                </div>
                                                                <div class="form-group has-feedback">
                                                                    <label for="exampleInputEmail1">Email</label>
                                                                    <input type="email" class="form-control" name="email" value="<%= user.getUsu_email() != null ? user.getUsu_email() : ""%>" id="exampleInputEmail1" placeholder="Email"/>                                                                    
                                                                    
                                                                </div>
                                                                <div class="form-group has-feedback">
                                                                    <label for="exampleInputPassword1">Senha</label>
                                                                    <input type="password" data-minlength="6" required class="form-control" name="senha" value="<%= user.getUsu_senha() != null ? user.getUsu_senha() : ""%>" id="exampleInputPassword1" placeholder="Senha"/>
                                                                    <div class="help-block">Minimum of 6 characters</div>
                                                                </div>     
                                                                <div class="form-group has-feedback">
                                                                    <label for="exampleInputPassword1">Confirmar Senha</label>
                                                                    <input type="password" class="form-control" name="senha2"  data-match="#exampleInputPassword1" data-match-error="Pera viado, senhas estão diferentes :D" id="exampleInputPasswordConfirm" required placeholder="Senha"/>
                                                                    <div class="help-block with-errors"></div>
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
                                        </form>
                                        <!-- /.modal -->
                                    </div>
                                    <!-- ./wrapper -->
                                    <!-- jQuery 2.2.3 -->
                                    <script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
                                    <!-- Bootstrap 3.3.6 -->
                                    <script src="../bootstrap/js/bootstrap.min.js"></script>
                                    <!-- FastClick -->
                                    <script src="../plugins/fastclick/fastclick.js"></script>
                                    <!-- AdminLTE App -->
                                    <script src="../dist/js/app.min.js"></script>
                                    <!-- AdminLTE for demo purposes -->
                                    <script src="../dist/js/demo.js"></script>
                                </body>
                                </html>
