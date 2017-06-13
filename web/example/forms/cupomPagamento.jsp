<%-- 
    Document   : cupomPagamento
    Created on : 15/05/2017, 21:50:42
    Author     : VaiDiegoo
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Dao.DaoItemServico"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Dao.DaoCupom"%>
<%@page import="model.Dao.DaoCliente"%>
<%@page import="java.util.List"%>
<%@page import="model.Bean.BeanItemServico"%>
<%@page import="model.Bean.BeanCupom"%>
<%@page import="model.Bean.BeanCliente"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Finalizar Cupom | IBeautySalon</title>
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
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <%

            BeanUsuario usuario;
            BeanCliente cliente;
            BeanCupom cupom = new BeanCupom();
            int qrcode = 0;
            BeanItemServico item;
            List<BeanItemServico> listItem = new ArrayList<BeanItemServico>();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            double total = 0;

            if (request.getSession().getAttribute("user") != null) {
                System.out.println("Usuário na session = true");
                String user = request.getSession().getAttribute("user").toString();
                usuario = new DaoUsuario().findByUserSession(user);
                cliente = new DaoCliente().findByUser(usuario.getUsu_codigo());
                cupom = new DaoCupom().findByCliente(cliente.getCli_cpf());
                qrcode = cupom.getCupom_codigo();
                System.out.print("CUPOM ID: "+qrcode);
                listItem = new DaoItemServico().findItensByCupom(cupom.getCupom_codigo(),"pendente");
            } else {
                System.out.println("Usuário na session = false");
            }

            if (request.getParameter("remove") != null) {
                int item_cod = Integer.parseInt(request.getParameter("remove"));
                new DaoItemServico().remove(item_cod);
                String user = request.getSession().getAttribute("user").toString();
                usuario = new DaoUsuario().findByUserSession(user);
                cliente = new DaoCliente().findByUser(usuario.getUsu_codigo());
                cupom = new DaoCupom().findByCliente(cliente.getCli_cpf());
                qrcode = cupom.getCupom_codigo();
                listItem = new DaoItemServico().findItensByCupom(cupom.getCupom_codigo(),"pendente");
            }
        %>
        <!-- Main content -->
        <section class="invoice">
            <!-- title row -->
            <div class="row">
                <div class="col-xs-12">
                    <h2 class="page-header">
                        <i class="fa fa-globe"></i> Finalizando Sua Compra :D 
                        <small class="pull-right"><strong>Usuário:</strong> ${user}</small>
                    </h2>
                </div>
                <!-- /.col -->
            </div>         
            <!-- Table row -->
            <div class="row">
                <div class="col-xs-12 table-responsive">
                    <form method="POST" action="">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Cod</th>
                                    <th>Descrição</th>              
                                    <th>Valor</th>
                                    <th>Remover Serviço</th>
                                </tr>
                            </thead>

                            <tbody>

                                <%
                                    for (BeanItemServico i : listItem) {
                                        total += i.getItemserv_ofe_cod().getOfe_valor();
                                %>
                                <tr>
                                    <td><%= i.getItemserv_codigo()%></td>
                                    <td><%= i.getItemserv_ofe_cod().getOfe_serv_codigo().getServ_nome()%></td>
                                    <td><%= i.getItemserv_ofe_cod().getOfe_valor()%></td>  
                                    <td><button type="submit" value="<%= i.getItemserv_codigo()%>" name="remove" class="btn btn-default btn-flat btn btn-danger pull-left" />Remover</td>
                                </tr>
                                <%
                                    }
                                %>

                            </tbody>

                        </table>
                    </form>
                </div>
                <!-- /.col -->
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
                    <p class="lead">Data de Hoje <%= sdf.format(new Date())%></p>
                    <br>
                    <div class="table-responsive">
                        <table class="table">

                            <tr>
                                <td>
                                    <label>Tipo de Pagamento</label>
                                    <select name="pagamento" class="form-control select2" style="width: 100%;">                                                                                        
                                        <option value="Pagamentos" selected="selected">Crédito</option>                                                                                                       
                                    </select>
                                    <br>
                                    <label>Valor Total</label>: R$<%= total%>
                                </td>
                                <td> 
                                    <img src="../../images/<%= qrcode %>.png" class="pull-right"/>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
            <!-- this row will not appear when printing -->
            <form method="POST" action="../../ControllerPagamento">
                <input type="hidden" name="cupom_id" value="<%= cupom.getCupom_codigo()%>"/>
                <input type="hidden" name="page" value="cupomPagamento"/>
                <div class="row no-print">
                    <div class="col-xs-12">          
                        <button type="submit" name="submit" value="confirm" class="btn btn-success pull-right"><i class="fa fa-credit-card"></i> Finalizar Pagamento
                        </button>
                        <button type="submit" name="submit" value="cancell" class="btn btn-danger pull-right" style="margin-right: 5px;">
                            <i class="fa fa-download"></i> Cancelar Cupom
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
        <strong>IBeautySalon &copy; 2017-2017 <a href="http://almsaeedstudio.com">Manaus-AM</a>.</strong> 
    </footer>

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
