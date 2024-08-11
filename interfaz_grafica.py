from Conexion  import  *

class CClientes:
    def mostrarClientes():
        try:
            cone=CConexion.ConexionBaseDeDatos('root','admin','127.0.0.1','LMRTOURS','3306')
            cursor = cone.cursor()
            cursor.execute("SELECT * FROM proveedor;")
            miResultado = cursor.fetchall()
            cone.commit()
            cone.close()
            return miResultado

        except mysql.connector.Error as error:
            print("Error de ingreso de datos {}".format(error))


    def ingresarClientes(nombre,ciudad,pais,telefono,email):

        try:
            cone=CConexion.ConexionBaseDeDatos('root','admin','127.0.0.1','LMRTOURS','3306')
            cursor = cone.cursor()
            sql ="INSERT INTO proveedor(id_proveedor,nombre,ciudad,pais,telefono,email) VALUES (null,%s,%s,%s,%s,%s);"
            #
            #Como minima expresion es:(valor,), la coma hace que sea una tupla
            valores = (nombre,ciudad,pais,telefono,email)
            cursor.execute(sql,valores)
            cone.commit()
            print(cursor.rowcount,"Registro ingresado")
            cone.close()



        
        except mysql.connector.Error as error:
            print("Error de ingreso de datos {}".format(error))
    
    def modificarClientes(id_proveedor,nombre,ciudad,pais,telefono,email):

        try:
            cone=CConexion.ConexionBaseDeDatos('root','admin','127.0.0.1','LMRTOURS','3306')
            cursor = cone.cursor()
            sql ="UPDATE proveedor SET proveedor.nombre = %s, proveedor.ciudad= %s,proveedor.pais= %s, proveedor.telefono= %s,email= %s WHERE proveedor.id_proveedor = %s;"
            valores = (nombre,ciudad,pais,telefono,email,id_proveedor)
            cursor.execute(sql,valores)
            cone.commit()
            print(cursor.rowcount,"Registro Actualizado")
            cone.close()



        
        except mysql.connector.Error as error:
            print("Error de actualizacion de datos {}".format(error))
    def eliminarClientes(id_proveedor):

        try:
            cone=CConexion.ConexionBaseDeDatos('root','admin','127.0.0.1','LMRTOURS','3306')
            cursor = cone.cursor()
            sql ="DELETE FROM proveedor WHERE proveedor.id_proveedor =%s;"
            valores = (id_proveedor,)
            cursor.execute(sql,valores)
            cone.commit()
            print(cursor.rowcount,"Registro Eliminado")
            cone.close()



        
        except mysql.connector.Error as error:
            print("Error de actualizacion de datos {}".format(error))
            
