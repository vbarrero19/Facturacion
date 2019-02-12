
package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class TipoEntidad {
    
    private String id_tipo_entidad;
    private String tipo_entidad;
    
    //CONSTRUCTOR VACIO
    public TipoEntidad(){        
        
    }
        /*CREAMOS UN CONSTRUCTOR PARA CARGAR EL COMBO DEL TIPO DE ENTIDAD DE LA ENTIDAD (CLIENTE, PROVEEDOR...) QUE RECOGEMOS DE LA TABLA TIPO ENTIDAD Y
    LO GUARDAMOS DENTRO DE LA PRIMERA PESTAÑA DE ENTIDADESVIEW*/
    public TipoEntidad(String id_tipo_entidad, String tipo_entidad) {
        this.id_tipo_entidad = id_tipo_entidad;
        this.tipo_entidad = tipo_entidad;
    }
        
    public String getId_tipo_entidad() {
        return id_tipo_entidad;
    }

    public void setId_tipo_entidad(String id_tipo_entidad) {
        this.id_tipo_entidad = id_tipo_entidad;
    }

    public String getTipo_entidad() {
        return tipo_entidad;
    }

    public void setTipo_entidad(String tipo_entidad) {
        this.tipo_entidad = tipo_entidad;
    }
    
    
}
