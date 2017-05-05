/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Bean;

import java.util.Date;

/**
 *
 * @author VaiDiegoo
 */
public class BeanRealiza {
    private int real_cod;
    private Date real_datapag;
    private Double real_valor;
    private Date real_dtVenc;
    private String real_status;
    private BeanPagamento real_pag_codigo;
    private BeanEmpresa real_emp_cnpj;

    public int getReal_cod() {
        return real_cod;
    }

    public void setReal_cod(int real_cod) {
        this.real_cod = real_cod;
    }

    public Date getReal_datapag() {
        return real_datapag;
    }

    public void setReal_datapag(Date real_datapag) {
        this.real_datapag = real_datapag;
    }

    public Double getReal_valor() {
        return real_valor;
    }

    public void setReal_valor(Double real_valor) {
        this.real_valor = real_valor;
    }

    public Date getReal_dtVenc() {
        return real_dtVenc;
    }

    public void setReal_dtVenc(Date real_dtVenc) {
        this.real_dtVenc = real_dtVenc;
    }

    public String getReal_status() {
        return real_status;
    }

    public void setReal_status(String real_status) {
        this.real_status = real_status;
    }

    public BeanPagamento getReal_pag_codigo() {
        return real_pag_codigo;
    }

    public void setReal_pag_codigo(BeanPagamento real_pag_codigo) {
        this.real_pag_codigo = real_pag_codigo;
    }

    public BeanEmpresa getReal_emp_cnpj() {
        return real_emp_cnpj;
    }

    public void setReal_emp_cnpj(BeanEmpresa real_emp_cnpj) {
        this.real_emp_cnpj = real_emp_cnpj;
    }
    
}
