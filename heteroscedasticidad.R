rm(list=ls())

# Heteroscedasticidad (Checar parte te�rica)
# Generaci�n de la base de datos heterosced�stica
set.seed(1234)
x1 <- rep(1:250,2)

# Ojo, los errores estan en funci�n de la variable x1, crecen
# de manera exponencial
sigma2 <- x1^2.5
epsilon <- rnorm(x1, 0, sqrt(sigma2))

# Generamos los datos
y = 5 + 13*x1 + epsilon

# El investigador realiza la regresi�n, y capturamos los errores
reg1 <- lm(y~x1)
summary(reg1)
e <- residuals(reg1)

# Grafica 1, (y vs x1)
# Grafica 2, Q-Q plot de los residuales
# Grafica 3, Residuales vs y estimada
# Grafica 4, versi�n estandarizada de 3
windows()
layout(matrix(1:4, nrow=2))
plot(x1,y)
abline(coef(reg1), col="red")
plot(reg1, which=1)

plot(reg1, which=2)
plot(reg1, which=3)

# como identificar heteroscedasticidad
# Breusch-Pagan test
# Hip�tesis nula: Homosced�stica

library(lmtest)
bptest(reg1)

# Rechazado, es heterosced�stica

# Como corregir?
library(sandwich)
coeftest(reg1, vcov = vcovHC(reg1, type = "HC0"))


