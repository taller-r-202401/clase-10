#===========================================#
# author: Eduard Fernando Martínez González
# update: 09-04-2024
# R version 4.3.3 (2024-02-29)
#===========================================#

## **[0.] Configuración inicial**

#### **☑ entorno**
rm(list=ls()) # limpiar entorno
set.seed(12345) # fijar semilla

#### **☑ Librerias:**

## llamar&instalr librerias de la clase
require(pacman)
p_load(tidyverse , rio , data.table)

## **[1.] Funciones**
browseURL("https://fhernanb.github.io/Manual-de-R/creafun.html")
browseURL("https://es.r4ds.hadley.nz/funciones.html") 
browseURL("https://www.r-bloggers.com/2016/02/functions-exercises/")
browseURL("https://adv-r.hadley.nz/conditions.html")

### **1.1 Estructura de una función**

## message, warnings & errors indican diferentes niveles de mensajes:
  
## **message:** informa resultados... etc. 
## **warnings:** informa algun tipo de error o anuncio importante que no impide el funcionamiento del programa.
## **error:** indicador sobre el fua = ncionamiento correcto de la funcion.

## Ejemplo
unir <- function(x, y){
        palabra = paste0(x," - ",y) %>% toupper()
        message(paste("message: las combinacion de las palabras producen:", palabra))
}
unir(x = "hola", y = "clase")

## Veamos otro ejemplo (...)
remove_na <- function(x) x = ifelse(is.na(x)==T,0,x)

vector <- c(1:5,rep(NA,5),11:15)

vector_2 = ifelse(is.na(vector)==T,0,vector)
  
vector_3 <- remove_na(x = vector)

## Veamos otro ejemplo (...)
storms %>% head()

df <- storms %>% select(name,year,tropicalstorm_force_diameter) 

## 6509 NA
summary(df$tropicalstorm_force_diameter)

## replace NA por 0
df <- df %>% 
      mutate(new_var = remove_na(tropicalstorm_force_diameter))

summary(df$new_var)

## Veamos otro ejemplo: funcion que regresa el producto de un numero por si mismo
num_2 <- function(x){
         c = x*x
         return(c)
}
num_2(x = 4)
num_2(x = "A")

## incluir controles de flujo
num_2 <- function(numero){
        
         # si es un numero
         if (is.numeric(numero)){
             c = numero*numero
         return(c)
         }
        
         # si no es un numero
         if (is.numeric(numero)==F){
         warning(paste0(numero," no es un número"))
         }
}
num_2(numero = 10)
num_2(numero = "hola")
num_2(numero = "10")

## **[2.] Apply, Lapply & Sappl**

### **2.1 Apply**

####  Operaciones por columnas
mtcars
apply(X = mtcars, MARGIN = 2, FUN = min)
apply(mtcars , 2 , function(columna) min(...=columna , na.rm=T)) 

####  Operaciones por filas
apply(X = mtcars, MARGIN = 1, function(x) sum(x))

### **2.2 Lapply**

## aplicar sobre dataframe
lapply(mtcars, function(x) summary(x))
lap <- lapply(mtcars, function(x) summary(x))
lap

storms
table(is.na(storms$hu_diameter))
table(is.na(storms$ts_diameter))
lapply(storms ,function(x)  table(is.na(x)))

### **2.3 Sapply**
sap <- sapply(mtcars, summary)
sap

## **[3.] Aplicación: chip**

## limpiar entorno
rm(list=ls()) 

## Chip
browseURL("https://www.chip.gov.co/schip_rt/index.jsf")

ejemplo <- import("input/chip/2019/11767600044K212410-1220191625694914330.xls", skip = 7) %>% as_tibble()
ejemplo

## 1. Obtener rutas de los datos
list.files("input/chip",full.names=T, recursive = T) 

paths <- list.files("input/chip",full.names=T, recursive = TRUE) %>% unlist()

## 2. Hacer ejemplo para una observacion

## 2.1. leer archivo
data = import("input/chip/2019/11767600044K212410-1220191625694914330.xls")

## 2.2. obtener codigo-DANE 
name_mpio = colnames(data)[1]

## 2.3. obtener tipo de inversion
tipo = data[8,2]

## 2.4. obtener valor
valor = data[8,8]

## 2.5. consolidar informacion
df = tibble(name=name_mpio , tipo_inver = tipo , valor_inv = valor)

#----------------------#
## 3. Generalizar ejemplo en una función
f_extrac <- function(ruta){
  
  ## 2.1. leer archivo
  data = import(ruta)
  
  ## 2.2. obtener codigo-DANE 
  name_mpio = colnames(data)[1]
  
  ## 2.3. obtener tipo de inversion
  tipo = data[8,2]
  
  ## 2.4. obtener valor
  valor = data[8,8]
  
  ## 2.5. consolidar informacion
  df = tibble(name=name_mpio , tipo_inver = tipo , valor_inv = valor)
            
  ## 3.6 Retornar output
  return(df)
}


lista = list.files("input/chip",recursive = T , full.names = T)



data_20 = f_extrac(lista[20])
data_30 = f_extrac(lista[30])


data_lapply = lapply(lista, function(x) f_extrac(ruta = x))

data_df = rbindlist(l = data_lapply , use.names = T)





