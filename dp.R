show.regression= function(...){
  library(stargazer)
    stargazer(..., 
            type = "text", 
            style = "aer",  
            digits = 3,
            df = FALSE,
            report = "vct*",
            star.cutoffs = c(0.05, 0.01, 0.001),
            model.names = FALSE,
            object.names = TRUE,
            model.numbers = FALSE, 
            omit.stat=c("f", "ser")
    )
} 

