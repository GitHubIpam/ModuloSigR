############################################
#### Modulo SIG - Reuniao 2 - Poligonos ####
############################################

###### Carregar pacotes necessários ######
#-----------------------------------------------------------------------------
library(sp) #trabalha com dados especiais
library(raster) #Criação, leitura, manipulação e confecção da dados em raster.
library(dismo) #Modelagem de distribuição
library(rJava) #Roda programas em JAVA
library(rgdal) #Projeções e transformações
library(rgeos) #Ferramentas para  C++ 
library(maptools) #Manipula e lê dados geograficos, em particular ESRI shapes.
#-----------------------------------------------------------------------------


### R para visualizacao de dados 

#leitura de poligono
filename <- system.file("external/lux.shp", package="raster")
filename
p <- shapefile(filename) #funcao que chama o poligono
plot(p)

#visualizacao da tabela de atributos
p@data

#criando poligonos
toy.coordinates <- rbind(c(1.5, 2), c(2.5, 2), c(0.5, 0.5), c(1, 0.25), 
                         c(1.5,0), c(2, 0), c(2.5, 0), c(3, 0.25), c(3.5, 0.5))
toy.coordinates
pointsnew <- SpatialPoints(toy.coordinates) #converte a tabela em pontos espaciais 
plot(pointsnew)
#argumentos como pch e cex sao muito uteis para mudar o tipo e tamanho do ponto 
plot(pointsnew,pch=19,cex=3)
#algumas vezes a margem deixa nossas figuras muito pequenas, nesse caso estenda a margem
par(mar=c(1,1,1,1)) #a seq e: baixo esquerda cima direita
plot(pointsnew,pch=19,cex=3)
#a margem ficara assim ate fechar o R ou limpar o conteudo todo, 
#o que pode ser feito com uma funcao mto simples
dev.off()

plot(pointsnew,pch=19,cex=3)
#viu, a margem voltou a ser 4,4,4,4 

# e muito importante trabalhar sempre com as mesmas projecoes

### Exercicio rapido ###
#descubra a projecao do poligono criado
#projete para wgs 84
#dica: voce sempre pode perguntar ao R
pointsnew
crs(pointsnew)<-"+proj=lcc +lat_1=48 +lat_2=33 +lon_0=-100 +ellps=WGS84"

#voce pode tambem atribuir dados ao seu poligono
#nesse caso vamos usar um mais interessante,o poligono p
plot(p) #caso voces tenham esquecido como ele e
par(mar=c(1,1,1,1))
#visualizando dados
p@data

#as vezes e bem chato o id nao estar em ordem, entao vamos colocar o ID_1 em ordem
p@data<-p@data[with(p@data, order(-p@data[,"ID_1"])), ] #decrescente
p@data<-p@data[with(p@data, order(p@data[,"ID_1"])), ] #crescente
p@data #muito facil

#agora fica facil atribuir novos dados, como por ex numero de cachorros por distrito em Luxembugo
num.catioros<-c(rep(90000,5),rep(75000,3),rep(82000,4))
p@data<-cbind(p@data,num.catioros)
p@data
p@data<-p@data[,-7]
#funciona muito parecido com o add field

# e podemos tambem plotar esses dados
plot(p$num.catioros) #em grafico
spplot(p[,6]) #somente o numero de catioros em mapa
spplot(p[,5]) #somente a area em mapa
spplot(p) #tudo! logicamente que aqui voce tera problemas com a legeda


#DESAFIO 1
#foi facil ordenar a tabela somente para a coluna ID_1
#agora faca o mesmo para p@data$ID_2 ou seja faca o mesmo para ID_2
#
#
#
#
#
#Nao tao facil assim



#Material de hoje esta disponivel em 
https://github.com/VivianRib
#e foi construido com base em
http://www.nickeubank.com/gis-in-r/

