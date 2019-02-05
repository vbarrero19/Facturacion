package Modelo;

import java.io.Serializable;

public class TipoImpuesto {

    private String id_tipo_impuesto;
    private String impuesto;
    private String valor;
    private String pais;

    public TipoImpuesto() {
    }

    public TipoImpuesto(String id_tipo_impuesto, String impuesto, String valor, String pais) {
        this.id_tipo_impuesto = id_tipo_impuesto;
        this.impuesto = impuesto;
        this.valor = valor;
        this.pais = pais;
    }

    public String getId_tipo_impuesto() {
        return id_tipo_impuesto;
    }

    public void setId_tipo_impuesto(String id_tipo_impuesto) {
        this.id_tipo_impuesto = id_tipo_impuesto;
    }

    public String getImpuesto() {
        return impuesto;
    }

    public void setImpuesto(String impuesto) {
        this.impuesto = impuesto;
    }

    public String getValor() {
        return valor;
    }

    public void setValor(String valor) {
        this.valor = valor;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }
    
       
}
