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
public class BeanFuncionario {
    private int fun_matricula;
    private String fun_nome;
    private BeanEmpresa fun_emp_cnpj;
    private String fun_status;

    public String getFun_status() {
        return fun_status;
    }

    public void setFun_status(String fun_status) {
        this.fun_status = fun_status;
    }
    

    public int getFun_matricula() {
        return fun_matricula;
    }

    public void setFun_matricula(int fun_matricula) {
        this.fun_matricula = fun_matricula;
    }

    public String getFun_nome() {
        return fun_nome;
    }

    public void setFun_nome(String fun_nome) {
        this.fun_nome = fun_nome;
    }

    public BeanEmpresa getFun_emp_cnpj() {
        return fun_emp_cnpj;
    }

    public void setFun_emp_cnpj(BeanEmpresa fun_emp_cnpj) {
        this.fun_emp_cnpj = fun_emp_cnpj;
    }
    
}
