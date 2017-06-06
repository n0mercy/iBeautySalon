/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Bean.BeanCupom;
import model.Bean.BeanEmpresa;
import model.Bean.BeanRealiza;
import model.Bean.BeanUsuario;
import model.Dao.DaoCupom;
import model.Dao.DaoEmpresa;
import model.Dao.DaoPagamento;
import model.Dao.DaoRealiza;
import model.Dao.DaoUsuario;

/**
 *
 * @author n0mercy
 */
public class ControllerPagamento extends HttpServlet {

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
            out.println("<title>Servlet ControllerPagamento</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerPagamento at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String action = request.getParameter("submit");
        String page = request.getParameter("page");
        String path = null;
        BeanCupom cupom = new BeanCupom();
        BeanEmpresa emp = new BeanEmpresa();
        BeanRealiza mensa = new BeanRealiza();
        BeanRealiza mensaNova;
        BeanUsuario ususario = new BeanUsuario();
        
        if (page.equals("cupomPagamento")) {
            if (action.equals("confirm")) {
                int cod_cupom = Integer.parseInt(request.getParameter("cupom_id"));
                try {
                    cupom = new DaoCupom().findByCodigo(cod_cupom);
                    cupom.setCupom_status("fechado");
                    new DaoCupom().save(cupom);
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerPagamento.class.getName()).log(Level.SEVERE, null, ex);
                }
                cupom.setCupom_status("cancelado");
                System.out.println("CUPOM CANCELADO: " + cupom.getCupom_codigo() + " : " + cupom.getCupom_status());
            } else {
                int cod_cupom = Integer.parseInt(request.getParameter("cupom_id"));
                try {
                    cupom = new DaoCupom().findByCodigo(cod_cupom);
                    cupom.setCupom_status("cancelado");
                    new DaoCupom().save(cupom);
                    System.out.println("CUPOM CANCELADO: " + cupom.getCupom_codigo() + " : " + cupom.getCupom_status());
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerPagamento.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            path = "/example/pages/buscarCep.jsp";
        } else if (page.equals("pagarMensalidade")) {
            String pagForm = request.getParameter("pagamento");
            //Date after one month
            LocalDateTime dateAfter30Days = LocalDateTime.now().plusDays(30);
            Date dt = Date.from(dateAfter30Days.toInstant(ZoneOffset.UTC));
            try {
                emp = new DaoEmpresa().findByCnpj(request.getParameter("empresa_id"));
                ususario = new DaoUsuario().findByUserSession(emp.getEmp_usu_codigo().getUsu_email());
                ususario.setUsu_status("Ativo");
                new DaoUsuario().save(ususario);
                //update mesalidade = status{pendente to fechado}
                mensa = new DaoRealiza().findByCnpj(emp.getEmp_cnpj());
                mensa.setReal_status("fechado");                
                new DaoRealiza().save(mensa, false, false);
                
                
                //generate next mensalidade
                mensaNova = new BeanRealiza();
                mensaNova.setReal_datapag(new Date());
                mensaNova.setReal_dtVenc(dt);
                mensaNova.setReal_status("pendente");
                mensaNova.setReal_emp_cnpj(emp);
                mensaNova.setReal_pag_codigo(new DaoPagamento().findByCodigo(Integer.parseInt(pagForm)));
                mensaNova.setReal_valor(50.0);
                
                new DaoRealiza().save(mensaNova, false, true);

            } catch (SQLException ex) {
                Logger.getLogger(ControllerPagamento.class.getName()).log(Level.SEVERE, null, ex);
            }
            String msg = "Mensalidade paga com sucesso!";
            path = "/example/pages/pageMessage.jsp?message="+msg;
        }
        response.sendRedirect(request.getContextPath() + path);
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
