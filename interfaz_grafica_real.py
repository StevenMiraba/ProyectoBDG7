import tkinter as tk    


#Importar los modulos de tkinter
from tkinter import *

from tkinter import ttk
from tkinter import messagebox

from Clientes import *
from Conexion import *

class FormularioClientes:
 global base
 base = None

 global texBoxId
 texBoxId = None

 global texBoxNombres
 texBoxNombres = None

 global texBoxApellidos
 texBoxApellidos = None

 global combo
 combo = None

 global groupbox
 groupbox = None

 global tree 
 tree = None

def Formulario():
  global base
  global texBoxId
  global texBoxNombre
  global texBoxCiudad
  global texBoxPais
  global texBoxTelefono
  global texBoxEmail
  global groupbox
  global tree

  try:
    base = Tk()
    base.geometry("1200x500")
    base.title("Formulario Python")

    groupbox = LabelFrame(base,text = "Datos del Proveedor",padx =5, pady=5)
    groupbox.grid(row=0,column =0,padx=10, pady=10)

    labelId = Label(groupbox,text = "Id",width=13,font =("Times New Roman",14)).grid(row=0,column=0)
    texBoxId = Entry(groupbox)
    texBoxId.grid(row=0,column=1)

    labelNombre = Label(groupbox,text = "Nombre",width=13,font =("Times New Roman",14)).grid(row=1,column=0)
    texBoxNombre = Entry(groupbox)
    texBoxNombre.grid(row=1,column=1)

    labelCiudad = Label(groupbox,text = "Ciudad",width=13,font =("Times New Roman",14)).grid(row=2,column=0)
    texBoxCiudad = Entry(groupbox)
    texBoxCiudad.grid(row=2,column=1)

    labelPais = Label(groupbox,text = "País",width=13,font =("Times New Roman",14)).grid(row=3,column=0)
    texBoxPais = Entry(groupbox)
    texBoxPais.grid(row=3,column=1)

    labelTelefono = Label(groupbox,text = "Telefono",width=13,font =("Times New Roman",14)).grid(row=4,column=0)
    texBoxTelefono = Entry(groupbox)
    texBoxTelefono.grid(row=4,column=1)

    labelEmail = Label(groupbox,text = "Email",width=13,font =("Times New Roman",14)).grid(row=5,column=0)
    texBoxEmail = Entry(groupbox)
    texBoxEmail.grid(row=5,column=1)



    Button(groupbox,text="Guardar",width=10,command=guardarRegistros).grid(row=7,column=0)
    Button(groupbox,text="Modificar",width=10,command=modificarRegistros).grid(row=7,column=1)
    Button(groupbox,text="Eliminar",width=10,command=eliminarRegistros).grid(row=7,column=2)

    groupbox = LabelFrame(base,text="Lista de los proveedores",padx=9,pady=9,)
    groupbox.grid(row=0,column=1,padx=9,pady=9)

    #Crear un treeview

    #Configurar las columnas

    tree = ttk.Treeview(groupbox,columns=("Id","Nombre","Ciudad","País","Telefono","Email"),show="headings",height=10)
    tree.column("# 1",ancho=CENTER,width=50)
    tree.heading("# 1",text="Id")
    tree.column("# 2",ancho=CENTER,width=100)
    tree.heading("# 2",text="Nombre")
    tree.column("# 3",ancho=CENTER, width=100)
    tree.heading("# 3",text="Ciudad")
    tree.column("# 4",ancho=CENTER, width=100)
    tree.heading("# 4",text="País")
    tree.column("# 5",ancho=CENTER,width=100)
    tree.heading("# 5",text="Telefono")
    tree.column("# 6",ancho=CENTER,width=200)
    tree.heading("# 6",text="Email")


    #Mostrar la tabla

    for row in CClientes.mostrarClientes():
      tree.insert("","end",values=row)
    
    #Ejecutar la funcion de hacer click y mostrar el resultados de los Entry

    tree.bind("<<TreeviewSelect>>",seleccionarRegistro)

    

    tree.pack()







    base.mainloop()

  except ValueError as error:
    print("Error al mostrar la interfaz, error: {}".format(error))
def guardarRegistros():
   global texBoxNombre, texBoxCiudad,texBoxPais,texBoxTelefono, texBoxEmail, groupbox

   try:
     if texBoxNombre is None or texBoxCiudad is None or texBoxPais is None or texBoxTelefono is None or texBoxEmail is None:
       print("Los widgets no estan inicializados")
       return
     nombre = texBoxNombre.get()
     ciudad = texBoxCiudad.get()
     pais = texBoxPais.get()
     telefono = texBoxTelefono.get()
     email = texBoxEmail.get()

     CClientes.ingresarClientes(nombre,ciudad,pais,telefono,email)
     messagebox.showinfo("Informacion ","Los datos fueron guardados")

     actualizarTreeView()


     texBoxNombre.delete(0,END)
     texBoxCiudad.delete(0,END)
     texBoxPais.delete(0,END)
     texBoxTelefono.delete(0,END)
     texBoxEmail.delete(0,END)

   except ValueError as error:
     print("Error al ingresar los datos {}".format(error))
     
def actualizarTreeView():
  global tree

  try:
    tree.delete(*tree.get_children())

    datos=CClientes.mostrarClientes()
    for row in CClientes.mostrarClientes():
      tree.insert("","end",values=row)
  except ValueError as error:
     print("Error al ingresar los datos {}".format(error))

def seleccionarRegistro(event):
  try:
    itemSeleccionado = tree.focus()

    if itemSeleccionado:
      values = tree.item(itemSeleccionado)[ 'values']

      texBoxId.delete(0,END)
      texBoxId.insert(0,values[0])
      texBoxNombre.delete(0,END)
      texBoxNombre.insert(0,values[1])
      texBoxCiudad.delete(0,END)
      texBoxCiudad.insert(0,values[2])
      texBoxPais.delete(0,END)
      texBoxPais.insert(0,values[3])
      texBoxTelefono.delete(0,END)
      texBoxTelefono.insert(0,values[4])
      texBoxEmail.delete(0,END)
      texBoxEmail.insert(0,values[5])

      
  except  ValueError as error:
    print("Error al seleccionar registro {}".format(error))

def modificarRegistros():
   global texBoxId,texBoxNombre, texBoxCiudad,texBoxPais,texBoxTelefono,texBoxEmail, groupbox

   try:
     if texBoxId is None or texBoxNombre is None or texBoxCiudad is None or texBoxPais is None or texBoxTelefono is None or texBoxEmail is None:
       print("Los widgets no estan inicializados")
       return
     idProveedor = texBoxId.get()
     nombre = texBoxNombre.get()
     ciudad = texBoxCiudad.get()
     pais = texBoxPais.get()
     telefono = texBoxTelefono.get()
     email = texBoxEmail.get()

     CClientes.modificarClientes(idProveedor,nombre,ciudad,pais,telefono,email)
     messagebox.showinfo("Informacion ","Los datos fueron actualizados")

     actualizarTreeView()


     texBoxId.delete(0,END)
     texBoxNombre.delete(0,END)
     texBoxCiudad.delete(0,END)
     texBoxPais.delete(0,END)
     texBoxTelefono.delete(0,END)
     texBoxEmail.delete(0,END)

   except ValueError as error:
     print("Error al modificar los datos {}".format(error))

def eliminarRegistros():
   global texBoxId,texBoxNombres,texBoxApellidos
   try:
     if texBoxId is None:
       print("Los widgets no estan inicializados")
       return
     idProveedor = texBoxId.get()

     CClientes.eliminarClientes(idProveedor)
     messagebox.showinfo("Informacion ","Los datos fueron eliminados")

     actualizarTreeView()


     texBoxId.delete(0,END)
     texBoxNombre.delete(0,END)
     texBoxCiudad.delete(0,END)
     texBoxPais.delete(0,END)
     texBoxTelefono.delete(0,END)
     texBoxEmail.delete(0,END)

   except ValueError as error:
     print("Error al modificar los datos {}".format(error))
     



    #

    
Formulario()
