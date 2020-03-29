
library(sandwich)

test <- data.frame(fit = predict(reg_east, newdata = predict_east))
  
  temp <- NeweyWest(reg_east, lag=7, prewhite = F)
  X_mat <- model.matrix(reg_east)
  var_fit_hac <- rowSums((X_mat %*% temp) * X_mat)
  se_fit_hac = sqrt(var_fit_hac)
  
  test2 <- test %>%
    mutate(
      lwr = test$fit - qt(0.975, df=reg_east$df.residual)*var_fit_hac,
      upr = test$fit + qt(0.975, df=reg_east$df.residual)*var_fit_hac)

        
  
  ## Get the design matrix
  X_mat <- model.matrix(reg1)
  
  ## Get HAC VCOV matrix and calculate SEs
  v_hac <- NeweyWest(reg1, prewhite = FALSE, adjust = TRUE) ## HAC VCOV (adjusted for small data sample)
  #> Warning in meatHAC(x, order.by = order.by, prewhite = prewhite, weights =
  #> weights, : more weights than observations, only first n used
  var_fit_hac <- rowSums((X_mat %*% v_hac) * X_mat)  ## Point-wise variance for predicted mean
  se_fit_hac <- sqrt(var_fit_hac) ## SEs
  
  ## Add these to pred_df and calculate the 95% CI
  pred_df <-
    pred_df %>%
    mutate(se_fit_hac = se_fit_hac) %>%
    mutate(
      lwr_hac = fit - qt(0.975, df=reg1$df.residual)*se_fit_hac,
      upr_hac = fit + qt(0.975, df=reg1$df.residual)*se_fit_hac
    )
  
  library(lmtest)
  coeftest(reg_east, vcov = vcovHC(reg_east, type="HC1"))

  
  
  
  

  
  fit <- predict(m01, data=east)
  
  v_hac <- vcovHC(reg_east, type = "HC2")
  X_mat <- model.matrix(model,data=east)
  #se.fit <- sqrt(diag(X %*% V %*% t(X)))
  se.fit <- rowSums((X_mat %*% v_hac) * X_mat)
 
  pred_df <- data.frame(fit = predict(reg_east, newdata = predict_east))
  
  pred_df <-
    pred_df %>%
    mutate(se_fit_hac = sqrt(se.fit)) %>%
    mutate(
      lwr = pred_df$fit - qt(0.975, df=reg_east$df.residual)*se_fit_hac,
      upr = pred_df$fit + qt(0.975, df=reg_east$df.residual)*se_fit_hac
    )  
  