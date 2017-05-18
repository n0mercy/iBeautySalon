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
public class BeanEndereco {
    private int end_codigo;
    private String end_ref;
    private String end_compl;
    private String end_num;
    private BeanCep end_cep;

    public BeanEndereco() {
    }
    
    

    public int getEnd_codigo() {
        return end_codigo;
    }

    public void setEnd_codigo(int end_codigo) {
        this.end_codigo = end_codigo;
    }

    public String getEnd_ref() {
        return end_ref;
    }

    public void setEnd_ref(String end_ref) {
        this.end_ref = end_ref;
    }

    public String getEnd_compl() {
        return end_compl;
    }

    public void setEnd_compl(String end_compl) {
        this.end_compl = end_compl;
    }

    public String getEnd_num() {
        return end_num;
    }

    public void setEnd_num(String end_num) {
        this.end_num = end_num;
    }

    public BeanCep getEnd_cep() {
        return end_cep;
    }

    public void setEnd_cep(BeanCep end_cep) {
        this.end_cep = end_cep;
    }
    
}
