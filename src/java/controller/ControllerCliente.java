/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Bean.BeanBairro;
import model.Bean.BeanCep;
import model.Bean.BeanCliente;
import model.Bean.BeanEmpresa;
import model.Bean.BeanEndereco;
import model.Bean.BeanFones;
import model.Bean.BeanTipoUsuario;
import model.Bean.BeanUsuario;
import model.Bean.BeanZona;
import model.Dao.DaoBairro;
import model.Dao.DaoCep;
import model.Dao.DaoCliente;
import model.Dao.DaoEmpresa;
import model.Dao.DaoEndereco;
import model.Dao.DaoFones;
import model.Dao.DaoTipoUsuario;
import model.Dao.DaoUsuario;
import model.Dao.DaoZona;

/**
 *
 * @author n0mercy
 */
@WebServlet(name = "ControllerCliente", urlPatterns = "/ControllerCliente/*")
public class ControllerCliente extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControllerCliente</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerCliente at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        System.out.println("Ajax in action");
        BeanCep cep = null;
        BeanZona zona = new BeanZona();
        BeanBairro bairro = new BeanBairro();

        if (request.getParameter("cep") != null) {
            try {
                System.out.println("findCep : true");

                cep = new DaoCep().findByCodigo(request.getParameter("cep"));
                bairro = new DaoBairro().findByCodigo(cep.getCep_bai_codigo().getBai_codigo());
                zona = new DaoZona().findByCodigo(bairro.getBai_zona_cod().getZona_cod());
                sb.append(cep.getRua());
                sb.append(",");
                sb.append(bairro.getBai_nome());
                sb.append(":");
                sb.append(zona.getZona_nome());
            } catch (SQLException ex) {
                Logger.getLogger(ControllerCliente.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {

        }
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(sb.toString());

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //param "save" describe the page origin (cadClienteJuridico.jsp) = Pessoa Jurídica
        if (request.getParameter("save") != null && request.getParameter("save").equals("cadClienteJuridico")) {

            //init Beans
            BeanCep cep = new BeanCep();
            BeanEmpresa emp = new BeanEmpresa();
            BeanUsuario user = new BeanUsuario();
            BeanTipoUsuario tipoUser = new BeanTipoUsuario();
            BeanEndereco end = new BeanEndereco();
            BeanFones fone = new BeanFones();
            BeanZona zona = new BeanZona();
            BeanBairro bairro = new BeanBairro();

            //Company
            emp.setEmp_razao(request.getParameter("razao"));
            emp.setEmp_cnpj(request.getParameter("cnpj"));
            emp.setEmp_insc_estadual(request.getParameter("inscestadual"));

            //Phone
            fone.setFon_fones(request.getParameter("telefone1"));

            //Address
            end.setEnd_ref(request.getParameter("ref"));
            end.setEnd_num(request.getParameter("numero"));

            //User
            user.setUsu_email(request.getParameter("email"));
            user.setUsu_senha(request.getParameter("senha"));
            user.setUsu_status("Ativo");

            //buscando cadastros auxiliares
            try {
                tipoUser = new DaoTipoUsuario().findByCodigo(3);//tipo_user(3) = Juridico
                user.setUsu_tipo_codigo(tipoUser);//set tipo_user to Usuario
                cep = new DaoCep().findByCodigo(request.getParameter("cep"));//find obj cep
                zona = new DaoZona().findByDescricao(request.getParameter("zona"));//find obj zona
                bairro = new DaoBairro().findByDescricao(request.getParameter("bairro"));//find obj bairro
            } catch (SQLException ex) {
                Logger.getLogger(ControllerCliente.class.getName()).log(Level.SEVERE, "Error Foreign try/catch", ex);
            }

            //save methods
            try {
                //save Address
                new DaoEndereco().save(end);//save endereco and return your PK
                if (end.getEnd_codigo() > 0) {//if true, show message true on log
                    System.out.println("Endereço save : true");
                    end.setEnd_cep(cep);//set cep to endereco
                    user.setUsu_end_cep(end);//set endereco to Usuario
                } else {
                    System.out.println("Endereço save : false");
                    System.out.println("Erro ao atribuir endereço para cliente: " + user.getUsu_email());
                }
                //save User
                new DaoUsuario().save(user);//save Usuario and return your PK
                if (user.getUsu_codigo() > 0) {//if true, show message on log
                    System.out.println("Usuario save : true");
                    emp.setEmp_usu_codigo(user);//set Usuario to empresa_usuario
                    fone.setFon_usu_cod(user);//set Usuario to Fone
                } else {
                    System.out.println("Usuario save : false");
                    System.out.println("Erro ao atribuir fone para cliente, ou cliente para empresa: " + emp.getEmp_razao());
                }
                //save Company
                new DaoEmpresa().save(emp, false);//save Empresa
                if (emp.getEmp_cnpj() != null) {//check cpnj != null and show messages
                    System.out.println("Empresa save : true");
                } else {
                    System.out.println("Empresa save : false");
                }

            } catch (SQLException ex) {
                Logger.getLogger(ControllerCliente.class.getName()).log(Level.SEVERE, "Error nos métodos save()", ex);
            }

            //param "save" describe the page origin (cadClienteFisica.jsp) = Pessoa Física
        } else if (request.getParameter("save") != null && request.getParameter("save").equals("cadClienteFisica")) {

            //init Beans
            BeanCep cep = new BeanCep();
            BeanUsuario user = new BeanUsuario();
            BeanTipoUsuario tipoUser = new BeanTipoUsuario();
            BeanEndereco end = new BeanEndereco();
            BeanFones fone = new BeanFones();
            BeanZona zona = new BeanZona();
            BeanBairro bairro = new BeanBairro();
            BeanCliente cliente = new BeanCliente();

            //value confirm password [to do]
            String confirm = request.getParameter("confirm_senha");

            //client
            cliente.setCli_cpf(request.getParameter("cpf"));
            cliente.setCli_nome(request.getParameter("nome"));
            cliente.setCli_dtnasc(new Date());

            //user
            user.setUsu_email(request.getParameter("email"));
            user.setUsu_senha(request.getParameter("senha"));
            user.setUsu_status("Ativo");

            //address
            end.setEnd_num(request.getParameter("numero"));
            end.setEnd_ref(request.getParameter("ref"));

            //phone
            fone.setFon_fones(request.getParameter("telefone1"));
            System.out.println("Telefone: " + request.getParameter("telefone1"));

            //buscando cadastros auxiliares
            try {
                tipoUser = new DaoTipoUsuario().findByCodigo(2);//find tipo_user 2 = (Pessoa Física)
                cep = new DaoCep().findByCodigo(request.getParameter("cep"));//find cep
                end.setEnd_cep(cep);//set cep to endereco
                user.setUsu_tipo_codigo(tipoUser);//set tipo_user to Usuario
            } catch (SQLException ex) {
                Logger.getLogger(ControllerCliente.class.getName()).log(Level.SEVERE, "Erro ao buscar cadastros auxiliares", ex);
            }

            //save methods
            try {
                //save address
                new DaoEndereco().save(end);//save endereco and return your PK
                if (end.getEnd_codigo() > 0) {//if true, set endereco to usuario
                    System.out.println("Save Address : true");
                    user.setUsu_end_cep(end);
                } else {
                    System.out.println("Save Address : false");
                }

                //save user
                new DaoUsuario().save(user);//save usuario and return your PK
                if (user.getUsu_codigo() > 0) {
                    System.out.println("Save User : true: " + user.getUsu_codigo());
                    fone.setFon_usu_cod(user);//set usuario to fone
                    cliente.setCli_usu_codigo(user);//set usuario to cliente
                } else {
                    System.out.println("Save User : false");
                }

                //save phone
                new DaoFones().save(fone, false);//save fone and return your PK
                if (fone.getFon_fones() != null) {
                    System.out.println("Save Phone : true");
                } else {
                    System.out.println("Save Phone : true");
                }

                //save Client
                new DaoCliente().save(cliente, false);
                if(cliente.getCli_cpf() != null)
                    System.out.println("Save Cliente : true");
                else
                    System.out.println("Save Cliente : false");

            } catch (SQLException ex) {
                Logger.getLogger(ControllerCliente.class.getName()).log(Level.SEVERE, "Erro nos métodos save()", ex);
            }
        }
        //return to page.jsp
        response.sendRedirect("login/login.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
