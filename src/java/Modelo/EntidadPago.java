package Modelo;

/**
 *
 * @author vbarr
 */
public class EntidadPago {
    private String id_entidad;
    private String distinct_code;
    private String nombre_entidad;
    
    private String id_metodo_pago;
    private String numero_cuenta;
    private String titular_cuenta;
    private String nombre_banco;
    private String direccion_banco;
    private String localidad;
    private String pais;
    private String codigo1;
    private String codigo2;
    private String tarjeta_credito;
    private String titular_tarjeta;
    private String mes_caducidad;
    private String anio_caducidad;
    private String codigo_csc;
    private String cuenta_paypal;
    private String correo_paypal;
    private String cheque;
            

    public EntidadPago() {
    }

    
        /* PARA MOSTRAR LOS DATOS EN LA LISTA, A LA HORA DE MODIFICAR UN METODO DE PAGO */
    
    public EntidadPago(String id_entidad, String nombre_entidad, String id_metodo_pago, String titular_cuenta, String nombre_banco) {
        this.id_entidad = id_entidad;
        this.nombre_entidad = nombre_entidad;
        this.id_metodo_pago = id_metodo_pago;
        this.titular_cuenta = titular_cuenta;
        this.nombre_banco = nombre_banco;
    }

/*MOSTRAR LOS DATOS QUE SE COMPLETAN AL METERTE EN UNA ENTIDAD */
    
//    public EntidadPago(String distinct_code, String nombre_entidad, String numero_cuenta, String titular_cuenta, String nombre_banco, String direccion_banco, String tarjeta_credito, String localidad) {
//        this.distinct_code = distinct_code;
//        this.nombre_entidad = nombre_entidad;
//        this.numero_cuenta = numero_cuenta;
//        this.titular_cuenta = titular_cuenta;
//        this.nombre_banco = nombre_banco;
//        this.direccion_banco = direccion_banco;
//        this.tarjeta_credito = tarjeta_credito;
//        this.localidad = localidad;
//    }
    

    
    
     public EntidadPago(String distinct_code, String nombre_entidad, String numero_cuenta, String titular_cuenta, String nombre_banco, String direccion_banco, String localidad, String pais,
             String codigo1, String codigo2, String tarjeta_credito, String titular_tarjeta, String mes_caducidad, String anio_caducidad, String codigo_csc, String cuenta_paypal, String correo_paypal,
             String cheque) {
       this.distinct_code = distinct_code;
       this.nombre_entidad = nombre_entidad;
       this.numero_cuenta = numero_cuenta;
       this.titular_cuenta = titular_cuenta;
       this.nombre_banco = nombre_banco;
       this.direccion_banco = direccion_banco;
       this.localidad = localidad;
       this.pais = pais;
       this.codigo1 = codigo1;
       this.codigo2 = codigo2;
       this.tarjeta_credito = tarjeta_credito;
       this.titular_tarjeta = titular_tarjeta;
       this.mes_caducidad = mes_caducidad;
       this.anio_caducidad = anio_caducidad;
       this.codigo_csc = codigo_csc;
       this.cuenta_paypal = cuenta_paypal;
       this.correo_paypal = correo_paypal;
       this.cheque = cheque;
       
    }

  

    
   

    
    
    
    public String getId_entidad() {
        return id_entidad;
    }

    public void setId_entidad(String id_entidad) {
        this.id_entidad = id_entidad;
    }

    public String getDistinct_code() {
        return distinct_code;
    }

    public void setDistinct_code(String distinct_code) {
        this.distinct_code = distinct_code;
    }
    
        

    public String getNombre_entidad() {
        return nombre_entidad;
    }

    public void setNombre_entidad(String nombre_entidad) {
        this.nombre_entidad = nombre_entidad;
    }

    public String getId_metodo_pago() {
        return id_metodo_pago;
    }

    public void setId_metodo_pago(String id_metodo_pago) {
        this.id_metodo_pago = id_metodo_pago;
    }

    public String getTitular_cuenta() {
        return titular_cuenta;
    }

    public void setTitular_cuenta(String titular_cuenta) {
        this.titular_cuenta = titular_cuenta;
    }

    public String getNombre_banco() {
        return nombre_banco;
    }

    public void setNombre_banco(String nombre_banco) {
        this.nombre_banco = nombre_banco;
    }
    
    
    
}
