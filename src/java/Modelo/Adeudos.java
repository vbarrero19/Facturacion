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
public class Adeudos  { 
    private String id_adeudo;
    private String id_empresa;
    private String id_factura;
    private String id_cliente;
    private Double cantidad;
    private String impuesto; 
    private String adeudo;
    private String fecha_cargo; 
    private String fecha_vencimiento; 

    public Adeudos(String id_adeudo, String adeudo) {
        this.id_adeudo = id_adeudo;
        this.adeudo = adeudo;
    } 
    
    public Adeudos() {
        
    }        

    public String getId_adeudo() {
        return id_adeudo;
    }

    public void setId_adeudo(String id_adeudo) {
        this.id_adeudo = id_adeudo;
    }

    public String getId_empresa() {
        return id_empresa;
    }

    public void setId_empresa(String id_empresa) {
        this.id_empresa = id_empresa;
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

    public Double getCantidad() {
        return cantidad;
    }

    public void setCantidad(Double cantidad) {
        this.cantidad = cantidad;
    }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }

    public String getAdeudo() {
        return adeudo;
    }

    public void setAdeudo(String adeudo) {
        this.adeudo = adeudo;
    }

    public String getFecha_cargo() {
        return fecha_cargo;
    }

    public void setFecha_cargo(String fecha_cargo) {
        this.fecha_cargo = fecha_cargo;
    }

    public String getFecha_vencimiento() {
        return fecha_vencimiento;
    }

    public void setFecha_vencimiento(String fecha_vencimiento) {
        this.fecha_vencimiento = fecha_vencimiento;
    }

    
    
}
