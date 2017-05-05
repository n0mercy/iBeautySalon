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
public class BeanCliente {
 
    private String cli_cpf;
    private String cli_nome;
    private Date cli_dtnasc;
    private BeanUsuario cli_usu_codigo;

    public String getCli_cpf() {
        return cli_cpf;
    }

    public void setCli_cpf(String cli_cpf) {
        this.cli_cpf = cli_cpf;
    }

    public String getCli_nome() {
        return cli_nome;
    }

    public void setCli_nome(String cli_nome) {
        this.cli_nome = cli_nome;
    }

    public Date getCli_dtnasc() {
        return cli_dtnasc;
    }

    public void setCli_dtnasc(Date cli_dtnasc) {
        this.cli_dtnasc = cli_dtnasc;
    }

    public BeanUsuario getCli_usu_codigo() {
        return cli_usu_codigo;
    }

    public void setCli_usu_codigo(BeanUsuario cli_usu_codigo) {
        this.cli_usu_codigo = cli_usu_codigo;
    }
    
}
