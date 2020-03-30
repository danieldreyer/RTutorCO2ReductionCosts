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

predict.robust <- function(m, data, data_p) {
  require(sandwich)
  
  reg_temp <- lm(co2mass ~ ns(costratio, df=5), data=data)
  pred_df <- data.frame(fit=predict(m, newdata=data_p))
  
  # get HAV VCOV matrix, equal to NewwayWest()
  robust_errors <- vcovHC(reg_temp, type = "HC2")
  # get model matrix
  mat <- model.matrix(reg_temp)
  # point-wise variance for prediction
  var_fit_hac <- rowSums((mat %*% robust_errors) * mat)
  # standard errors
  se_fit_hac = sqrt(var_fit_hac)
  
  pred_df_data <- pred_df %>%
    mutate(
      # calculate CI intervals
      lwr = pred_df$fit - qt(0.975, df=m$df.residual)*se_fit_hac,
      upr = pred_df$fit + qt(0.975, df=m$df.residual)*se_fit_hac
    )
}