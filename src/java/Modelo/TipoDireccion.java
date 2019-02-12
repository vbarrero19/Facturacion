package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class TipoDireccion {
    private String id_tipo_direccion;
    private String tipo_direccion;

    // CONSTRUCTOR VACIO
   public TipoDireccion(){        
        
    }

        /*CREAMOS UN CONSTRUCTOR PARA CARGAR EL COMBO DEL TIPO DE DIRECCION DE LA ENTIDAD (FISICA, FACTURACION...) QUE RECOGEMOS DE LA TABLA TIPO DIRECCION Y
    LO GUARDAMOS DENTRO DE LA PRIMERA PESTAÑA DE ENTIDADESVIEW*/
    public TipoDireccion(String id_tipo_direccion, String tipo_direccion) {
        this.id_tipo_direccion = id_tipo_direccion;
        this.tipo_direccion = tipo_direccion;
    }

   //GETTERS Y SETTERS
    public String getId_tipo_direccion() {
        return id_tipo_direccion;
    }

    public void setId_tipo_direccion(String id_tipo_direccion) {
        this.id_tipo_direccion = id_tipo_direccion;
    }

    public String getTipo_direccion() {
        return tipo_direccion;
    }

    public void setTipo_direccion(String tipo_direccion) {
        this.tipo_direccion = tipo_direccion;
    }
  
  

}