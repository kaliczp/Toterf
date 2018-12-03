library(rgrass7)

## Raszter beolvasás
PisztrSurf <- readRAST("surfvec1m")

## Mátrixra konvertált
PisztrSurf.mat <- as.matrix(PisztrSurf)
min(PisztrSurf.mat)
max(PisztrSurf.mat)

VolCal(PisztrSurf.mat, levels=341:342)
