VolCal <- function(x, levels, surface = FALSE) {
    LevVol.df <- data.frame(level = levels, volume = NA)

    if(surface) {
        LevVol.df$surface <- NA
    }

    for(ttlev in 1:nrow(LevVol.df)) {
        akt.mat <- LevVol.df[ttlev, "level"] - x
        akt.mat[akt.mat < 0] <- NA
        LevVol.df[ttlev, "volume"] <- sum(akt.mat, na.rm = TRUE)
        if(surface) {
            LevVol.df[ttlev, "surface"] <- sum(!is.na(akt.mat))
        }
    }
    
    LevVol.df
}
