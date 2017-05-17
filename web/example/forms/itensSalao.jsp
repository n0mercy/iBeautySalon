<%-- 
    Document   : itensSalao
    Created on : 15/05/2017, 19:43:50
    Author     : VaiDiegoo
--%>

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

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <!-- Main content -->
        <section class="invoice">
            <!-- title row -->
            <div class="row">
                <div class="col-xs-12">
                    <h2 class="page-header">
                        <i class="fa fa-globe"></i> IBeautySalon 
                        <small class="pull-right">Email logado</small>
                    </h2>
                </div>
                <!-- /.col -->
            </div>
            <!-- info row -->
            <div class="row invoice-info">
                <div class="col-sm-4 invoice-col">        
                    <address>
                        <strong>Nome do salão</strong><br>
                        Rua do salão x y z<br>
                        Cep 692528-085<br>
                        Bairro, número<br>
                        fone1: 4123-5432 fone2: 5262-2926<br>
                        Email: info@almasaeedstudio.com
                    </address>
                </div>                                
            </div>  
            <div class="login-box-body">
                <p class="login-box-msg">Preencha o serviço desejado</p>
                <form method="GET" action="#">
                    <div class="input-group input-group-sm">
                        <input type="text" name="txtserv" class="form-control">
                        <span class="input-group-btn">
                            <button type="submit" class="btn btn-info btn-flat">Buscar</button>
                        </span>                                            
                    </div>
                </form>
                <!-- Table row -->
                <div class="row">
                    <!-- /.col -->
                </div> 
                <div class="col-xs-12 table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Cod</th>
                                <th>Descrição</th>              
                                <th>Valor</th>
                                <th>Adicionar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Chapinha</td>
                                <td>$64.50</td>  
                                <td><input type="submit" value="Adicionar" name="Adicionar" class="btn btn-default btn-flat btn btn-primary pull-left" /></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Pedicure</td>
                                <td>$20.00</td> 
                                <td><input type="submit" value="Adicionar" name="Adicionar" class="btn btn-default btn-flat btn btn-primary pull-left" /></td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Escova Simples</td>
                                <td>$35.00</td> 
                                <td><input type="submit" value="Adicionar" name="Adicionar" class="btn btn-default btn-flat btn btn-primary pull-left" /></td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Manicure</td>
                                <td>$15.00</td> 
                                <td><input type="submit" value="Adicionar" name="Adicionar" class="btn btn-default btn-flat btn btn-primary pull-left" /></td>
                            </tr>
                        </tbody>
                    </table>
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
                    <p class="lead">Data de Hoje x/xx/xxxx</p>
                    <br>
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <th style="width:50%">Valor Total:</th>
                                <td>$250.30</td>
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
                    <a href="invoice-print.html" target="_blank" class="btn btn-default"><i class="fa fa-print"></i> Imprimir</a>
                    <button type="button" class="btn btn-success pull-right"><i class="fa fa-credit-card"></i> Carrinho
                    </button>
                    <button type="button" class="btn btn-danger pull-right" style="margin-right: 5px;">
                        <i class="fa fa-download"></i> Cancelar
                    </button>
                </div>
            </div>
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
