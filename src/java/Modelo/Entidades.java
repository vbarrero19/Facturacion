
package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

//Dentro de la clase Entidades, creamos los getters, setters y constructores.

public class Entidades {
    
    private String id_entidad;
    private String distinct_code;
    private String nombre_entidad;
    private String id_tipo_entidad;
    private String tratamiento;
    private String id_tipo_documento;
    private String numero_documento;
    private String nombre_contacto;
    private String apellido1;
    private String apellido2;
    private String id_dedicacion;
    private String telefono1;
    private String telefono2;
    private String fax;
    private String mail1;
    private String mail2cc;
    private String fecha_alta;
    private String fecha_baja;
    private String activado;
    private String id_direccion;
    
    //Creamos constructor vacío.
    public Entidades(){
    
    }

    public Entidades(String id_entidad, String distinct_code, String nombre_entidad, String id_tipo_entidad, String tratamiento, String id_tipo_documento, String numero_documento, String nombre_contacto, String apellido1, String apellido2, String id_dedicacion, String telefono1, String telefono2, String fax, String mail1, String mail2cc, String fecha_alta, String fecha_baja, String activado, String id_direccion) {
        this.id_entidad = id_entidad;
        this.distinct_code = distinct_code;
        this.nombre_entidad = nombre_entidad;
        this.id_tipo_entidad = id_tipo_entidad;
        this.tratamiento = tratamiento;
        this.id_tipo_documento = id_tipo_documento;
        this.numero_documento = numero_documento;
        this.nombre_contacto = nombre_contacto;
        this.apellido1 = apellido1;
        this.apellido2 = apellido2;
        this.id_dedicacion = id_dedicacion;
        this.telefono1 = telefono1;
        this.telefono2 = telefono2;
        this.fax = fax;
        this.mail1 = mail1;
        this.mail2cc = mail2cc;
        this.fecha_alta = fecha_alta;
        this.fecha_baja = fecha_baja;
        this.activado = activado;
        this.id_direccion = id_direccion;
    }

 

  // CONSTRUCTOR PARA MOSTRAR LOS DATOS DE LAS ENTIDADES EN CARGOSVIEW
    public Entidades(String id_entidad, String distinct_code, String nombre_entidad, String nombre_contacto) {
        this.id_entidad = id_entidad;
        this.distinct_code = distinct_code;
        this.nombre_entidad = nombre_entidad;
        this.nombre_contacto = nombre_contacto;
    }
    
    
    //CONSTRUCTOR PARA MOSTRAR EL COMBO EN VERFACTURAS
    public Entidades(String id_entidad, String distinct_code) {
        this.id_entidad = id_entidad;
        this.distinct_code = distinct_code;
    }   
    
    
    
    //CONSTRUCTOR PARA MOSTRAR EL COMBO DE ENTIDADES DENTRO DE LA PESTAÑA DIRECCION EN ALTA ENTIDADES.
     public Entidades(String id_entidad, String distinct_code, String nombre_entidad) {
        this.id_entidad = id_entidad;
        this.distinct_code = distinct_code;
        this.nombre_entidad = nombre_entidad;
    }

     //Para ver una factura en detalle
    public Entidades(String id_entidad, String nombre_entidad, String tratamiento, String nombre_contacto, String apellido1) {
        this.id_entidad = id_entidad;
        this.nombre_entidad = nombre_entidad;
        this.tratamiento = tratamiento;
        this.nombre_contacto = nombre_contacto;
        this.apellido1 = apellido1;
    }
     

    

    //Getters y Setters

    public String getId_entidad() {
        return id_entidad;
    }

    public void setId_entidad(String id_entidad) {
        this.id_entidad = id_entidad;
    }

    public String getDistinct_code() {
        return distinct_code;
    }

    public void setDistinct_code(String distinct_code) {
        this.distinct_code = distinct_code;
    }

    public String getNombre_entidad() {
        return nombre_entidad;
    }

    public void setNombre_entidad(String nombre_entidad) {
        this.nombre_entidad = nombre_entidad;
    }

    public String getId_tipo_entidad() {
        return id_tipo_entidad;
    }

    public void setId_tipo_entidad(String id_tipo_entidad) {
        this.id_tipo_entidad = id_tipo_entidad;
    }

    public String getTratamiento() {
        return tratamiento;
    }

    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }

    public String getId_tipo_documento() {
        return id_tipo_documento;
    }

    public void setId_tipo_documento(String id_tipo_documento) {
        this.id_tipo_documento = id_tipo_documento;
    }

    public String getNumero_documento() {
        return numero_documento;
    }

    public void setNumero_documento(String numero_documento) {
        this.numero_documento = numero_documento;
    }

    
    public String getNombre_contacto() {
        return nombre_contacto;
    }

    public void setNombre_contacto(String nombre_contacto) {
        this.nombre_contacto = nombre_contacto;
    }

    public String getApellido1() {
        return apellido1;
    }

    public void setApellido1(String apellido1) {
        this.apellido1 = apellido1;
    }

    public String getApellido2() {
        return apellido2;
    }

    public void setApellido2(String apellido2) {
        this.apellido2 = apellido2;
    }

    public String getId_dedicacion() {
        return id_dedicacion;
    }

    public void setId_dedicacion(String id_dedicacion) {
        this.id_dedicacion = id_dedicacion;
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

    public String getMail1() {
        return mail1;
    }

    public void setMail1(String mail1) {
        this.mail1 = mail1;
    }

    public String getMail2cc() {
        return mail2cc;
    }

    public void setMail2cc(String mail2cc) {
        this.mail2cc = mail2cc;
    }

    public String getFecha_alta() {
        return fecha_alta;
    }

    public void setFecha_alta(String fecha_alta) {
        this.fecha_alta = fecha_alta;
    }

    public String getFecha_baja() {
        return fecha_baja;
    }

    public void setFecha_baja(String fecha_baja) {
        this.fecha_baja = fecha_baja;
    }

    public String getActivado() {
        return activado;
    }

    public void setActivado(String activado) {
        this.activado = activado;
    }

    public String getId_direccion() {
        return id_direccion;
    }

    public void setId_direccion(String id_direccion) {
        this.id_direccion = id_direccion;
    }

  
    
        
}
