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
public class Items  { 
    private String id_items;
    private String abreviatura;
    private String nombre;
    private String precio;
    private String id_impuesto;

     
    public String getId_items() {
        return id_items;
    }

    public void setId_items(String col1) {
        this.id_items = col1;
    }

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String col2) {
        this.abreviatura = col2;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String col3) {
        this.nombre = col3;
    }

    public String getPrecio() {
        return precio;
    }

    public void sePrecio(String col4) {
        this.precio = col4;
    }

    public String getId_impuesto() {
        return id_impuesto;
    }

    public void setId_impuesto(String col5) {
        this.id_impuesto = col5;
    }         
}
