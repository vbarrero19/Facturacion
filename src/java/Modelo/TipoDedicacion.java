
package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;
public class TipoDedicacion {
    private String id_dedicacion;
    private String dedicacion;
    
    public TipoDedicacion(){        
        
    }

    //CREAMOS UN CONSTRUCTOR PARA CARGAR EL COMBO DEL TIPO DE DEDICACION DE LA ENTIDAD
    public TipoDedicacion(String id_dedicacion, String dedicacion) {
        this.id_dedicacion = id_dedicacion;
        this.dedicacion = dedicacion;
    }
        

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
