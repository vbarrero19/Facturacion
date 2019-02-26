/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author Javier
 */
public class EntidadTipoEntidad {

    private String id_entidad;
    private String id_tipo_entidad;

    public EntidadTipoEntidad() {
    }

    public EntidadTipoEntidad(String id_entidad, String id_tipo_entidad) {
        this.id_entidad = id_entidad;
        this.id_tipo_entidad = id_tipo_entidad;
    }

    public String getId_entidad() {
        return id_entidad;
    }

    public void setId_entidad(String id_entidad) {
        this.id_entidad = id_entidad;
    }

    public String getId_tipo_entidad() {
        return id_tipo_entidad;
    }

    public void setId_tipo_entidad(String id_tipo_entidad) {
        this.id_tipo_entidad = id_tipo_entidad;
    }

}
