import tkinter as tk    

from tkinter import *
from tkinter import ttk
from tkinter import messagebox

from Conexion import * 
from proyectoBD import *

def guardarRegistros():
   print('metodo Guardar')
   
def modificarRegistros():
  print('metodo Modificar')

def eliminarRegistros():
  print('metodo Eliminar')
    
def tablaCompleta(contenedor,campos,datos):
  tree = ttk.Treeview(contenedor,columns=campos,show="headings")
  tree.pack(side=tk.RIGHT,expand=True,padx=10)

  max_longs = {col: len(col) for col in campos}
  for fila in datos:
    tree.insert("", "end", values=fila)
    for i, valor in enumerate(fila):
      col = campos[i]
      max_longs[col] = max(max_longs[col], len(str(valor)))

  for col in campos:
    tree.heading(col, text=col)
    tree.column(col, width=max_longs[col]*9,anchor=tk.CENTER)
     
def tablaForm(contenedorPrincipal,table):
  try:
    for widget in contenedorPrincipal.winfo_children():
      widget.destroy()
    
    contenedorDatos = tk.LabelFrame(contenedorPrincipal,text='Datos de '+table)
    contenedorDatos.pack(side=tk.LEFT,padx=10,pady=10,fill=tk.X,expand=True)
    
    contenedorTabla = tk.LabelFrame(contenedorPrincipal,text='Tabla de '+table)
    contenedorTabla.pack(side=tk.LEFT,padx=10,pady=10,expand=True)
    
    listCampos = extraerCampos(table)
    listDatos=extraerColumn('*',table)
    tablaCompleta(contenedorTabla,listCampos,listDatos)
    entry_widgets = []
    for campo in listCampos:
      panel=tk.Frame(contenedorDatos)
      panel.pack(fill=tk.X,pady=2)
      
      labelCampo = tk.Label(panel,text=campo,width=13,font=("Times New Roman",11))
      labelCampo.pack(side=tk.LEFT)

      txBoxCampo = tk.Entry(panel)
      txBoxCampo.pack(side=tk.RIGHT,expand=True)
      entry_widgets.append(txBoxCampo)
      
    contenedorBotones = tk.Frame(contenedorDatos)
    contenedorBotones.pack(fill=tk.X,pady=5)
    
    btGuardar = tk.Button(contenedorBotones,text="Guardar",width=10,command=guardarRegistros)
    btGuardar.pack(side=tk.LEFT,padx=4)
    btModificar=tk.Button(contenedorBotones,text="Modificar",width=10,command=modificarRegistros)
    btModificar.pack(side=tk.LEFT,padx=4)
    btEliminar=tk.Button(contenedorBotones,text="Eliminar",width=10,command=eliminarRegistros)
    btEliminar.pack(side=tk.LEFT,padx=4)
    
  except Exception as error:
    print("Error al mostrar la interfaz, error: {}".format(error))
        
def mostrarTablas():
  tableSelected = comboOpciones.get()
  tablaForm(contenedorTablas,tableSelected)

base = tk.Tk()
base.title("LMRTOURS AGENCY")
base.geometry("1200x600")
titulo=tk.Label(base,text="LMRTOURS AGENCY",font=('Times New Roman',18))
titulo.pack(pady=(10,5))
    
opciones = ['Cliente','Pago','Reserva','Empleado','PaqueteTuristico','Proveedor','BoletoAereo']
    
marco = tk.Frame(base)
marco.pack(pady=5)
etiqueta = tk.Label(marco,text='Seleccione la tabla a consultar: ',font=('Times New Roman',13))
etiqueta.pack(side=tk.LEFT, padx=5,pady=5)
comboOpciones = ttk.Combobox(marco,values=opciones)
comboOpciones.pack(side=tk.LEFT, padx=5,pady=5) 

btConsultar = tk.Button(base,text='Consultar',command=mostrarTablas)
btConsultar.pack()
    
contenedorTablas = tk.Frame(base)
contenedorTablas.pack(fill=tk.BOTH,expand=True)

base.mainloop()