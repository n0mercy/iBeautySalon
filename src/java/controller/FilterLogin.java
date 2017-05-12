/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author n0mercy
 */
@WebFilter(filterName = "Filter Login", urlPatterns = {"/example/*","/forms/*","/pages/*"})
public class FilterLogin implements Filter{

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
            HttpSession session = ((HttpServletRequest)request).getSession();
             if(session.getAttribute("user") == null){
                System.out.println("Filter: user null");
                session.setAttribute("msg","Você não está logado no sistema!");
                ((HttpServletResponse)response).sendRedirect("login/login.jsp");
            }else{
                    System.out.println("Filter: user não null");
                    chain.doFilter(request, response);
            }
        
    }

    @Override
    public void destroy() {
        
    }
    
}
