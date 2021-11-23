
### En todo proyecto de analisis de datos, es recomendable seguir esquemas de trabajo ###

### Lo primero es cargar todas las librerías que se van a utilizar (o bien instalarlas en caso de ser necesario) ###

install.packages("pacman") # la librería pacman ("package manager") hace más eficiente la administración de las librerías

pacman::p_load(tidyverse,
               pryr) # p_load permite cargar una librería ya instalada, o bien instalarla si aún no lo está

### Es conveniente revisar si hay "objetos" cargados en el entorno de trabajo, y borrarlos al iniciar un nuevo proyecto. ####

ls() #revisamos

rm(list = ls()) # se borran todos los objetos creados de la memoria de trabajo

### Tipos de datos ####

# la función "class" nos devuelve el atributo "Tipo de dato"

class(1)

class(1L)

class("curso")

class(TRUE); class(FALSE)

class(Sys.time()) #"Portable Operating System Interface, calendar time"

#No son los únicos: luegos veremos otros tipos de objetos: factores, series de tiempo, etc etc

# Variables: los "recipientes" de valores ####

# Asignaciones: = vs <- ####

a<-1; a

a< -1

a=1; a

# Una cuestión de memoria ####

a= 1; object.size(a)

a= "1"; object.size(a)

a= TRUE; object.size(a)

a= as.factor("1"); object.size(a)

f=factor(levels = c("bajo","alto")); object.size(f)

f=factor(levels = c("bajo","alto"),ordered = TRUE); object.size(f)

f=c("bajo","alto"); object.size(f)

f=factor(levels = c("bajo","alto","alto"))

f=c("bajo","alto","alto"); structure(f); object.size(f)

f= as.factor(f); structure(f) ; object.size(f) #recursividad

#### PEEEERO !!!!!!!!!!!!! 

object.size(rep("1",500))
object.size(as.factor(rep("1",500)))
object.size(rep(1,500))
object.size(as.factor(rep(1,500)))

#podemos consultar el espacio de la memoria donde está alojada la variable "a"
address(a) 

#también podemos consultar cuántos veces se apunta a esa locación en el script
refs(a)

## Vectores ####

decimales=c(1,2,3.5,7.8,9); decimales; class(decimales)
enteros=c(1L, 2L, 3L, 7L, 9L); enteros; class(enteros)
# o bien
enteros=as.integer(decimales); enteros; class(enteros)
logicos=c(TRUE,FALSE,FALSE,TRUE); logicos; class(logicos)

# Coerción

caracteres=c(1,2,"a","b",3); caracteres; class(caracteres)
sort(caracteres)

numeros=c(1.5, 2.5, 3L, 5L, 7.5); sort(numeros);class(numeros)
numeros
t(numeros) #Transposición

# Matrices ####

serie=c(1:12); serie
matriz=matrix(serie,ncol = 3); matriz
matriz=matrix(serie,ncol = 3,byrow = TRUE); matriz
matriz.union.col=cbind(decimales,enteros); matriz.union.col
class(matriz.union.col)
matriz.union.fila=rbind(decimales,enteros); matriz.union.fila

#Atributo 'names'
  

dimnames(matriz.union.col)=list(as.character(c(1:5)),
                                c("decimales","enteros")
)
matriz.union.col

decimales
names(decimales)=as.character(c(1:5))
decimales


# Data frames ####

letras=letters[1:10]
numeros=c(1:10)

df=cbind(letras,numeros)
df
class(df)

df=data.frame(letras=letras,numeros=numeros)
df
class(df)

df=tibble(letras=letras,numeros=numeros)
df
class(df)

# Funciones exploratorias y de manipulación de datos básicas ####

numeros=runif(100,0,10)# creamos 100 números aleatorios entre 0 y 10
numeros[numeros>5] #filtramos los números mayores a 5
which(numeros>5) #órden dentro del vector de los mayores a 5
numeros<-round(numeros,2)
indices<-which(numeros>5)
numeros[indices] #otra altertativa
sort(numeros) #implica una modificación en el orden de los elementos del vector
order(numeros) #genera un vector de las "posiciones" relativas de cada elemento del vector en relación a un vector ordenado
summary(numeros)
quantile(numeros,c(0.2,0.25,0.5))
names(quantile(numeros,c(0.2,0.25,0.5)))
dist.emp=ecdf(numeros) #creamos el objeto "función de distribución acumulada empírica"
dist.emp(5) #probabilidad acumulada empírica hasta el valor 5
letras=c(rep("f",50),rep("m",50))
letras
letras=sample(letras,replace = TRUE)
letras
numeros[which(letras=="m")] #Notar el operador ==

tabla=data.frame(
  Sexo=letras,
  Edad=numeros
)
dim(tabla)
nrow(tabla)
View(tabla)
View(tabla[,2])
View(tabla[,"Edad"])
View(tabla[["Edad"]])
View(tabla[1:50,1])
length(tabla$Sexo)
class(tabla$Sexo)
levels(tabla$Sexo)
object_size(tabla$Sexo)
tabla$Sexo<-as.character(tabla$Sexo)
class(tabla$Sexo)
object_size(tabla$Sexo)

summary(tabla)
sum(tabla[,2])
tapply(tabla[,2],tabla[,1],summary)
tabla$Edad.categ=cut(tabla$Edad,6)
View(tabla)
table(tabla$Sexo,tabla$Edad.categ)

tabla[c(4,21,58,91),2]=NA # introducimos valores perdidos/omitidos
View(tabla)
length(tabla$Sexo[!is.na(tabla$Edad)])
summary(tabla$Edad)
mean(tabla$Edad)
mean(tabla$Edad,na.rm = TRUE)
sd(tabla$Edad,na.rm = TRUE)
cv=mean(tabla$Edad,na.rm = TRUE)/sd(tabla$Edad,na.rm = TRUE);cv
tabla$Edad.categ[is.na(tabla$Edad)]

tabla$Peso=apply(as.data.frame(tabla[,2]),1,function(x) x*rnorm(1,3.5,0.2))
apply(tabla[,c(2,4)],2,mean,na.rm=TRUE)
tapply(tabla[,c(2)],tabla$Sexo,mean,na.rm=TRUE)
colMeans(tabla[,c(2,4)],na.rm = TRUE)

### tidyverse ####???

