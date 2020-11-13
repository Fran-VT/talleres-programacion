library(stats)
library(ade4)
library(ape)
library(adegenet)
library(phangorn)

secuencia <- read.dna(file="https://adegenet.r-forge.r-project.org/files/usflu.fasta", format="fasta")
secuencia
class(secuencia)
## se pueden generar archivos con anotaciones pero no se si vienen al caso.
D <- dist.dna(secuencia, model = "TN93") ## modelo Tamura&Nei, permite distintas frecuenias de transiciones y transversiones y tasas de sustitucion
## lo anterior devuelve un objeto de clase "Dist" el cual contiene la distancia para cada par de secuencias que contiene nuestro archivo FASTA inicial.
temp <- as.data.frame(as.matrix(D)) #visualizacion de las distancias, recordar que para n secuencias hay n(n-1)/2 distancias o comparaciones
table.paint(temp, cleg = 0, clabel.row = 0.5, clabel.col = 0.5) #mas negro mas distancia
#para producir figuras, debemos transformar el objeto temp.
temp <- t(as.matrix(D))
temp <- temp[, ncol(temp):1]
par(mar = c(1, 5, 5, 1))
image(x = 1:80, y = 1:80, temp, col = rev(heat.colors(100)),
      + xaxt = "n", yaxt = "n", xlab = "", ylab = "")
axis(side = 2, at = 1:80, lab = rownames(secuencia), las = 2, cex.axis = 0.5)
axis(side = 3, at = 1:80, lab = rownames(secuencia), las = 3, cex.axis = 0.5)
