import mysql.connector

class CConexion:
    def ConexionBaseDeDatos(usuario,contrasena,anf,base,puerto):
        try:
            conexion = mysql.connector.connect(user=usuario,password=contrasena,host=anf,database=base,port=puerto)
            print("Conexion Correcta")
            return conexion
        except mysql.connector.Error as error:
            print("Error al conectarse con la base de Datos {}".format(error))
            return conexion
