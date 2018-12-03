library(rgrass7)

## Raszter beolvasás
PisztrSurf <- readRAST("surfvec1m2")

## Mátrixra konvertált
PisztrSurf.mat <- as.matrix(PisztrSurf)
min(PisztrSurf.mat)
max(PisztrSurf.mat)

vol.df <- VolCal(PisztrSurf.mat, levels=seq(340.5, 344.5, by = 0.1))

korona <- 344.5
arapaszto <- 342.25
plot(level ~ volume, vol.df, typ="n",
     xlab = "Tározó térfogat [m^3]",
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