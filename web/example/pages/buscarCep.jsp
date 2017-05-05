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
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Buscar Salão | IBeautySalon</title>
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
  <!-- iCheck -->
  <link rel="stylesheet" href="../../plugins/iCheck/square/blue.css">
      
  <link jsf:library="bootstrap" jsf:name="bootstrap.min.css" />
</head>
<body>
<div class="login-box">
  <div class="login-logo">
    <a href="../../index2.html"><b>IBeauty</b>Salon</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Preencha o seu cep abaixo</p>

    <div class="input-group input-group-sm">
                <input type="text" class="form-control">
                    <span class="input-group-btn">
                      <button type="button" class="btn btn-info btn-flat">Buscar</button>
                    </span>                                            
              </div>
        <!-- /.col -->
      </div>   
  </div>
  <!-- /.login-box-body -->
</div>  <!-- /.Começa a div da tabela -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>                 
                  <th>Nome</th>
                  <th>Complemento</th> 
                  <th>Rua</th>
                  <th>Bairro</th>
                  <th>Referência</th> 
                </tr>
                </thead>
                <tbody>
                     <%
                         BeanEmpresa emp = new BeanEmpresa();
                         DaoEmpresa daoemp = new DaoEmpresa();
                         Connection con=Conexao.getConnection();
                         Integer codEmp;                         
                         ResultSet rs;
                         Statement stm;                        
                         PreparedStatement pstm;
                         String sql ="select emp_razao,end_compl,cep_rua,bai_nome,end_ref from empresa_usuario inner join "
                                 + "usuario on emp_usu_codigo = usu_codigo inner join "
                                 + "tipo_usuario on usu_tipo_codigo= tipo_codigo inner join "
                                 + "endereco on usu_end_cep = end_codigo inner join "
                                 + "cep on end_cep= cep_cep inner join "
                                 + "bairro on cep_bai_codigo=bai_codigo inner join "
                                 + "zona on bai_zona_cod=zona_cod  where usu_status='Ativo';";
                            pstm=con.prepareStatement(sql);
                            rs=pstm.executeQuery(sql);
                            rs.first();                                                       
                       if(rs.first()==false){
                    %>
                <tr>
                    <td colspan="6" align="center">
                        <b><%out.println("Não existem empresas cadastrados");%></b>
                        
                    </td>                    
                </tr>
                <%
                        }else{
                        do{
                    %>
                <tr>                 
                   <td ><%=rs.getString("emp_razao")%>
                       <td ><%=rs.getString("end_compl")%>
                           <td ><%=rs.getString("cep_rua")%>
                                  <td ><%=rs.getString("bai_nome")%>
                                         <td ><%=rs.getString("end_ref")%>
                </tr>                                   
                                    <%
                        }while(rs.next());
}%>                                               
                </tbody>               
              </table>
            </div>
<!-- jQuery 2.2.3 -->
<script src="../../plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../../bootstrap/js/bootstrap.min.js"></script>
<!-- iCheck -->
<script src="../../plugins/iCheck/icheck.min.js"></script>
<script>
  $(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
  });
</script>

</body>
</html>
