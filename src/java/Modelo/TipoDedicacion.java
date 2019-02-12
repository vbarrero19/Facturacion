package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;
public class TipoDedicacion {
    private String id_dedicacion;
    private String dedicacion;
    
    //CONSTRUCTOR VACIO 
    public TipoDedicacion(){        
        
    }

    //CREAMOS UN CONSTRUCTOR PARA CARGAR EL COMBO DEL TIPO DE DEDICACION DE LA ENTIDAD(facturacion, mantenimiento, profesor, director...) PRIMERA PESTAÑA DE ENTIDADESVIEW
    public TipoDedicacion(String id_dedicacion, String dedicacion) {
        this.id_dedicacion = id_dedicacion;
        this.dedicacion = dedicacion;
    }
        
    
    //GETTERS Y SETTERS
    public String getId_dedicacion() {
        return id_dedicacion;
    }

    public void setId_dedicacion(String id_dedicacion) {
        this.id_dedicacion = id_dedicacion;
    }

    public String getDedicacion() {
        return dedicacion;
    }

    public void setDedicacion(String dedicacion) {
        this.dedicacion = dedicacion;
    }
    
    
}