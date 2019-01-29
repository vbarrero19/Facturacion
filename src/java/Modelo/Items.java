/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.io.Serializable;

public class Items  { 
    private String id_item;
    private String abreviatura;
    private String descripcion;
    private String tipo;
    private String cuenta;
    private String importe;
    private String periodo;

    public Items() {
    }

    public Items(String id_item, String abreviatura, String descripcion, String tipo, String cuenta, String importe, String periodo) {
        this.id_item = id_item;
        this.abreviatura = abreviatura;
        this.descripcion = descripcion;
        this.tipo = tipo;
        this.cuenta = cuenta;
        this.importe = importe;
        this.periodo = periodo;
    }

    public String getId_item() {
        return id_item;
    }

    public void setId_item(String id_item) {
        this.id_item = id_item;
    }

    public String getAbreviatura() {
        return abreviatura;
    }

    public void setAbreviatura(String abreviatura) {
        this.abreviatura = abreviatura;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getCuenta() {
        return cuenta;
    }

    public void setCuenta(String cuenta) {
        this.cuenta = cuenta;
    }

    public String getImporte() {
        return importe;
    }

    public void setImporte(String importe) {
        this.importe = importe;
    }

    public String getPeriodo() {
        return periodo;
    }

    public void setPeriodo(String periodo) {
        this.periodo = periodo;
    }
    
}
