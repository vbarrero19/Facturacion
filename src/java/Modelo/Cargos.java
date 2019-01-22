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
    private String id_empresa;
    private String id_factura;
    private String id_cliente;
    private Double cantidad;
    private String impuesto; 
    private String cargo;
    private String fecha_cargo; 
    private String fecha_vencimiento; 

    public Cargos(String id_cargo, String cargo) {
        this.id_cargo = id_cargo;        
        this.cargo = cargo;        
    }

    public Cargos() {
        
    }        

    public String getId_cargo() {
        return id_cargo;
    }

    public void setId_cargo(String id_cargo) {
        this.id_cargo = id_cargo;
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

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
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
