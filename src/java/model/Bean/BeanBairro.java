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
public class BeanBairro {
   
    private int bai_codigo;
    private String bai_nome;
    private BeanZona bai_zona_cod;

    public int getBai_codigo() {
        return bai_codigo;
    }

    public void setBai_codigo(int bai_codigo) {
        this.bai_codigo = bai_codigo;
    }

    public String getBai_nome() {
        return bai_nome;
    }

    public void setBai_nome(String bai_nome) {
        this.bai_nome = bai_nome;
    }

    public BeanZona getBai_zona_cod() {
        return bai_zona_cod;
    }

    public void setBai_zona_cod(BeanZona bai_zona_cod) {
        this.bai_zona_cod = bai_zona_cod;
    }
    
    
}
