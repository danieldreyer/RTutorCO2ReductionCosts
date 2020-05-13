ShowRegression= function(...){
  library(stargazer)
    stargazer(..., 
            type = "text", 
            style = "aer",  
            digits = 3,
            df = FALSE,
            star.cutoffs = c(0.05, 0.01, 0.001),
            model.names = FALSE,
            object.names = TRUE,
            model.numbers = FALSE, 
            omit.stat=c("f", "ser")
    )
} 

PredictRobust <- function(m, data, data_p) {
  require(estimatr)
  reg_temp <- lm_robust(m, data=data, se_type="HC1")
  pred_df <- as.data.frame(predict(reg_temp, data_p, interval="confidence"))
  pred_df <- pred_df %>% 
    rename(fit="fit.fit", lwr="fit.lwr",upr="fit.upr")
}