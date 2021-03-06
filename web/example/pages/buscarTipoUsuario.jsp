<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <title>Tipo Usuário | IBeautySalon</title>
                <!-- Tell the browser to be responsive to screen width -->
                <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
                    <!-- Bootstrap 3.3.6 -->
                    <link rel="stylesheet" href="../../bootstrap/css/bootstrap.min.css"/>
                        <!-- Font Awesome -->
                        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
                            <!-- Ionicons -->
                            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
                                <!-- Theme style -->
                                <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css"/>
                                    <!-- iCheck -->
                                    <link rel="stylesheet" href="../../plugins/iCheck/square/blue.css"/>

                                        <link jsf:library="bootstrap" jsf:name="bootstrap.min.css" />

                                        <!-- jQuery 2.2.3 -->
                                        <script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
                                        <!-- Bootstrap 3.3.6 -->
                                        <script src="../../bootstrap/js/bootstrap.min.js"></script>
                                        <!-- iCheck -->
                                        <script src="../../plugins/iCheck/icheck.min.js"></script>
                                        <script>
                                            function check_sex() {
                                                var radioBtns = document.getElementsByName("r1");
                                                for (i = 0; i < radioBtns.length; i++) {
                                                    if (radioBtns[i].checked) {
                                                        if (radioBtns[i].value === 'fisica')
                                                            location.href = "../forms/buscarPessoaFisica.jsp";
                                                        else
                                                            location.href = "../forms/buscarPessoaJuridica.jsp";
                                                    }
                                                }
                                            }
                                        </script>
                                        <script>
                                            $(function () {
                                                $('input').iCheck({
                                                    checkboxClass: 'icheckbox_square-blue',
                                                    radioClass: 'iradio_square-blue',
                                                    increaseArea: '20%' // optional
                                                });
                                            });
                                        </script>
                                        </head>

                                        <body>
                                            <div class="login-box">
                                                <div class="login-logo">
                                                    <a href="#"><b>IBeauty</b>Salon</a>
                                                </div>
                                                <!-- /.login-logo -->
                                                <div class="login-box-body">
                                                    <p class="login-box-msg">Selecione o tipo de usuário</p>
                                                    <!-- radio -->
                                                    <div class="form-group">       
                                                        <div class="form-group">
                                                            <label>
                                                                <input  type="radio" name="r1" value="fisica" class="minimal" checked/>
                                                            </label>                
                                                            <label id="1">                  
                                                                Pessoa Física
                                                            </label>
                                                            <p></p>
                                                            <label>
                                                                <input type="radio" name="r1" value="juridica" class="minimal" />
                                                            </label>                
                                                            <label id="2">                  
                                                                Pessoa Jurídica
                                                            </label>

                                                        </div>
                                                    </div>
                                                    <button type="button"class="btn btn-block btn-default btn-flat" onClick="check_sex();">Avançar</button>   
                                                    <!-- /.col -->
                                                </div>         

                                            </div>
                                            <!-- /.login-box-body -->

                                        </body>
                                        </html>
