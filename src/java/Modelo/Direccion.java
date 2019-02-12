
package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class Direccion {
    private String id_direccion;
    private String id_tipo_direccion;
    private String tipo_via;
    private String nombre_via;
    private String numero_via;
    private String numero_portal;
    private String resto_direccion;
    private String codigo_postal;
    private String localidad;
    private String provincia;
    private String pais;

    //CONSTRUCTOR VACIO
    public Direccion() {
        
    }

//    public Direccion(String id_direccion, String id_tipo_direccion, String tipo_via, String nombre_via, String numero_via, String numero_portal, String resto_direccion, String codigo_postal, String localidad, String provincia, String pais) {
//        this.id_direccion = id_direccion;
//        this.id_tipo_direccion = id_tipo_direccion;
//        this.tipo_via = tipo_via;
//        this.nombre_via = nombre_via;
//        this.numero_via = numero_via;
//        this.numero_portal = numero_portal;
//        this.resto_direccion = resto_direccion;
//        this.codigo_postal = codigo_postal;
//        this.localidad = localidad;
//        this.provincia = provincia;
//        this.pais = pais;
//    }
    

  

    
    //GETTERS Y SETTERS
    public String getId_direccion() {
        return id_direccion;
    }

    public void setId_direccion(String id_direccion) {
        this.id_direccion = id_direccion;
    }

    public String getId_tipo_direccion() {
        return id_tipo_direccion;
    }

    public void setId_tipo_direccion(String id_tipo_direccion) {
        this.id_tipo_direccion = id_tipo_direccion;
    }

    public String getTipo_via() {
        return tipo_via;
    }

    public void setTipo_via(String tipo_via) {
        this.tipo_via = tipo_via;
    }

    public String getNombre_via() {
        return nombre_via;
    }

    public void setNombre_via(String nombre_via) {
        this.nombre_via = nombre_via;
    }

    public String getNumero_via() {
        return numero_via;
    }

    public void setNumero_via(String numero_via) {
        this.numero_via = numero_via;
    }

    public String getNumero_portal() {
        return numero_portal;
    }

    public void setNumero_portal(String numero_portal) {
        this.numero_portal = numero_portal;
    }

    public String getResto_direccion() {
        return resto_direccion;
    }

    public void setResto_direccion(String resto_direccion) {
        this.resto_direccion = resto_direccion;
    }

    public String getCodigo_postal() {
        return codigo_postal;
    }

    public void setCodigo_postal(String codigo_postal) {
        this.codigo_postal = codigo_postal;
    }

    public String getLocalidad() {
        return localidad;
    }

    public void setLocalidad(String localidad) {
        this.localidad = localidad;
    }

    public String getProvincia() {
        return provincia;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

}
