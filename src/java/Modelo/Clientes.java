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
    private String nombre_empresa;
    private String tratamiento;
    private String nombre_persona;
    private String mi_persona;
    private String apellido_persona;
    //private String ident_empresa;
    private String num_ident;
    //private String tipo_empresa;
    private String dir_fisica;
    private String dir_fiscal;
    private String pais;
    
    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String col1) {
        this.id_cliente = col1;
    }

    public String getNombre_empresa() {
        return nombre_empresa;
    }

    public void setNombre_empresa(String nombre_empresa) {
        this.nombre_empresa = nombre_empresa;
    }

    public String getTratamiento() {
        return tratamiento;
    }

    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }

    public String getNombre_persona() {
        return nombre_persona;
    }

    public void setNombre_persona(String nombre_persona) {
        this.nombre_persona = nombre_persona;
    }

    public String getMi_persona() {
        return mi_persona;
    }

    public void setMi_persona(String mi_persona) {
        this.mi_persona = mi_persona;
    }

    public String getApellido_persona() {
        return apellido_persona;
    }

    public void setApellido_persona(String apellido_persona) {
        this.apellido_persona = apellido_persona;
    }

//    public String getIdent_empresa() {
//        return ident_empresa;
//    }
//
//    public void setIdent_empresa(String ident_empresa) {
//        this.ident_empresa = ident_empresa;
//    }
    
    
    public String getNum_ident() {
        return num_ident;
    }

    public void setNum_ident(String num_ident) {
        this.num_ident = num_ident;
    }

//    public String getTipo_empresa() {
//        return tipo_empresa;
//    }
//
//    public void setTipo_empresa(String tipo_empresa) {
//        this.tipo_empresa = tipo_empresa;
//    }

    
    public String getDir_fisica() {
        return dir_fisica;
    }

    public void setDir_fisica(String dir_fisica) {
        this.dir_fisica = dir_fisica;
    }


    public String getDir_fiscal() {
        return dir_fiscal;
    }

    public void setDir_fiscal(String dir_fiscal) {
        this.dir_fiscal = dir_fiscal;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    
    
}


    
    
    
    
    

