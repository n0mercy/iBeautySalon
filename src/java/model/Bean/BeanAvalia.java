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
public class BeanAvalia {
    private int avalia_cod;
    private int avalia_like;
    private int avalia_deslike;
    private BeanOferece avalia_ofe_codigo;
    private BeanCliente avalia_cli_cpf;

    public int getAvalia_cod() {
        return avalia_cod;
    }

    public void setAvalia_cod(int avalia_cod) {
        this.avalia_cod = avalia_cod;
    }

    public int getAvalia_like() {
        return avalia_like;
    }

    public void setAvalia_like(int avalia_like) {
        this.avalia_like = avalia_like;
    }

    public int getAvalia_deslike() {
        return avalia_deslike;
    }

    public void setAvalia_deslike(int avalia_deslike) {
        this.avalia_deslike = avalia_deslike;
    }

    public BeanOferece getAvalia_ofe_codigo() {
        return avalia_ofe_codigo;
    }

    public void setAvalia_ofe_codigo(BeanOferece avalia_ofe_codigo) {
        this.avalia_ofe_codigo = avalia_ofe_codigo;
    }

    public BeanCliente getAvalia_cli_cpf() {
        return avalia_cli_cpf;
    }

    public void setAvalia_cli_cpf(BeanCliente avalia_cli_cpf) {
        this.avalia_cli_cpf = avalia_cli_cpf;
    }
    
    
}
