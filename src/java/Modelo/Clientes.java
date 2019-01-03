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
public class Clientes  { 
    private String id_cliente;
    private String direccion;
    private String telefono;
    private String mail;
    private String col5;
    private String col6; 
     
    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String col1) {
        this.id_cliente = col1;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String col2) {
        this.direccion = col2;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String col3) {
        this.telefono = col3;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String col4) {
        this.mail = col4;
    }

    public String getCol5() {
        return col5;
    }

    public void setCol5(String col5) {
        this.col5 = col5;
    }

    public String getCol6() {
        return col6;
    }

    public void setCol6(String col6) {
        this.col6 = col6;
    }

          
}
