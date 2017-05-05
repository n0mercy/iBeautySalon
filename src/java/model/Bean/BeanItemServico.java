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
public class BeanItemServico {
    private int itemserv_codigo;
    private Date itemserv_data;
    private BeanOferece itemserv_ofe_cod;
    private BeanCupom itemserv_cupom_cod;
    private BeanFuncionario itemserv_func_cod;

    public int getItemserv_codigo() {
        return itemserv_codigo;
    }

    public void setItemserv_codigo(int itemserv_codigo) {
        this.itemserv_codigo = itemserv_codigo;
    }

    public Date getItemserv_data() {
        return itemserv_data;
    }

    public void setItemserv_data(Date itemserv_data) {
        this.itemserv_data = itemserv_data;
    }

    public BeanOferece getItemserv_ofe_cod() {
        return itemserv_ofe_cod;
    }

    public void setItemserv_ofe_cod(BeanOferece itemserv_ofe_cod) {
        this.itemserv_ofe_cod = itemserv_ofe_cod;
    }

    public BeanCupom getItemserv_cupom_cod() {
        return itemserv_cupom_cod;
    }

    public void setItemserv_cupom_cod(BeanCupom itemserv_cupom_cod) {
        this.itemserv_cupom_cod = itemserv_cupom_cod;
    }

    public BeanFuncionario getItemserv_func_cod() {
        return itemserv_func_cod;
    }

    public void setItemserv_func_cod(BeanFuncionario itemserv_func_cod) {
        this.itemserv_func_cod = itemserv_func_cod;
    }
    
    
}
