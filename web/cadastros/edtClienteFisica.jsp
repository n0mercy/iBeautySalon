<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Dao.DaoFones"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Dao.DaoCliente"%>
<%@page import="model.connection.Conexao"%>
<%@page import="model.Bean.BeanFones"%>
<%@page import="model.Bean.BeanCep"%>
<%@page import="model.Bean.BeanEndereco"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="model.Bean.BeanCliente"%>
<%@page import="model.Dao.DaoCep"%>
<%@page import="model.Dao.DaoEndereco"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <title>Cadastro Cliente | IBeautySalon</title>
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
                                        <script src="../bootstrap/js/validator.min.js"></script>                                        

                                        <script>
                                            $(document).ready(function () {
                                                $("#submit").click(function (event) {

                                                    var cep_number = $("#cep").val();
                                                    var rua, bairro, zona, rs;
                                                    $.get("../ControllerCliente", {cep: cep_number}, function (responseText) {

                                                        rua = responseText.substr(0, responseText.indexOf(","));
                                                        zona = responseText.substr(responseText.indexOf(":") + 1, responseText.length);
                                                        rs = responseText.substr(responseText.indexOf(",") + 1);
                                                        bairro = rs.substr(0, rs.indexOf(":"));

                                                        document.getElementById("rua").value = rua;
                                                        document.getElementById("zona").value = zona;
                                                        document.getElementById("bairro").value = bairro;

                                                    });
                                                });
                                            });
                                        </script>

                                        <script>
                                            $(document).ready(function () {
                                                var date_input = $('input[name="data_nasc"]'); //our date input has the name "date"
                                                var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
                                                var options = {
                                                    format: 'dd/mm/yyyy',
                                                    container: container,
                                                    todayHighlight: true,
                                                    autoclose: true,
                                                };
                                                date_input.datepicker(options);
                                            })
                                        </script>
                                        </script>

                                        <!-- Include Date Range Picker -->
                                        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
                                        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>

                                        </head>

                                        <body  >
                                            <%
                                                BeanCliente cli = new BeanCliente();
                                                BeanUsuario user = new BeanUsuario();
                                                BeanEndereco end = new BeanEndereco();
                                                BeanCep cep = new BeanCep();
                                                BeanFones fone = new BeanFones();
                                                Connection con = Conexao.getConnection();
                                                String usuario = null;
                                                ResultSet rs;
                                                String sql = null;
                                                PreparedStatement pstm;
                                                if (request.getSession().getAttribute("user") != null) {
                                                    System.out.println("Usuário na session = true");
                                                    usuario = request.getSession().getAttribute("user").toString();
                                                } else {
                                                    System.out.println("Usuário na session = false");
                                                }
                                                if (usuario != null) {
                                                    sql = "select * from cliente_usuario inner join "
                                                            + "usuario ON cli_usu_codigo = usu_codigo left join "
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
                                                            cli = new DaoCliente().findByCpf(rs.getString("cli_cpf"));
                                                            user = new DaoUsuario().findByCodigo(rs.getInt("cli_usu_codigo"));
                                                            fone = new DaoFones().findByUser(rs.getInt("usu_codigo"));

                                                            if (request.getParameter("cep") != null) {
                                                                cep = new DaoCep().findByCodigo(request.getParameter("cep"));
                                                                end = new DaoEndereco().findByCep(cep.getCep_cep());
                                                            } else {
                                                                cep = new DaoCep().findByCodigo(rs.getString("end_cep"));
                                                                end = new DaoEndereco().findByCep(rs.getString("end_cep"));
                                                            }

                                                        } while (rs.next());

                                                    }

                                                } else {
                                                    if (request.getParameter("cep") != null) {
                                                        cep = new DaoCep().findByCodigo(request.getParameter("cep"));
                                                        end = new DaoEndereco().findByCep(cep.getCep_cep());
                                                        System.out.println(request.getParameter("cep") + ": cep encontrado");
                                                    }
                                                }

                                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                            %>
                                            <div class="wrapper">
                                                <!-- /.example-modal -->
                                                <form action="../ControllerCliente" id="form-main" name="form" method="POST" role="form" data-toggle="validator">
                                                    <input type="hidden" value="edtClienteFisica" name="save"/>
                                                    <input type="hidden" value="<%= cli.getCli_cpf()%>" name="cliente_id"/>
                                                    <input type="hidden" value="<%= user.getUsu_codigo()%>" name="usuario_id"/>
                                                    <input type="hidden" value="<%= fone.getFon_usu_cod().getUsu_codigo()%>" name="fone_usuario"/>
                                                    <input type="hidden" value="<%= end.getEnd_codigo()%>" name="endereco_id"/>
                                                    <div class="example-modal ">
                                                        <div class="modal">           
                                                            <div class="modal-dialog">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span></button>
                                                                        <h4 class="modal-title">Alterar Pessoa Fisíca</h4>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="form-group">
                                                                            <label>Nome</label>
                                                                            <input type="text" name="nome" id="nome" value="<%= cli.getCli_nome()%>" class="form-control" placeholder="Nome"/>
                                                                        </div>
                                                                        <label>Cpf</label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon">
                                                                                <i class="fa fa-child"></i>
                                                                            </div>
                                                                            <input type="text" disabled="true" name="cpf" id="cpf" value="<%= cli.getCli_cpf()%>" class="form-control" data-mask/>
                                                                        </div>                                                                
                                                                        <label>Data Nascimento</label>
                                                                        <div class="input-group">
                                                                            <div class="input-group-addon">
                                                                                <i class="fa  fa-calendar-minus-o"></i>
                                                                            </div>
                                                                            <input type="text" name="data_nasc" id="data_nasc" value="<%= sdf.format(cli.getCli_dtnasc())%>" class="form-control" data-inputmask="99/99/9999" data-mask/>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label>Fones</label>

                                                                            <div class="input-group">
                                                                                <div class="input-group-addon">
                                                                                    <i class="fa fa-phone"></i>
                                                                                </div>
                                                                                <input type="text" class="form-control" name="telefone1" id="telefone1" value="<%= fone.getFon_fones()%>"/>
                                                                            </div>                                                           
                                                                        </div>
                                                                        <div class="form-group">                
                                                                            <label>Cep</label>
                                                                            <div class="input-group">
                                                                                <input type="text" class="form-control" id="cep" name="cep" value="<%= cep.getCep_cep()%>"/><span class="input-group-btn">
                                                                                    <input type="button" id="submit" class="btn btn-info btn-flat" value="Buscar"/>
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
                                                                                            <input type="text" id="ref" name="ref" value="<%= end.getEnd_ref()%>" class="form-control" placeholder="Ponto de Referência"/>
                                                                                        </div>

                                                                                        <div class="form-group">
                                                                                            <label>Número</label>
                                                                                            <input type="text" class="form-control" id="numero" value="<%= end.getEnd_num()%>" name="numero" placeholder="N°"/>
                                                                                        </div>
                                                                                        <!-- /.form-group -->
                                                                                    </div>
                                                                                    <!-- /.col -->
                                                                                    <div class="col-md-6">
                                                                                        <div class="form-group">
                                                                                            <label>Bairro</label>
                                                                                            <div class="form-group">
                                                                                                <input type="text" disabled="true" name="bairro" id="bairro" value="<%= cep.getCep_bai_codigo().getBai_nome()%>" class="form-control" placeholder="Bairro"/>
                                                                                            </div>
                                                                                        </div>

                                                                                        <div class="form-group">
                                                                                            <label>Zona</label>
                                                                                            <div class="form-group">
                                                                                                <input type="text" disabled="true" name="zona" id="zona" value="<%= cep.getCep_bai_codigo().getBai_zona_cod().getZona_nome()%>" class="form-control" placeholder="Zona"/>
                                                                                            </div>
                                                                                        </div>            
                                                                                        <!-- /.form-group -->

                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <div class="form-group">
                                                                                        <label>Rua</label>
                                                                                        <input type="text" name="rua" id="rua" value="<%= cep.getRua()%>" class="form-control" disabled="disabled" placeholder="Rua"/>
                                                                                    </div>

                                                                                </div>
                                                                                <!-- /.col -->            
                                                                            </div>
                                                                            <!-- /.row -->
                                                                        </div>
                                                                        <!-- /.box-body -->        
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="email">Email</label>
                                                                        <input type="email" name="email" class="form-control" id="email" value="<%= user.getUsu_email()%>" placeholder="Email"/>
                                                                    </div>
                                                                    <div class="form-group has-feedback">
                                                                        <label for="senha">Senha</label>
                                                                        <input type="password" data-minLength="6" id="senha" value="<%= user.getUsu_senha()%>" data-error="Mínimo de 6 caracteres" required name="senha" class="form-control" placeholder="Senha"/>
                                                                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                                                        <span class="glyphicon form-control-feedback"></span>
                                                                        <span class="help-block with-errors"></span>
                                                                    </div>     
                                                                    <div class="form-group has-feedback">
                                                                        <label for="confirm_senha">Confirmar Senha</label>
                                                                        <input type="password" required data-match="#senha" id="confirm_senha" data-minLength="6" data-match-error="Pera viado, senhas estão diferentes :D" name="confirm_senha" class="form-control {$borderColor}" placeholder="Senha"/>
                                                                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                                                        <span class="glyphicon form-control-feedback"></span>
                                                                        <span class="help-block with-errors"></span>
                                                                    </div> 
                                                                    <div class="modal-footer">               
                                                                        <button type="submit" id="btnSubmit" name="btnSubmit" class="btn btn-block btn-default btn-flat btn btn-primary pull-left" >Salvar Cliente</button>                               
                                                                    </div>
                                                                </div>
                                                            </div>


                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>                                                    
                                                </form>
                                                <!-- Modal Dialog -->

                                                <!-- /.modal-dialog -->
                                            </div>
                                            <!-- /.modal -->
                                            </div>
                                            <!-- ./wrapper -->

                                        </body>

                                        </html>
