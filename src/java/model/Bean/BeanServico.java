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
public class BeanServico {
    private int serv_cod;
    private String serv_nome;
    private String serv_status;

    public int getServ_cod() {
        return serv_cod;
    }

    public void setServ_cod(int serv_cod) {
        this.serv_cod = serv_cod;
    }

    public String getServ_nome() {
        return serv_nome;
    }

    public void setServ_nome(String serv_nome) {
        this.serv_nome = serv_nome;
    }

    public String getServ_status() {
        return serv_status;
    }

    public void setServ_status(String serv_status) {
        this.serv_status = serv_status;
    }

}
