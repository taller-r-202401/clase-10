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
       janitor # función tabyl: frecuencias relativas
       )


