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
public class BeanEmpresa {
    
    private String emp_cnpj;
    private String emp_razao;
    private String emp_insc_estadual;
    private BeanUsuario emp_usu_codigo;

    public BeanEmpresa() {
    }

    
    
    public String getEmp_cnpj() {
        return emp_cnpj;
    }

    public void setEmp_cnpj(String emp_cnpj) {
        this.emp_cnpj = emp_cnpj;
    }

    public String getEmp_razao() {
        return emp_razao;
    }

    public void setEmp_razao(String emp_razao) {
        this.emp_razao = emp_razao;
    }

    public String getEmp_insc_estadual() {
        return emp_insc_estadual;
    }

    public void setEmp_insc_estadual(String emp_insc_estadual) {
        this.emp_insc_estadual = emp_insc_estadual;
    }

    public BeanUsuario getEmp_usu_codigo() {
        return emp_usu_codigo;
    }

    public void setEmp_usu_codigo(BeanUsuario emp_usu_codigo) {
        this.emp_usu_codigo = emp_usu_codigo;
    }
    
    
}
