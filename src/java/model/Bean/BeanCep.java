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
public class BeanCep {
   private String cep_cep;
   private String rua;
   private BeanBairro cep_bai_codigo;

    public String getCep_cep() {
        return cep_cep;
    }

    public void setCep_cep(String cep_cep) {
        this.cep_cep = cep_cep;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public BeanBairro getCep_bai_codigo() {
        return cep_bai_codigo;
    }

    public void setCep_bai_codigo(BeanBairro cep_bai_codigo) {
        this.cep_bai_codigo = cep_bai_codigo;
    }
   
    
}
