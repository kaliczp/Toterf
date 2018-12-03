library(rgrass7)

## Raszter beolvasás
PisztrSurf <- readRAST("surfvec1m2")

## Mátrixra konvertált
PisztrSurf.mat <- as.matrix(PisztrSurf)
min(PisztrSurf.mat)
max(PisztrSurf.mat)

vol.df <- VolCal(PisztrSurf.mat, levels=seq(340.5, 344.5, by = 0.1))

plot(level ~ volume, vol.df, typ="n",
     xlab = "Tározó térfogat [m^3]",
     ylab = "Vízállás [m B. f.]")
grid()
lines(level ~ volume, vol.df, lwd = 2)
## Gátkorona
axis(2, at = 344.5, lab = FALSE, tck = 1, lty = "dashed")
## Árapasztó
axis(2, at = 342.25, lab = FALSE, tck = 1, lty = "dashed")
