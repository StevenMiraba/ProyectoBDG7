from Conexion import *
from mysql.connector import Error

connection = CConexion.ConexionBaseDeDatos('root','admin','127.0.0.1','LMRTOURS','3306')

# Función para ejecutar una consulta de selección
def ejecutarConsulta(connection, consulta):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(consulta)
        result = cursor.fetchall()
        return result
    except Error as e:
        print(f"El error '{e}' ocurrió")
        return None

def iniciarSesion(user):
    nombres=extraerColumn('nombre','empleado')
    apellidos=extraerColumn('apellido','empleado')
    usuarios = extraerColumn('usuario','empleado')
    claves = extraerColumn('clave','empleado')
    for i in range(len(usuarios)):
        if(user in usuarios[i]):
            password=input('Ingrese su contraseña: ')
            while(not(password in claves[i])):
                print('contraseña incorrecta')
                password=input('Ingrese correctamente su contraseña: ')
            return True,nombres[i][0],apellidos[i][0]
    print('usuario no existente')
    return False,None,None

def extraerColumn(value,table):
    consulta = "SELECT "+value+" FROM "+table
    column = ejecutarConsulta(connection,consulta)
    return column

def imprimirMenuPrincipal():
  menu="<-------------LMR TOURS------------>\n Menu de Opciones:\n  1.- Realizar Reserva\n  2.- Realizar Consulta \n  3.- Comprar Boleto Aereo\n  4.- Crear Paquete Turistico \n  5.- Salir de su cuenta"
  print(menu) 
  switcher = {1: realizarReserva,2: imprimirMenuConsultas,3: comprarBoleto,4: crearPack,5:'Se cerro sesión correctamente'}
  opcion=int(input('Ingrese la opción que desea realizar: '))
  opcionEjec=switcher.get(opcion,lambda: print("Opción no válida"))
  opcionEjec()

def imprimirMenuConsultas():
    menu="Menu de Opciones:\n  1.- Consultar Reserva\n  2.- Consultar Paquete Turistico \n  3.- Cosultar Boleto Aereo\n  4.- Consultar Servicio\n  5.- Consultar Proveedor \n  6.- Salir del menú"
    print(menu)

def realizarReserva():
    print('<-------------CREAR RESERVA------------>')
    cedula=input('Ingrese número de cedula: ')
    if(consultarCliente(cedula)):
        print('clienteExistente')
        destino = input('A que destino desea ir: ')
        msg,disp=consultarDestino(destino)
        print(msg)
        if(disp):
            #llamar metodo pide datos
            print('metodo pide datos')
        else:
            #menu salir o crear paquete
            print('salir')

    else: 
        print('cliente Nuevo')
        #crearNuevoCLiente()
    return None

def obtenerValorPaquete(idP):
    ids=extraerColumn('id_paqueteturistico','(tiene natural join paqueteturistico) natural join destino')
    precios=extraerColumn('precio','(tiene natural join paqueteturistico) natural join destino')
    for i in range(len(ids)):
        if(idP==ids[i]):
            return precios[i]

def datosReserva():
    precioU=obtenerValorPaquete()
    numPersonas=int(input('Ingrese el numero de personas que van a viajar: '))
    montoTotal=precioU*numPersonas

def consultarDestino(destino):
    paises=extraerColumn('pais','destino')
    for i in range(len(paises)):
        if(destino in paises[i]):
            if(consultarVisa(destino,paises)):
                preg=input('tiene visa para el destino requerido?: ')
                if(preg=='si'):
                    return 'destino disponible, necesita visa',True
                else:
                    return 'no puede agendar la reserva',False
            else:
                return 'destino disponible, no necesita visa',True
        else:
            return 'destino no disponible, cree un paquete',False
    
def consultarVisa(pais,paises):
    visaSioNo=extraerColumn('necesitaVisaSioNo','destino')
    for i in range(len(paises)):
        if(pais==paises[i]):
            if(visaSioNo[i]==1):
                return True
        else:
            return False;

def consultarCliente(cedula):
    cedulas=extraerColumn('cedulaCliente','cliente')
    for c in cedulas:
        if(cedula in c):
            return True
    return False

def comprarBoleto():
    return None

def crearPack():
    return None

user=input('ingrese su usuario: ')
cons,nombre,apellido=iniciarSesion(user)
if(cons):
    print('Bienvenid@: '+nombre+' '+apellido)
    imprimirMenuPrincipal()