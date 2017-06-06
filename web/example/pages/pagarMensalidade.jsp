<%-- 
    Document   : pagarMensalidade
    Created on : 05/06/2017, 15:15:15
    Author     : n0mercy
--%>

<%@page import="model.Dao.DaoEmpresa"%>
<%@page import="model.Dao.DaoUsuario"%>
<%@page import="model.Bean.BeanUsuario"%>
<%@page import="model.Dao.DaoRealiza"%>
<%@page import="model.Bean.BeanRealiza"%>
<%@page import="model.Bean.BeanEmpresa"%>
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
        BeanRealiza mensa = new BeanRealiza();
        BeanEmpresa emp = new BeanEmpresa();
        BeanUsuario usuario = new BeanUsuario();
        if (request.getSession().getAttribute("user") != null) {
            usuario = new DaoUsuario().findByUserSession(request.getSession().getAttribute("user").toString());
        }

        emp = new DaoEmpresa().findByEmail(usuario.getUsu_email());
        mensa = new DaoRealiza().findByCnpj(emp.getEmp_cnpj());

    %>
    <div class="wrapper">
        <!-- /.example-modal -->
        <form action="../../ControllerPagamento" id="form-main" name="form1" method="POST" role="form" data-toggle="validator">
            <input type="hidden" name="page" value="pagarMensalidade"/>
            <input type="hidden" name="empresa_id" value="<%= mensa.getReal_emp_cnpj().getEmp_cnpj()%>"/>
            <input type="hidden" value="cadClienteJuridica" name="save"/>
            <div class="example-modal ">
                <div class="modal">           
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">Realizar Pagamento Mensalidade</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>Razão Social</label>
                                    <input type="text" disabled="true" value="<%= mensa.getReal_emp_cnpj().getEmp_razao()%>" name="razao" class="form-control" placeholder="Razão"/>
                                </div>
                                <label>Cnpj</label>
                                <div class="input-group">
                                    <div class="input-group-addon">                                                                    
                                        <i class="fa fa-university"></i>
                                    </div>
                                    <input type="text" placeholder="Cnpj" name="cnpj" class="form-control" disabled="true" value="<%= mensa.getReal_emp_cnpj().getEmp_cnpj()%>"  data-inputmask="'insc estadual'" data-mask/>
                                </div>   
                                <label>Valor Mensalidade</label>
                                <div class="input-group">
                                    <div class="input-group-addon">                                                                    
                                        <i class="fa fa-university"></i>
                                    </div>
                                    <input type="text" placeholder="" name="valor" disabled="true" value="<%= mensa.getReal_valor()%>" class="form-control" />
                                </div> 
                                <label>Tipo de Pagamento</label>
                                <select name="pagamento" class="form-control select2" style="width: 100%;">                                                                                        
                                    <option value="2" selected="selected">Crédito</option>  
                                    <option value="1">Débito</option> 
                                </select>

                                <!-- /.col -->            
                            </div>
                            <!-- /.row -->
                        </div>
                        <!-- /.box-body -->  
                        <div class="modal-footer">               
                            <button type="submit" class="btn btn-block btn-default btn-flat btn btn-primary pull-left">Realizar Pagamento</button>                               
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>
    <!-- /.modal-content -->                                          

    <!-- /.modal-dialog -->
</div>

<!-- /.modal -->                                        
</div>
</body>
</html>
