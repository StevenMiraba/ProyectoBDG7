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
       
def mostrarTablas():
  print('metodo crear Tablas')

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
contenedorTablas.pack(fill=BOTH,expand=True)

base.mainloop()