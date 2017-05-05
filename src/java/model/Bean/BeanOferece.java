/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.Bean;

/**
 *
 * @author VaiDiegoo
 */
public class BeanOferece {
    private int ofe_codigo;
    private String ofe_status;
    private Double ofe_valor;
    private BeanEmpresa ofe_emp_cnpj;
    private BeanServico ofe_serv_codigo;

    public int getOfe_codigo() {
        return ofe_codigo;
    }

    public void setOfe_codigo(int ofe_codigo) {
        this.ofe_codigo = ofe_codigo;
    }

    public String getOfe_status() {
        return ofe_status;
    }

    public void setOfe_status(String ofe_status) {
        this.ofe_status = ofe_status;
    }

    public Double getOfe_valor() {
        return ofe_valor;
    }

    public void setOfe_valor(Double ofe_valor) {
        this.ofe_valor = ofe_valor;
    }

    public BeanEmpresa getOfe_emp_cnpj() {
        return ofe_emp_cnpj;
    }

    public void setOfe_emp_cnpj(BeanEmpresa ofe_emp_cnpj) {
        this.ofe_emp_cnpj = ofe_emp_cnpj;
    }

    public BeanServico getOfe_serv_codigo() {
        return ofe_serv_codigo;
    }

    public void setOfe_serv_codigo(BeanServico ofe_serv_codigo) {
        this.ofe_serv_codigo = ofe_serv_codigo;
    }
    
    
}
