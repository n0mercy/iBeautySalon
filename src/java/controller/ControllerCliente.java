/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Bean.BeanBairro;
import model.Bean.BeanCep;
import model.Bean.BeanEmpresa;
import model.Bean.BeanEndereco;
import model.Bean.BeanFones;
import model.Bean.BeanUsuario;
import model.Bean.BeanZona;
import model.Dao.DaoEmpresa;

/**
 *
 * @author n0mercy
 */
@WebServlet(name = "ControllerCliente", urlPatterns = {"/ControllerCliente"})
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
        BeanEmpresa emp = new BeanEmpresa();
        BeanUsuario user = new BeanUsuario();
        BeanEndereco end = new BeanEndereco();
        BeanCep cep = new BeanCep();
        BeanFones fone = new BeanFones();
        BeanZona zona = new BeanZona();
        BeanBairro bairro = new BeanBairro();
        
        emp.setEmp_razao(request.getParameter("razao"));
        emp.setEmp_cnpj(request.getParameter("cnpj"));
        emp.setEmp_insc_estadual(request.getParameter("inscestadual"));
        fone.setFon_fones(request.getParameter("telefone1")+"/"+request.getParameter("telefone2"));
        cep.setCep_cep(request.getParameter("cep"));
        end.setEnd_ref(request.getParameter("ref"));
        end.setEnd_num(request.getParameter("numero"));
        cep.setRua(request.getParameter("rua"));
        user.setUsu_email(request.getParameter("email"));
        user.setUsu_senha(request.getParameter("senha"));
        int z = (Integer.parseInt(request.getParameter("zona")));
        int b = (Integer.parseInt(request.getParameter("bairro")));
        
        
        
        
        
                
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
