<%-- 
    Document   : listaSalaoAtendimento
    Created on : 02/06/2017, 17:03:13
    Author     : n0mercy
--%>

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
        if (request.getParameter("empresa_id") != null) {
            list = new DaoCupom().findByEmpStatus(request.getParameter("empresa_id"),"em atendimento");
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
                            <h4 class="modal-title">Lista de Atendimento Salão</h4>
                        </div>                                                                     
                        <div class="box">                                                                    
                            <!-- /.Começa a div da tabela -->
                            <div class="box-body">
                                <form method="POST" action="#">
                                    <table id="example1" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>                 
                                                <th>Cupom</th>  
                                                <th>Status</th>  
                                                <th>Cliente</th>                                                                                               
                                            </tr>
                                        </thead>
                                        <%if (list.size() > 0) {%>
                                        <tbody> 
                                            <%
                                                for (BeanCupom c : list) {
                                            %>
                                            <tr>                 
                                                <td ><%=c.getCupom_codigo()%></td>
                                                <td><%=c.getCupom_status()%></td>
                                                <td><%=c.getCupom_clicpf().getCli_nome()%></td>                                                                                        
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
