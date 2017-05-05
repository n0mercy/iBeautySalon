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
public class BeanCupom {
    private int cupom_codigo;
    private String cupom_status;
    private Date cupom_data;
    private Date cupom_validade;
    private BeanCliente cupom_clicpf;
    private BeanPagamento cupom_pag_cod;

    public int getCupom_codigo() {
        return cupom_codigo;
    }

    public void setCupom_codigo(int cupom_codigo) {
        this.cupom_codigo = cupom_codigo;
    }

    public String getCupom_status() {
        return cupom_status;
    }

    public void setCupom_status(String cupom_status) {
        this.cupom_status = cupom_status;
    }

    public Date getCupom_data() {
        return cupom_data;
    }

    public void setCupom_data(Date cupom_data) {
        this.cupom_data = cupom_data;
    }

    public Date getCupom_validade() {
        return cupom_validade;
    }

    public void setCupom_validade(Date cupom_validade) {
        this.cupom_validade = cupom_validade;
    }

    public BeanCliente getCupom_clicpf() {
        return cupom_clicpf;
    }

    public void setCupom_clicpf(BeanCliente cupom_clicpf) {
        this.cupom_clicpf = cupom_clicpf;
    }

    public BeanPagamento getCupom_pag_cod() {
        return cupom_pag_cod;
    }

    public void setCupom_pag_codigo(BeanPagamento cupom_pag_cod) {
        this.cupom_pag_cod = cupom_pag_cod;
    }
    
    
}
