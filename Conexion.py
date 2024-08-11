import mysql.connector

class CConexion:

 def ConexionBaseDeDatos():
    try:
        conexion = mysql.connector.connect(user='root',password='pamatalo03*',host='127.0.0.1',database='LMRTOURS',port='3306')
        print("Conexion Correcta")

        return conexion

        
    except mysql.connector.Error as error:
        print("Error al conectarse con la base de Datos {}".format(error))

        return conexion
 ConexionBaseDeDatos()
