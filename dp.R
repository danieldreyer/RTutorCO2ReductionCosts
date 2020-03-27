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

gf = function(form, values=list(), enclos=parent.frame(), as.formula=TRUE, form.env = parent.frame(), collapse=" + " ) {
  
  if (is(form,"formula")) {
    # Use for formula with 3 parts formulation from here
    # https://github.com/tidyverse/glue/issues/108
    parts <- gsub("\\n\\s*","",as.character(form))
    if (length(parts)==3) {
      form = paste0(parts[c(2,1,3)], collapse="")
    } else {
      # If the formula does not have 3 parts: capture output
      form = paste0(trimws(capture.output(print(form))), collapse="")
    }
  }
  
  open = gregexpr("{",form, fixed=TRUE)[[1]]
  close = gregexpr("}",form, fixed=TRUE)[[1]]
  vars = substring(form,open+1, close-1)
  
  vals = lapply(vars, function(var) {
    if (var %in% names(values)) {
      val = values[[var]]
    } else {
      val = enclos[[var]]
    }
    paste0(val, collapse=collapse)
  })
  names(vals) = vars
  res = glue(form, .envir = vals)
  if (!as.formula) {
    return(res)
  }
  res.form = try(as.formula(res,form.env),silent = TRUE)
  if (is(res.form,"try-error")) {
    stop(paste0("You created a non-valid formula:\n",res))
  }
  return(res.form)
}