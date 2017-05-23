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
public class BeanUsuario {
    
    private int usu_codigo;
    private String usu_status;
    private String usu_senha;
    private String usu_email;
    private BeanEndereco usu_end_codigo;
    private BeanTipoUsuario usu_tipo_codigo;

    public BeanUsuario() {
    }
    
    

    public int getUsu_codigo() {
        return usu_codigo;
    }

    public void setUsu_codigo(int usu_codigo) {
        this.usu_codigo = usu_codigo;
    }

    public String getUsu_status() {
        return usu_status;
    }

    public void setUsu_status(String usu_status) {
        this.usu_status = usu_status;
    }

    public String getUsu_senha() {
        return usu_senha;
    }

    public void setUsu_senha(String usu_senha) {
        this.usu_senha = usu_senha;
    }

    public String getUsu_email() {
        return usu_email;
    }

    public void setUsu_email(String usu_email) {
        this.usu_email = usu_email;
    }

    public BeanEndereco getUsu_end_codigo() {
        return usu_end_codigo;
    }

    public void setUsu_end_codigo(BeanEndereco usu_end_codigo) {
        this.usu_end_codigo = usu_end_codigo;
    }

    public BeanTipoUsuario getUsu_tipo_codigo() {
        return usu_tipo_codigo;
    }

    public void setUsu_tipo_codigo(BeanTipoUsuario usu_tipo_codigo) {
        this.usu_tipo_codigo = usu_tipo_codigo;
    }
    
    
}
