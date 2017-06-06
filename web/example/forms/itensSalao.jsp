<%-- 
    Document   : itensSalao
    Created on : 15/05/2017, 19:43:50
    Author     : VaiDiegoo
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.Dao.DaoOferece"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Bean.BeanOferece"%>
<%@page import="model.Dao.DaoFones"%>
<%@page import="model.Dao.DaoEndereco"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Bean.BeanFones"%>
<%@page import="model.Bean.BeanCep"%>
<%@page import="model.Bean.BeanEndereco"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="model.Dao.DaoEmpresa"%>
<%@page import="model.Bean.BeanEmpresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Itens Salão | IBeautySalon</title>
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

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

        <script type="text/javascript">
            $(document).ready(function () {
                $("input[type=checkbox]").change(function () {
                    calc();
                })
            });

            function calc() {
                var sum = 0;
                var selected_id = "";
                $("input[type=checkbox]:checked").each(function () {
                    var str = $(this).val().toString();
                    var valueDouble = str.substr(0, str.indexOf(":"));
                    sum += parseFloat(valueDouble);
                    selected_id += str.substr(str.indexOf(":") + 1) + ", ";
                });
                $("#total").val(sum);
                $("#services_id").val(selected_id);
            }
        </script>
    </head>
    <body class="hold-transition skin-blue sidebar-mini">

        <%

            BeanEmpresa emp = new BeanEmpresa();
            BeanUsuario usuario = new BeanUsuario();
            BeanEndereco endereco = new BeanEndereco();
            BeanFones fone = new BeanFones();
            List<BeanOferece> offers = new ArrayList<BeanOferece>();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            String company = "";
            if (request.getParameter("sValue") != null) {
                company = request.getParameter("sValue");
                emp = new DaoEmpresa().findByCnpj(request.getParameter("sValue"));
                usuario = new DaoUsuario().findByCodigo(emp.getEmp_usu_codigo().getUsu_codigo());
                endereco = new DaoEndereco().findByCodigo(usuario.getUsu_end_codigo().getEnd_codigo());
                fone = new DaoFones().findByUser(usuario.getUsu_codigo());
            }
            
            if(request.getParameter("txtserv") != null){
                
            }

        %>
        <!-- Main content -->
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
            <!-- info row -->
            <div class="row invoice-info">
                <div class="col-sm-4 invoice-col">        
                    <address>
                        <strong><%= emp.getEmp_razao()%></strong><br>
                        <%= endereco.getEnd_cep().getRua()%><br>
                        <%= endereco.getEnd_cep().getCep_cep()%><br>
                        <%= endereco.getEnd_cep().getCep_bai_codigo().getBai_nome()%>, <%= endereco.getEnd_num()%><br>
                        Contato: <%= fone.getFon_fones()%><br>
                        Email: <%= usuario.getUsu_email()%>
                    </address>
                </div>
                     <div class="col-sm-4 invoice-col">        
                    <address>
                        <button type="button" onClick="location.href='listaSalaoAtendimento.jsp'" class="btn btn-primary pull-right" style="margin-right: 5px;">
                            <i class="fa fa-download"></i> Lista Atendimento Salão
                        </button>
                    </address>
                </div> 
            </div>  
            <div class="login-box-body">
                <p class="login-box-msg">Preencha o serviço desejado</p>
                <form method="POST" action="#">
                    <input type="hidden" name="sValue" value="<%= company %>"/>
                    <div class="input-group input-group-sm">
                        <input type="text" name="txtserv" class="form-control">
                        <span class="input-group-btn">
                            <button type="submit" class="btn btn-info btn-flat">Buscar</button>
                        </span>                                            
                    </div>
                </form>
            </div>
            <!-- Table row -->
            <div class="row">
                <!-- /.col -->
            </div> 
            <form method="POST" action="../../ControllerItemServico">
                <input type="hidden" name="page" value="itensSalao"/>
                <div class="col-xs-12 table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Cod</th>
                                <th>Descrição</th>              
                                <th>Valor</th>
                                <th class="pull-right">Adicionar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            String param = null;
                            param = request.getParameter("txtserv") != null ? request.getParameter("txtserv") : "";
                                offers = new DaoOferece().findOffersByEmpresa(emp.getEmp_cnpj(), param, true);
                                for (BeanOferece o : offers) {
                            %>
                            <tr>
                                <td><%= o.getOfe_serv_codigo().getServ_cod()%></td>
                                <td><%= o.getOfe_serv_codigo().getServ_nome()%></td>
                                <td>R$<%= o.getOfe_valor()%></td>  
                                <td>
                                    <div class="checkbox icheck pull-right">
                                        <label>
                                            <input type="checkbox" value="<%= o.getOfe_valor() + ":" + o.getOfe_codigo()%>" id="selected_services" name="selected_services">  
                                        </label>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                        <input type="hidden" name="services_id" id="services_id"/>

                    </table>
                </div>
                <!-- /.row -->

                <div class="row">
                    <!-- accepted payments column -->
                    <div class="col-xs-6">
                        <p class="lead">Métodos de Pagamento:</p>
                        <img src="../../dist/img/credit/visa.png" alt="Visa">
                        <img src="../../dist/img/credit/mastercard.png" alt="Mastercard">
                        <img src="../../dist/img/credit/american-express.png" alt="American Express">
                        <img src="../../dist/img/credit/paypal2.png" alt="Paypal">

                        <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
                            São aceitos estes tipos de pagamentos no nosso site, qualquer dúvida pode-se entrar em contato com 
                            o nosso suporte técnico para sanar as respectivas dúvidas.              
                        </p>
                    </div>
                    <!-- /.col -->
                    <div class="col-xs-6">
                        <p class="lead">Data: <%= sdf.format(new Date())%></p>                    
                        <br>
                        <div class="table-responsive">
                            <table class="table">
                                <tr>
                                    <th style="width:20%">Valor Total:</th>                            
                                    <td>R$<input type="text" disabled="true" name="total" id="total" /></td>
                                </tr>              
                            </table>
                        </div>
                    </div>
                    <!-- /.col -->
                </div>
                <!-- /.row -->
                <!-- this row will not appear when printing -->
                <div class="row no-print">
                    <div class="col-xs-12">
                        <button class="btn success" onclick="window.print()">Imprimir</button>
                        <button type="submit" class="btn btn-success pull-right"><i class="fa fa-credit-card"></i> Carrinho
                        </button>
                        <button type="button" class="btn btn-danger pull-right" style="margin-right: 5px;">
                            <i class="fa fa-download"></i> Cancelar
                        </button>
                    </div>
                </div>
            </form>

        </section>
        <!-- /.content -->
        <div class="clearfix"></div>
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer no-print">   
        <strong>IBeautySalon &copy; 2017-2017 Manaus-AM.</strong> 
    </footer>
</body>
</html>
