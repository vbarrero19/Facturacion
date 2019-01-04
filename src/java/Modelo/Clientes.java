/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.io.Serializable;

/**
 *
 * @author nmohamed
 */
public class Clientes {

    private String id_cliente;
    private String id_ident;
    private String id_tipo;
    private String direccion;
    private String telefono;
    private String mail;

    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String col1) {
        this.id_cliente = col1;
    }

    public String getId_ident() {
        return id_ident;
    }

    public void setId_ident(String col2) {
        this.id_ident = col2;
    }
    
     public String getId_tipo() {
        return id_tipo;
    }

    public void setId_tipo(String col3) {
        this.id_tipo = col3;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String col4) {
        this.direccion = col4;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String col5) {
        this.telefono = col5;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String col6) {
        this.mail = col6;
    }
}