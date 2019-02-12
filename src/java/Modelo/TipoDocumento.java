package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class TipoDocumento {
    private String id_tipo_documento;
    private String documento;

    //CONSTRUCTOR VACIO
   public TipoDocumento(){        
        
    }

    /*CREAMOS UN CONSTRUCTOR PARA CARGAR EL COMBO DEL TIPO DE DOCUMENTO DE LA ENTIDAD (DNI, CIF, NIF...) QUE RECOGEMOS DE LA TABLA TIPO DOCUMENTO Y
    LO GUARDAMOS DENTRO DE LA PRIMERA PESTAÑA DE ENTIDADESVIEW*/

    public TipoDocumento(String id_documento, String documento) {
        this.id_tipo_documento = id_documento;
        this.documento = documento;
    }

//GETTERS Y SETTERS
    public String getId_documento() {
        return id_tipo_documento;
    }

    public void setId_documento(String id_documento) {
        this.id_tipo_documento = id_documento;
    }
    
    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }
        

  

}