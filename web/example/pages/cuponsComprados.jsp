<%-- 
    Document   : cuponsComprados
    Created on : 06/06/2017, 14:49:15
    Author     : n0mercy
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Dao.DaoCliente"%>
<%@page import="model.Bean.BeanCliente"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="model.Dao.DaoCupom"%>
<%@page import="model.Dao.DaoEmpresa"%>
<%@page import="model.Bean.BeanEmpresa"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Bean.BeanCupom"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista Atendimento</title>
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
        <script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
        <!-- Bootstrap 3.3.6 -->
        <script src="../../bootstrap/js/bootstrap.min.js"></script>
        <!-- FastClick -->
        <script src="../../plugins/fastclick/fastclick.js"></script>
        <!-- AdminLTE App -->
        <script src="../../dist/js/app.min.js"></script>
        <!-- AdminLTE for demo purposes -->
        <script src="../../dist/js/demo.js"></script>
    </head>
</head>
<body>
    <%
        List<BeanCupom> list = new ArrayList<BeanCupom>();
        BeanCliente c = new BeanCliente();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        if (request.getSession().getAttribute("user") != null) {
            c = new DaoCliente().findClienteBySession(request.getSession().getAttribute("user").toString());
            list = new DaoCupom().findCuponsCompradosByCPF(c.getCli_cpf());
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
                            <h4 class="modal-title">Cupons Comprados</h4>
                        </div>                                                                     
                        <div class="box">                                                                    
                            <!-- /.Começa a div da tabela -->
                            <div class="box-body">
                                <form method="POST" action="#">
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>                 
                                                <th style="text-align: center">Cupons</th>
                                            </tr>
                                        </thead>
                                        <%if (list.size() > 0) {%>
                                        <tbody> 
                                            <%
                                                for (BeanCupom cupom : list) {
                                            %>
                                            <tr> 
                                                <td>
                                                    <div class="box box-default">
                                                        <div class="box-header with-border">
                                                            <h1 class="box-title">cupom <%=cupom.getCupom_codigo()%></h1>

                                                            <div class="box-tools pull-right">
                                                                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus">show</i></button>            
                                                            </div>
                                                        </div>
                                                        <div class="box-body">
                                                            <img src="../../images/<%=cupom.getCupom_codigo()%>.png" alt=""/>
                                                            <div>
                                                                Status: <%=cupom.getCupom_status()%><br>                                                                                       
                                                                Data: <%=sdf.format(cupom.getCupom_data())%>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </td>

                                            </tr> 
                                            <%
                                                }
                                            %>
                                        </tbody>  
                                        <%
                                        } else {
                                        %>
                                        <tbody> 
                                            <tr>                 
                                                <td colspan="3" style="text-align: center"><b><% out.print("Lista de espera vazia!"); %></b></td>                                                                                        
                                            </tr>
                                        </tbody> 
                                        <%
                                            }
                                        %>
                                    </table>
                                </form>
                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!-- /.modal-dialog -->          
                </div>
                <!-- /.modal -->        
            </div>
        </div>  
    </div>
    <!-- ./wrapper -->
</body>
</html>
