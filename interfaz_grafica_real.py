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