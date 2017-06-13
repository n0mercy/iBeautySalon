<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <title>IBeautySalon | Dashboard</title>
                <!-- Tell the browser to be responsive to screen width -->
                <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
                    <!-- Bootstrap 3.3.6 -->
                    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
                        <!-- Font Awesome -->
                        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
                            <!-- Ionicons -->
                            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
                                <!-- Theme style -->
                                <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
                                    <!-- AdminLTE Skins. Choose a skin from the css/skins
                                         folder instead of downloading all of them to reduce the load. -->
                                    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css"/>
                                    <!-- iCheck -->
                                    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
                                        <!-- Morris chart -->
                                        <link rel="stylesheet" href="plugins/morris/morris.css">
                                            <!-- jvectormap -->
                                            <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
                                                <!-- Date Picker -->
                                                <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
                                                    <!-- Daterange picker -->
                                                    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
                                                        <!-- bootstrap wysihtml5 - text editor -->
                                                        <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

                                                            <!-- jQuery 2.2.3 -->
                                                            <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
                                                            <!-- jQuery UI 1.11.4 -->
                                                            <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
                                                            <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
                                                            <script>
                                                                $.widget.bridge('uibutton', $.ui.button);
                                                            </script>
                                                            <!-- Bootstrap 3.3.6 -->
                                                            <script src="bootstrap/js/bootstrap.min.js"></script>
                                                            <!-- Morris.js charts -->
                                                            <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
                                                            <script src="plugins/morris/morris.min.js"></script>
                                                            <!-- Sparkline -->
                                                            <script src="plugins/sparkline/jquery.sparkline.min.js"></script>
                                                            <!-- jvectormap -->
                                                            <script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
                                                            <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
                                                            <!-- jQuery Knob Chart -->
                                                            <script src="plugins/knob/jquery.knob.js"></script>
                                                            <!-- daterangepicker -->
                                                            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
                                                            <script src="plugins/daterangepicker/daterangepicker.js"></script>
                                                            <!-- datepicker -->
                                                            <script src="plugins/datepicker/bootstrap-datepicker.js"></script>
                                                            <!-- Bootstrap WYSIHTML5 -->
                                                            <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
                                                            <!-- Slimscroll -->
                                                            <script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
                                                            <!-- FastClick -->
                                                            <script src="plugins/fastclick/fastclick.js"></script>
                                                            <!-- AdminLTE App -->
                                                            <script src="dist/js/app.min.js"></script>
                                                            <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
                                                            <script src="dist/js/pages/dashboard.js"></script>
                                                            <!-- AdminLTE for demo purposes -->
                                                            <script src="dist/js/demo.js"></script>
                                                            <title>Untitled Document</title>
                                                            </head>
                                                            <body class="hold-transition skin-blue ">
                                                                <div class="wrapper">    
                                                                    <!-- sidebar: style can be found in sidebar.less -->
                                                                    <section class="sidebar">
                                                                        <!-- Sidebar user panel -->
                                                                        <div class="user-panel">
                                                                            <div class="pull-left image">
                                                                                <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                                                                            </div>
                                                                            <div class="pull-left info">
                                                                                <p> ${username} </p>
                                                                                <a href="ControllerLogin" onclick="window.close();" target="login.jsp"> <i class="fa fa-circle text-success"></i> Sair</a>
                                                                            </div>
                                                                        </div>
                                                                        <!-- search form -->
                                                                        <form action="#" method="get" class="sidebar-form">
                                                                        </form>
                                                                        <!-- /.search form -->
                                                                        <!-- sidebar menu: : style can be found in sidebar.less -->
                                                                        <ul class="sidebar-menu">
                                                                            <li class="header">Menu Principal</li>
                                                                            <li class="treeview">
                                                                                <a href="#">
                                                                                    <i class="fa fa-laptop"></i>
                                                                                    <span>Salões</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>            </span>          </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        Integer role = (Integer) request.getSession().getAttribute("role");
                                                                                        String status = (String) request.getSession().getAttribute("status");
                                                                                        if (role == 2) {
                                                                                    %>
                                                                                    <li><a href="example/pages/buscarCep.jsp" target="mainFrame"><i class="fa fa-circle-o"></i> Buscar Salões</a></li>
                                                                                        <%
                                                                                            }
                                                                                            if (role == 3 && status.equals("Ativo")) {
                                                                                        %>
                                                                                    <li ><a href="cadastros/edtClienteJuridica.jsp" target="mainFrame"><i class="fa fa-circle-o"></i> Alterar Salão</a></li>
                                                                                        <%
                                                                                            }
                                                                                        %> 
                                                                                </ul>          
                                                                            </li>
                                                                            <li class="treeview">
                                                                                <a href="#">
                                                                                    <i class="fa fa-files-o"></i>
                                                                                    <span>Serviços</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>            </span>
                                                                                </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        if (role == 3 && status.equals("Ativo")) {
                                                                                    %>
                                                                                    <li><a href="example/forms/adicionarServicos.jsp" target="mainFrame" ><i class="fa fa-circle-o"></i> Adicionar Serviço</a></li>  
                                                                                        <%
                                                                                            }
                                                                                            if (role == 1) {
                                                                                        %>
                                                                                    <li><a href="example/forms/buscarServico.jsp" target="mainFrame" ><i class="fa fa-circle-o"></i> Buscar Serviços</a></li> 
                                                                                    <li><a href="example/forms/cadServico.jsp" target="mainFrame" ><i class="fa fa-circle-o"></i> Cadastrar Serviço</a></li>  
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                </ul>
                                                                            </li> 
                                                                            <li class="treeview">
                                                                                <a href="#">
                                                                                    <i class=" fa-sticky-note-o"></i>
                                                                                    <span>Cupons</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>
                                                                                    </span>
                                                                                </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        if (role == 3 && status.equals("Ativo")) {
                                                                                    %>
                                                                                    <li><a href="#" ><i class="fa fa-circle-o"></i> Consultar Vendidos</a></li>                       
                                                                                    <li><a href="example/pages/checkinCupom.jsp" target="mainFrame"><i class="fa fa-circle-o"></i> Check-in Cupons</a></li>
                                                                                        <%
                                                                                            }
                                                                                            if (role == 2) {
                                                                                        %>
                                                                                    <li><a href="example/pages/cuponsComprados.jsp" target="mainFrame"><i class="fa fa-circle-o"></i> Consultar Comprados</a></li>       
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                </ul>
                                                                            </li>
                                                                            <li class="treeview">
                                                                                <a href="#">
                                                                                    <i class="fa fa-pie-chart"></i>
                                                                                    <span>Relatórios</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>
                                                                                    </span>
                                                                                </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        if (role == 1) {
                                                                                    %>
                                                                                    <li><a href="#" ><i class="fa fa-circle-o"></i> Mensalidades</a></li>
                                                                                        <%
                                                                                            }
                                                                                            if (role == 3 && status.equals("Ativo")) {
                                                                                        %>
                                                                                    <li><a href="#" ><i class="fa fa-circle-o"></i> Serviços Mais Venidos</a></li>
                                                                                    <li><a href="example/pages/relatorioCupons.jsp" target="mainFrame" ><i class="fa fa-circle-o"></i> Cupons</a></li>            
                                                                                        <%
                                                                                            }
                                                                                        %>                                                                                        
                                                                                </ul>
                                                                            </li>
                                                                            <li class="treeview">
                                                                                <a href="#">
                                                                                    <i class="fa fa-credit-card"></i>
                                                                                    <span>Mensalidade</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>            </span>          </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        if (role == 3 && status.equals("pendente")) {
                                                                                    %>
                                                                                    <li><a href="example/pages/pagarMensalidade.jsp" target="mainFrame" ><i class="fa fa-circle-o"></i> Pagar Mensalidade</a></li>                           
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                </ul>          
                                                                            </li>
                                                                            <li class="treeview">
                                                                                <a href="#">
                                                                                    <i class="fa fa-user-plus"></i>
                                                                                    <span>Funcionário</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>            </span>          </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        if (role == 3 && status.equals("Ativo")) {
                                                                                    %>
                                                                                    <li><a href="#" ><i class="fa fa-circle-o"></i> Adicionar Funcionário</a></li>                           
                                                                                    <li><a href="#" ><i class="fa fa-circle-o"></i> Buscar Funcionário</a></li>                           
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                </ul>          
                                                                            </li>
                                                                            <li class="treeview">                                                                                    
                                                                                <a href="#">                                                                                        
                                                                                    <i class="fa fa-user"></i>
                                                                                    <span>Clientes</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>            </span>          </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        if (role == 2) {
                                                                                    %>
                                                                                    <li><a href="cadastros/edtClienteFisica.jsp" target="mainFrame" ><i class="fa fa-circle-o"></i> Alterar Cliente</a></li>                           
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                </ul>
                                                                            </li>
                                                                            <li class="treeview">
                                                                                <a href="#">
                                                                                    <i class="fa fa-users"></i>
                                                                                    <span>Usuários</span>
                                                                                    <span class="pull-right-container">
                                                                                        <i class="fa fa-angle-left pull-right"></i>            </span>          </a>
                                                                                <ul class="treeview-menu">
                                                                                    <%
                                                                                        if (role == 1) {
                                                                                    %>
                                                                                    <li><a href="example/pages/buscarTipoUsuario.jsp" target="mainFrame" ><i class="fa fa-circle-o"></i> Consultar Usuários</a></li>                           
                                                                                        <%
                                                                                            }
                                                                                        %>
                                                                                </ul>            
                                                                            </li>
                                                                            <li class="treeview">
                                                                                <li class="header">Sobre Nós</li>
                                                                                <li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>IBeautySalon</span></a></li>  
                                                                            </li>
                                                                            <li class="treeview">    
                                                                                <li class="header">Entre em contato</li>
                                                                                <li><a href="#"><i class="fa fa-circle-o text-blue"></i> <span>Contatos</span></a></li>  
                                                                            </li>
                                                                            <li class="treeview">          
                                                                                <li><a href="#"><i class="fa fa-circle-o text-aqua  "></i> <span>Trabalhe Conosco</span></a></li>  
                                                                            </li>
                                                                    </section>
                                                                    <div class="control-sidebar-bg"></div> 
                                                                </div>
                                                                <!-- ./wrapper -->



                                                            </body>
                                                            </html>
