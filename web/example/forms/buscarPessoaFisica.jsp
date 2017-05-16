<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Buscar Pessoa Fisica | IBeautySalon</title>
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
</head>

<body  >
    
    <div class="wrapper">
<!-- /.example-modal -->

      <div class="example-modal ">
        <div class="modal">           
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Buscar Pessoa Fisíca</h4>
              </div>
                <div class="form-group">                
                 <label>Cpf</label>
                <div class="input-group">

                <input type="text" class="form-control" data-inputmask='"000.000.000-00"' data-mask>                    <span class="input-group-btn">
                      <button type="button" class="btn btn-info btn-flat">Pesquisar</button>
                    </span>                                            
              </div>                                                  
              </div>
              <div class="modal-body">
                <div class="form-group">
                    <label>Nome</label>
                  <input type="text" disabled="disabled" class="form-control" placeholder="Nome">
                </div>
                  <label>Cpf</label>
                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-child"></i>
                  </div>
                  <input type="text" name="inscestadual" disabled="disabled" class="form-control" data-inputmask="'insc estadual'" data-mask>
                </div>                                                                
                <label>Data Nascimento</label>
                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa  fa-calendar-minus-o"></i>
                  </div>
                  <input type="text" name="inscestadual" disabled="disabled" class="form-control" data-inputmask="'insc estadual'" data-mask>
                </div>
                <div class="form-group">
                <label>Fones</label>

                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-phone"></i>
                  </div>
                  <input type="text" disabled="disabled" class="form-control" data-inputmask='"mask": "(92) 99999-9999"' data-mask>
                  
                  <input type="text" disabled="disabled" class="form-control" data-inputmask='"mask": "(92) 99999-9999"' data-mask>
                </div>                                                           
              </div>                
                 <!-- SELECT2 EXAMPLE -->
      <div class="box box-default">
        <div class="box-header with-border">
          <h3 class="box-title">Endereço</h3>

          <div class="box-tools pull-right">
            <button type="button" disabled="disabled" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>            
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
          <div class="row">
            <div class="col-md-6">              
              <!-- /.form-group -->
              <div class="form-group">
                <label>Referência</label>
                  <input type="text" disabled="disabled" class="form-control" placeholder="Ponto de Referência">
              </div>
              
              <div class="form-group">
                <label>Número</label>
                  <input type="text" disabled="disabled" class="form-control" placeholder="N°">
              </div>
              <!-- /.form-group -->
            </div>
            <!-- /.col -->
            <div class="col-md-6">
              <div class="form-group">
                <label>Bairro</label>
                <select class="form-control select2" disabled="disabled" style="width: 100%;">
                  <option selected="selected">Compensa 1</option>
                  <option>Alvorada</option>
                  <option>Colonia</option>                  
                </select>
              </div>
              
              <div class="form-group">
                <label>Zona</label>
                <select class="form-control select2" disabled="disabled" style="width: 100%;">
                  <option selected="selected">Oeste</option>
                  <option>Norte</option>
                  <option>Sul</option>                  
                </select>
              </div>            
              <!-- /.form-group -->
            
            </div>
            <div class="form-group">
                <div class="form-group">
                <label>Rua</label>
                  <input type="text" class="form-control" disabled="disabled" placeholder="Rua">
              </div>
                
            </div>
            <!-- /.col -->            
          </div>
          <!-- /.row -->
        </div>
        <!-- /.box-body -->        
      </div>
                 <div class="form-group">
                  <label for="exampleInputEmail1">Email</label>
                  <input type="email" disabled="disabled" class="form-control" id="exampleInputEmail1" placeholder="Email">
                </div> 
                    <div class="form-group">
                <label>Status</label>
                <select class="form-control select2"  style="width: 100%;">
                  <option selected="selected">Ativo</option>
                  <option>Desativado</option>                  
                </select>
              </div>                 
              </div>
              </div>
              <div class="modal-footer">               
               <button type="button" class="btn btn-block btn-default btn-flat btn btn-primary pull-left">Salvar Cliente</button>                               
              </div>
                
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>
      <!-- ./wrapper -->
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
