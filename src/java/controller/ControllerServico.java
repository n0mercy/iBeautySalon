/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Bean.BeanEmpresa;
import model.Bean.BeanOferece;
import model.Bean.BeanServico;
import model.Dao.DaoEmpresa;
import model.Dao.DaoOferece;
import model.Dao.DaoServico;

/**
 *
 * @author VaiDiegoo
 */
@WebServlet(name = "ControllerServico", urlPatterns = {"/ControllerServico"})
public class ControllerServico extends HttpServlet {

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
            out.println("<title>Servlet ControllerServico</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerServico at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        BeanServico serv;
        DaoServico daoServ = new DaoServico();
        String urlRequest = request.getParameter("page");
        String path = null;
        if (urlRequest.equals("cadServico")) {
            serv = new BeanServico();
            String status = "ativo";
            serv.setServ_nome(request.getParameter("txtdesc"));
            serv.setServ_status(status);
            try {
                daoServ.salvarServico(serv);
            } catch (SQLException ex) {
                Logger.getLogger(ControllerServico.class.getName()).log(Level.SEVERE, null, ex);
            }
            path = "/example/forms/cadServico.jsp";
        }
        if (urlRequest.equals("adicionarServicos")) {
            BeanOferece ofe;
            String tmp[] = request.getParameterValues("preco_servico");
            String paramsIDServico[] = request.getParameterValues("selected_services");
            String paramsPrice[] = new String[tmp.length];
            int count = 0;

            for (String t : tmp) {
                if (t != null && !t.trim().isEmpty()) {
                    paramsPrice[count] = t;
                    count++;
                }
            }

            try {
                BeanEmpresa emp = new DaoEmpresa().findByCnpj(request.getParameter("empresa_cnpj"));
                for (int i = 0; i < paramsIDServico.length; i++) {
                    serv = new BeanServico();
                    serv = new DaoServico().findByCodigo(Integer.parseInt(paramsIDServico[i]));
                    ofe = new BeanOferece();
                    ofe.setOfe_emp_cnpj(emp);
                    ofe.setOfe_serv_codigo(serv);
                    ofe.setOfe_status("Ativo");
                    ofe.setOfe_valor(Double.parseDouble(paramsPrice[i]));
                    new DaoOferece().save(ofe);

                }
            } catch (SQLException ex) {
                Logger.getLogger(ControllerServico.class.getName()).log(Level.SEVERE, null, ex);
            }

            path = "/example/forms/adicionarServicos.jsp";
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
