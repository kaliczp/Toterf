library(rgrass7)

## Raszter beolvasás
## IDW beolvasás
PisztrSurf <- readRAST("surfvec1m2")
PisztrSurf <- readRAST("rstsurf")
PisztrSurf <- readRAST("rstsurfnew")

## Mátrixra konvertált
PisztrSurf.mat <- as.matrix(PisztrSurf)
min(PisztrSurf.mat)
max(PisztrSurf.mat)

vol.df <- VolCal(PisztrSurf.mat, levels=seq(339, 344.5, by = 0.1), surface = TRUE)
vol.df[,2] <- round(vol.df[,2])
vol.df[1, "surface"] <- 0 
write.table(vol.df, "PisztrangosTerf.csv", sep=";", dec = ",", row.names=FALSE)
## Ha kell beolvasás
## vol.df <- read.csv2("PisztrangosTerf.csv")

## IDW
# idwvol.df <- vol.df

##
png("PisztrVol.png", width=4*480, height=2*480, res=2*72)

## Plot
korona <- 344.5
arapaszto <- 341.3
plot(level ~ volume, vol.df, typ="n",
     xlim = c(0,41000),
     xlab = expression("Tározótérfogat [ "* m^3 * " ]"),
     ylab = "Vízállás [m B. f.]")
grid()
## Gátkorona
axis(2, at = 344.5, lab = FALSE, tck = 1, lty = "dashed")
text(0, korona, paste("Gát koronaszint (", korona, " m)"), adj=c(0,1.2))
## Árapasztó
axis(2, at = arapaszto, lab = FALSE, tck = 1, lty = "dashed")
text(15000, arapaszto, paste("Árapasztó (", arapaszto, " m)"), adj=c(0,1.2))
## A görbe 1 m biztonság alatt
lines(level ~ volume, vol.df[vol.df$level <= 343.5,], lwd = 2)
## A görbe 1 m biztonság felett
lines(level ~ volume, vol.df[vol.df$level >= 343.5,], lwd = 2, lty = "dotted")
## Felület
par(new = TRUE)
plot(level ~ surface, vol.df, type="n", axes = FALSE, xlab="", ylab="",
     xlim = c(0, 20500)
     )
lines(level ~ surface, vol.df, lwd =2, lty = "dashed")
axis(3)
mtext( expression("Vízfelület [ "* m^2 * " ]"), line = 2.5)
legend("bottomright",c("Tározótérfogat", "Vízfelület"), lwd=2, lty=c("solid", "dashed"), bg = "white")
par(new = FALSE)

dev.off()

## IDW line compare
lines(level ~ volume, idwvol.df, col=2)

## Data export
vol.df[,2] <- round(vol.df[,2])
write.table(vol.df, "PisztrangosTerf.csv", sep=";", dec = ",", row.names=FALSE)

## ggplot2 kezdemény
library(ggplot2)
ggplot(vol.df, aes(volume, level)) + geom_line() + geom_point() + theme_bw()

ggplot(vol.df, aes(y = level)) +
    geom_line(aes(x = volume)) +
    geom_line(aes(x = surface), col="red") +
#    theme_bw() +
    ylab("Vízállás [m]")

## Függvény
vol.para <- lm(volume ~ I(level^2) + level, vol.df)
points(predict(vol.para), vol.df$level, col=2)
vol.poly <- lm(volume ~ poly(level,4), vol.df)
points(predict(vol.poly), vol.df$level, col=4)

## Térfogat Vízszint és a gát teteje alatt 1m
## Gátkorona -- víz 3.2 m
mean(c(tan(35*pi/180)*4.9,
tan(31.4*pi/180)*5.04,
tan(34.8*pi/180)*4.5))

## Térfogat
vol.df[vol.df$level == 343.5, "volume"] - vol.df[vol.df$level == 341.3, "volume"]
