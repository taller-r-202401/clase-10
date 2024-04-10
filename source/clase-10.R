#===========================================#
# author: Eduard Fernando Martínez González
# update: 09-04-2024
# R version 4.3.3 (2024-02-29)
#===========================================#

## initial configuration
rm(list=ls()) # limpiar entorno

## load packages
require(pacman)

## usar la función p_load de pacman para instalar/llamar las librerías de la clase
p_load(tidyverse, # funciones para manipular/limpiar conjuntos de datos.
       rio, # función import/export: permite leer/escribir archivos desde diferentes formatos. 
       skimr, # función skim: describe un conjunto de datos
       janitor, # función tabyl: frecuencias relativas
       data.table)

##==== Loops: for ====##

## loop base
print("Hola")
paste("Hola","mundo")
for (iterar in 1:10) {
     print(paste("Hola mundo",iterar))
}

## iterar sobre columnas
ncol(mtcars)
for (i in 1:ncol(mtcars)){
     print(mean(mtcars[,i]))
}

## iterar sobre columnas
db <- as.data.table(mtcars)
for (i in 1:ncol(db)){
     db[[i]] <- db[[i]]/1000
}

##==== Condicionales: if, else ====##
letras <- letters
vocales <- c("a","e","i","o","u")
for (j in letras) {
     if (j %in% vocales) {
     print(paste(j,"es una vocal"))
     }
     else { 
     print(paste(j,"NO es una vocal")) 
     }
}

##==== Funciones ====##

## funciones
sqrt_new <- function(numero){
                    if (is.na(as.numeric(numero))) { 
                    resultado <- paste(numero,"NO es un numero")
                    return(resultado)
                    }
                    else {
                    resultado <- sqrt(as.numeric(numero))  
                    return(resultado)
                    }
            }

sqrt_new("100")
sqrt_new("100A")

## loop sobre la funcion
n <- c("100","200","Hola")
for (i in n) {print(sqrt_new(i))}

##==== Lapply, Sapply, Apply ====##

## lapply: aplicar promedios a columnas
lapply(mtcars,mean)
lapply(n, sqrt_new)

## lapply: aplicar procesamiento a columnas
db <- lapply(mtcars, function(y) y=y/1000) %>% as.data.frame()
db <- lapply(mtcars, function(y) y=ifelse(y>5,1,0)) %>% as.data.frame()


##==== Function ====##
hola <- import("input/chip/2019/11767600044K212410-1220191625694914330.xls")
hola[8,8]
names(hola)[1]

## fucnion
chip <- function(file){
        db <- import(file)  
        output <- data.frame("name_muni"=names(db)[1] , "valor"=db[8,8])
}

## archivos
rutas <- list.files("input/chip/",recursive = T , full.names = T)
  
## datos
datos_chip <- lapply(rutas , chip) %>% rbindlist(use.names = T , fill = T)
datos_chip <- lapply(rutas , function(x) chip(file = x)) %>% rbindlist(use.names = T , fill = T)



