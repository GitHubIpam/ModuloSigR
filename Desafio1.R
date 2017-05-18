#Desafio 1 SIG2
filename <- system.file("external/lux.shp", package="raster")
filename
p <- shapefile(filename)
plot(p)

#resolucao comum e errada
p@data<-p@data[with(p@data, order(p@data[,"ID_2"])), ]
p@data

str(p@data)
p@data$ID_2<-as.numeric(p@data$ID_2)
str(p@data)
p@data<-p@data[with(p@data, order(p@data[,"ID_2"])), ]
p@data

