/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author David
 */
import com.mchange.v2.c3p0.ComboPooledDataSource;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Connection;

public class PoolC3P0_Local1Original {
    // Notara que el pool es un miembro *estatico* esto es para evitar duplicidad

    private static PoolC3P0_Local1Original datasource;
    // Esta es la fuente de datos que conecta con la base de datos
    private final ComboPooledDataSource cpds;

    /**
     * Crea el constructor del pool, notara que este constructor es privado esto
     * con el fin de que podamos controlar cuando se crea el pool
     *
     * @throws IOException
     * @throws SQLException
     * @throws PropertyVetoException
     */
    /*
             configDBCP(ds_eduweb,"jdbc:postgresql://192.168.1.3:5432/Lessons",
                     "eduweb","Madrid2016",
                    "org.postgresql.Driver");
     */
    private PoolC3P0_Local1Original() throws IOException, SQLException, PropertyVetoException {
        // Configuramos la conexion a base de datos
        // Creamos la fuente de datos
        cpds = new ComboPooledDataSource();
        // Que driver de base de datos usaremos
        //cpds.setDriverClass("org.postgresql.Driver");
        // La url de la base de datos a la que nos conectaremos
        //cpds.setJdbcUrl("jdbc:postgresql://192.168.1.9:5432/Lessons");
        // Usuario de esa base de datos
        //cpds.setUser("eduweb");
        // Contraseña de la base de datos
       //cpds.setPassword("Madrid2016");

        cpds.setDriverClass("");
           // La url de la base de datos a la que nos conectaremos
        cpds.setJdbcUrl("");
           // Usuario de esa base de datos
        cpds.setUser("");
           // Contraseña de la base de datos
        cpds.setPassword("");

        
        /* 
          p:acquireIncrement="1" 
          p:checkoutTimeout="3000"
          p:idleConnectionTestPeriod="5"           
          p:maxIdleTime="3" 
          p:maxIdleTimeExcessConnections="1" 
          p:maxPoolSize="20" p:maxStatements="20000" p:maxStatementsPerConnection="1000" 
          p:minPoolSize="1" 
          p:numHelperThreads="1000"
          p:overrideDefaultUser="${jdbc.username}" p:overrideDefaultPassword="${jdbc.password}"
          p:propertyCycle="3" 
          p:statementCacheNumDeferredCloseThreads="1"
          p:testConnectionOnCheckin="true"
          p:unreturnedConnectionTimeout="7" 
         
        
        */
        cpds.setAcquireIncrement(1);
        cpds.setCheckoutTimeout(3000);
         cpds.setIdleConnectionTestPeriod(5);
          cpds.setMaxIdleTime(3);
          cpds.setMaxIdleTimeExcessConnections(1);
          cpds.setMaxPoolSize(20);  cpds.setMaxStatements(20000);  cpds.setMaxStatementsPerConnection(1000);
        cpds.setMinPoolSize(1);
        cpds.setNumHelperThreads(1000);
          cpds.setPropertyCycle(3);
          cpds.setStatementCacheNumDeferredCloseThreads(1);
          cpds.setTestConnectionOnCheckin(true);
          cpds.setUnreturnedConnectionTimeout(7);
          /*
        // Configuramos el pool
        // Numero de conexiones con las que iniciara el pool
        cpds.setInitialPoolSize(1);
        // Minimo de conexiones que tendra el pool
        cpds.setMinPoolSize(1);
        // Numero de conexiones a crear cada incremento
        cpds.setAcquireIncrement(1);
        // Maximo numero de conexiones
        cpds.setMaxPoolSize(300);
        // Maximo de consultas
        cpds.setMaxStatements(0);
        // Maximo numero de reintentos para conectar a base de datos
        // cpds.setAcquireRetryAttempts(2);
        // Que se genere una excepcion si no se puede conectar
        cpds.setBreakAfterAcquireFailure(true);
        
        cpds.setIdleConnectionTestPeriod(300);
        cpds.setMaxIdleTimeExcessConnections(240);*/
    }

    /**
     * Nos regresa la instancia actual del pool, en caso que no halla una
     * instancia crea una nueva y la regresa
     *
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws PropertyVetoException
     */
    public static synchronized PoolC3P0_Local1Original getInstance() throws IOException, SQLException, PropertyVetoException {

        if (datasource == null) {
            datasource = new PoolC3P0_Local1Original();
            return datasource;
        } else {
            return datasource;
        }
    }

    /**
     * Este metodo nos regresa una conexion a base de datos, esta la podemos
     * usar como una conexion usual
     *
     * @return Conexion a base de datos
     * @throws SQLException
     */
    public Connection getConnection() throws SQLException {
        return this.cpds.getConnection();
    }

}
