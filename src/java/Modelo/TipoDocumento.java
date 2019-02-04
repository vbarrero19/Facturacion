/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author vbarr
 */

import java.io.Serializable;

public class TipoDocumento {
    private String id_documento;
    private String documento;

    
   public TipoDocumento(){        
        
    }

    //CREAMOS UN CONSTRUCTOR PARA CARGAR EL COMBO DEL TIPO DE DEDICACION DE LA ENTIDAD

    public TipoDocumento(String id_documento, String documento) {
        this.id_documento = id_documento;
        this.documento = documento;
    }


    public String getId_documento() {
        return id_documento;
    }

    public void setId_documento(String id_documento) {
        this.id_documento = id_documento;
    }

    public String getDocumento() {
        return documento;
    }

    public void setDocumento(String documento) {
        this.documento = documento;
    }
        

  

}