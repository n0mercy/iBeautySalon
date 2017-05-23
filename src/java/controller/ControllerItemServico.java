/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import static com.sun.org.apache.xalan.internal.lib.ExsltDatetime.date;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Bean.BeanCliente;
import model.Bean.BeanCupom;
import model.Bean.BeanItemServico;
import model.Bean.BeanOferece;
import model.Bean.BeanPagamento;
import model.Bean.BeanUsuario;
import model.Dao.DaoCliente;
import model.Dao.DaoCupom;
import model.Dao.DaoItemServico;
import model.Dao.DaoOferece;
import model.Dao.DaoPagamento;
import model.Dao.DaoUsuario;
import util.QRCodeUtil;

/**
 *
 * @author n0mercy
 */
@WebServlet(name = "ControllerItemServico", urlPatterns = {"/ControllerItemServico"})
public class ControllerItemServico extends HttpServlet {

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
            out.println("<title>Servlet ControllerItemServico</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerItemServico at " + request.getContextPath() + "</h1>");
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
        BeanItemServico item;
        BeanOferece ofe;
        BeanUsuario user = new BeanUsuario();
        BeanCupom cupom = new BeanCupom();
        BeanCliente cliente = new BeanCliente();
        BeanPagamento pag = new BeanPagamento();
        
        if(request.getSession().getAttribute("user") != null){
            try {
                String email = (String)request.getSession().getAttribute("user");
                user.setUsu_email(email);
                user.setUsu_status("Ativo");
                user = new DaoUsuario().buscarUsuario(user);
                cliente = new DaoCliente().findByUser(user.getUsu_codigo());
                pag = new DaoPagamento().findByCodigo(1);
            } catch (SQLException ex) {
                Logger.getLogger(ControllerItemServico.class.getName()).log(Level.SEVERE, "Error ao pegar usuário da session", ex);
            }
        }
        
        
        String urlRequest = request.getParameter("page");
        String itensOffer[] = request.getParameterValues("selected_services");        
        String selected_id[] = new String[itensOffer.length];
        
        //Date after one month
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        LocalDateTime dateAfter10Days = LocalDateTime.now().plusDays(30);
        Date dt = Date.from(dateAfter10Days.toInstant(ZoneOffset.UTC));
        
        
        int i = 0;
        double total = 0;
        if(urlRequest.equals("itensSalao")){ 
            cupom.setCupom_clicpf(cliente);
            cupom.setCupom_data(new Date());
            cupom.setCupom_validade(dt);
            cupom.setCupom_pag_codigo(pag);
            cupom.setCupom_status("pendente");
            try {
                new DaoCupom().save(cupom);
                System.out.println("CUPOM GERADO: "+cupom.getCupom_codigo());
            } catch (SQLException ex) {
                Logger.getLogger(ControllerItemServico.class.getName()).log(Level.SEVERE, null, ex);
            }
            for(String offer: itensOffer){
                item = new BeanItemServico();
                ofe = new BeanOferece();
                total += Double.parseDouble(offer.substring(0,offer.indexOf(":")));
                selected_id[i] = offer.substring(offer.indexOf(":") + 1);
                System.out.println("SELECTED: "+selected_id[i]);
                try {
                    ofe = new DaoOferece().findByCodigo(Integer.parseInt(selected_id[i]));
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerItemServico.class.getName()).log(Level.SEVERE, "Error na obtenção do objeto Oferece", ex);
                }
                System.out.println("ID OFERECE: "+ofe.getOfe_codigo());
                item.setItemserv_ofe_cod(ofe);
                item.setItemserv_cupom_cod(cupom);
                item.setItemserv_func_cod(null);
                item.setItemserv_data(new Date());
                
                try {
                    new DaoItemServico().save(item);
                    
                } catch (SQLException ex) {
                    Logger.getLogger(ControllerItemServico.class.getName()).log(Level.SEVERE, "Erro ao salvar ItemServico", ex);
                }
                i++;
            }
            QRCodeUtil.generateQRCode(String.valueOf(cupom.getCupom_codigo()));
        }else{
            System.out.println("ERROR SERVLET ITEM");
        }
        
        response.sendRedirect("../cupomPagamento.jsp");
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
