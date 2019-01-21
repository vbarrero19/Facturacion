

package Modelo;

import java.io.Serializable;


public class Clientes {

    private String id_cliente;
    private String nombre_empresa;
    private String tratamiento;
    private String nombre_persona;
    private String mi_persona;
    private String apellido_persona;
    private String id_fiscal;
    private String num_ident;
    private String tipo_empresa;
    private String dir_fisica;
    private String dir_fiscal;
    private String pais;
    private String mail;
    private String telefono1;
    private String telefono2;
    private String fax;

    public Clientes() {
    }
        
//    public Clientes(String id_cliente, String tipo_empresa) {
//        this.id_cliente = id_cliente;
//        this.tipo_empresa = tipo_empresa;
//    }

    public Clientes(String id_cliente, String nombre_empresa, String dir_fisica, String pais) {
        this.id_cliente = id_cliente;
        this.nombre_empresa = nombre_empresa;
        this.dir_fisica = dir_fisica;
        this.pais = pais;
    }
    
    
    
        
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

    public String getId_fiscal() {
        return id_fiscal;
    }

    public void setId_fiscal(String id_fiscal) {
        this.id_fiscal = id_fiscal;
    }
   
    
    public String getNum_ident() {
        return num_ident;
    }

    public void setNum_ident(String num_ident) {
        this.num_ident = num_ident;
    }

    public String getTipo_empresa() {
        return tipo_empresa;
    }

    public void setTipo_empresa(String tipo_empresa) {
        this.tipo_empresa = tipo_empresa;
    }

    
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

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getTelefono1() {
        return telefono1;
    }

    public void setTelefono1(String telefono1) {
        this.telefono1 = telefono1;
    }

    public String getTelefono2() {
        return telefono2;
    }

    public void setTelefono2(String telefono2) {
        this.telefono2 = telefono2;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }
  
    

}


    
    
    
    
    

