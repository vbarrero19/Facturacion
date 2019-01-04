/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author nmohamed
 */
public class Cargos  { 
    private String id_cargo;
    private String id_items;
    private String id_factura;
    private String id_cliente;
    private String cantidad;
    private String impuesto; 
    private Date fecha_cargo; 
    private Date fecha_vencimiento; 
    
    
        
    /*
    
     
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

          */

    public String getId_cargo() {
        return id_cargo;
    }

    public void setId_cargo(String id_cargo) {
        this.id_cargo = id_cargo;
    }

    public String getId_items() {
        return id_items;
    }

    public void setId_items(String id_items) {
        this.id_items = id_items;
    }

    public String getId_factura() {
        return id_factura;
    }

    public void setId_factura(String id_factura) {
        this.id_factura = id_factura;
    }

    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }

    public Date getFecha_cargo() {
        return fecha_cargo;
    }

    public void setFecha_cargo(Date fecha_cargo) {
        this.fecha_cargo = fecha_cargo;
    }

    public Date getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(Date fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }
    
    
}
