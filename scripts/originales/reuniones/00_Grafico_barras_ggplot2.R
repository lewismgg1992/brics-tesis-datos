#Gráfico de barras
library(ggplot2)

#Cargo la base de datos, para eso debo importar el Dataset que vaya a utilizar

#Genero el gráfico de barras: en este comando selecciono la base de datos por medio de "data", solicito graficar la variable "area" por medio del comando "mapping", solicito que sea un gráfico de barras por medio del comando "geom_bar" y le digo que lo gire por medio del comando "coord_flip"00
ggplot(data = Experimento_reuniones_R, mapping = aes(x = area)) + geom_bar()+coord_flip()

#Para cambiar el color de las barras debo escribir 
#dentro de "geombar()" lo siguiente: geombar(fill="Red")

#Se puede fijar el gráfico anteponiendo una letra al comando completo, 
#de esta manera se puede llamar al gráfico directamente 
#sin tener que reproducirlo completamente: 
a <- ggplot(data = Experimento_reuniones_R, mapping = aes(x = area)) + geom_bar()+coord_flip()

#Cambiar fondo
#a + theme

#Presentar gráficos de barras segmentado por medio de otra variable
ggplot(Experimento_reuniones_R, aes(x=tipo))+geom_bar()+facet_wrap(~area, nrow = 1)
ggplot(datos, aes(x = year, fill = tipo)) + geom_bar()+facet_wrap(~nivel, nrow = 4)+labs(fill = "type", y = "number of meetings")

#Dividir la base de datos por medio de la funcion split
nivelreuniones <- split(Reuniones_Completas_R, Reuniones_Completas_R$nivel)

#El comando anterior nos va a devolver una lista de una cantidad equivalente 
#a la cantidad de valores que comprendan a la variable. 

#Se pueden observar una lista en especifico por medio del siguiente comando
nivelreuniones[2]

#Lo anterior arroja una lista, siendo que el siguiente comando arroja un data frame
nivelreuniones[[2]]

#Crear subconjuntos desde un data frame. Identifico la base y luego indico los criterios.
subset(Reuniones_Completas_R, nivel <= 4)
#o
subset(Reuniones_Completas_R, nivel <=4, select = c(margenOrg, area, subarea, tipo))

#Solicito una tabla de frecuencias absolutas
summary(Reuniones_Completas_R)

#Solicito una tabla de frecuencias
sapply(Reuniones_Completas_R, FUN=table)

#Tabla de frecuencia para variables categoricas
table(Reuniones_Completas_R)

#Tabla de frecuencias pero en formato plano
ftable(Reuniones_Completas_R)

