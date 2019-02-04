package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class TipoDocumento {
    private String id__tipo_documento;
    private String documento;

    
   public TipoDocumento(){        
        
    }

    //CREAMOS UN CONSTRUCTOR PARA CARGAR EL COMBO DEL TIPO DE DEDICACION DE LA ENTIDAD

    public TipoDocumento(String id_documento, String documento) {
        this.id__tipo_documento = id_documento;
        this.documento = documento;
    }


    public String getId_documento() {
        return id__tipo_documento;
    }

    public void setId_documento(String id_documento) {
        this.id__tipo_documento = id_documento;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }
        

  

}