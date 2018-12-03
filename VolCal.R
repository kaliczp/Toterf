VolCal <- function(x, levels) {
    LevVol.df <- data.frame(level = levels, volume = NA)

    for(ttlev in 1:nrow(LevVol.df)) {
        akt.mat <- LevVol.df[ttlev, "level"] - x
        akt.mat[akt.mat < 0] <- NA
        LevVol.df[ttlev, "volume"] <- sum(akt.mat, na.rm = TRUE)
    }
    
    LevVol.df
}
