#' @title Makes class 'gmvar' objects compatible with the functions using class 'gsmvar' objects
#'
#' @description \code{gmvar_to_gsmvar} class 'gmvar' objects compatible with the functions using
#' s class 'gsmvar' objects
#'
#' @param gsmvar a class 'gmvar' or 'gsmvar' object.
#' @details This exists so that models estimated with earlier versions
#'   of the package can be used conveniently.
#' @return If the provided object has the class 'gsmvar', the provided object
#'   is returned without modifications. If the provided object has the class 'gmvar',
#'   its element \code{$model} is given a new subelement called also model and this is
#'   set to be "GMVAR". Also, the class of this object is changes to 'gsmvar' and then
#'   it is returned.
#' @export

gmvar_to_gsmvar <- function(gsmvar) {
  stopifnot(class(gsmvar) %in% c("gsmvar", "gmvar"))
  if(class(gsmvar) == "gmvar") {
    class(gsmvar) <- "gsvmar"
    gsmvar$mode$model <- "GMVAR"
  }
  gsmvar
}


#' @title Deprecated S3 methods for the deprecated class 'gmvar'
#'
#' @description Deprecated S3 methods for the deprecated class 'gmvar'. From
#'   the gmvarkit version 2.0.0 onwards, class 'gsmvar' is used instead.
#'
#' @param x a class 'gmvar' object. THIS CLASS IS DEPRECATED FROM THE VERSION
#'   2.0.0 ONWARDS.
#' @param object  a class 'gmvar' object. THIS CLASS IS DEPRECATED FROM THE VERSION
#'   2.0.0 ONWARDS.
#' @param digits number of digits to be printed.
#' @param ... See the usage from the documentation of the appropriate class 'gsmvar' S3 method.
#' @details These methods exist so that models estimated with earlier versions
#'   of the package can be used normally.
#' @export

print.gmvar <- function(x, ..., digits=2) {
  gsmvar <- gmvar_to_gsmvar(x)
  print(gsmvar, ..., digits=digits)
}


#' @rdname print.gmvar
#' @export

summary.gmvar <- function(object, ..., digits) {
  gsmvar <- gmvar_to_gsmvar(object)
  summary(gsmvar, ..., digits=digits)
}

#' @rdname print.gmvar
#' @export

plot.gmvar <- function(x, ...) {
  gsmvar <- gmvar_to_gsmvar(x)
  plot(gsmvar, ...)
}


#' @rdname print.gmvar
#' @param object object of class \code{'gmvar'}. THIS CLASS IS DEPRECATED FROM THE VERSION
#'   2.0.0 ONWARDS.
#' @export

logLik.gmvar <- function(object, ...) {
  gsmvar <- gmvar_to_gsmvar(object)
  gsmvar$loglik
}


#' @rdname print.gmvar
#' @export

residuals.gmvar <- function(object, ...) {
  gsmvar <- gmvar_to_gsmvar(object)
  res <- gsmvar$quantile_residuals
  colnames(res) <- colnames(object$data)
  res
}


#' @title plot method for class 'gmvarpred' objects
#'
#' @description \code{plot.gmvarpred} is plot method for gsmvarpred objects.
#'  EXISTS FOR BACKWARD COMPATIBILITY. THE CLASS 'gmvarpred' IS DEPRECATED FROM
#'  THE VERSION 2.0.0 ONWARD: WE USE THE CLASS 'gsmvarpred' NOW.
#'
#' @inheritParams plot.gsmvarpred
#' @param digits how many digits to print?
#' @details These methods exist so that objects created with earlier versions
#'   of the package can be used normally.
#' @export

plot.gmvarpred <- function(x, ..., nt, mix_weights=TRUE, add_grid=TRUE) {
  class(x) <- "gsmvarped"
  plot(x, ..., mix_weights=mix_weights, add_grid=add_grid)
}


#' @rdname plot.gmvarpred
#' @export

print.gmvarpred <- function(x, ..., digits=2) {
  class(x) <- "gsmvarped"
  print(x, ..., digits=digits)
}



#' @title Summary print method from objects of class 'gmvarsum'
#'
#' @description \code{print.gmvarsum} is a print method for object \code{'gmvarsum'}.
#'   EXISTS FOR BACKWARD COMPATIBILITY. CLASS 'gmvarsum' IS DEPRECATED FROM THE VERSION
#'   2.0.0. ONWARDS. NOW, WE USE THE CLASS 'gsmvarsum'.
#' @inheritParams print.gsmvarsum
#' @export

print.gmvarsum <- function(x, ..., digits) {
  class(x) <- "gsmvarsum"
  print(x, ..., digits=2)
}




#' @title DEPRECATED! USE THE FUNCTION GSMVAR INSTEAD! Create a class 'gsmvar' object defining
#'  a reduced form or structural GMVAR model
#'
#' @description \code{GSMVAR} creates a class \code{'gsmvar'} object that defines
#'  a reduced form or structural GMVAR model DEPRECATED! USE THE FUNCTION GSMVAR INSTEAD!
#'
#' @inheritParams GSMVAR
#' @section About S3 methods:
#'   Only the \code{print} method is available if data is not provided.
#'   If data is provided, then in addition to the ones listed above, the \code{predict} method is also available.
#' @seealso \code{\link{GSMVAR}}
#' @inherit GSMVAR references return details
#' @export

GMVAR <- function(data, p, M, d, params, conditional=TRUE, parametrization=c("intercept", "mean"),
                   constraints=NULL, same_means=NULL, structural_pars=NULL, calc_cond_moments, calc_std_errors=FALSE,
                   stat_tol=1e-3, posdef_tol=1e-8) {
  .Deprecated("GSMVAR")
  GSMVAR(data=data, p=p, M=M, d=d, params=params, model="GMVAR", conditional=conditional,
         parametrization=parametrization, constraints=constraints, same_means=same_means,
         structural_pars=structural_pars, calc_cond_moments=calc_cond_moments,
         calc_std_errors=calc_std_errors, stat_tol=stat_tol, posdef_tol=posdef_tol)
}


#' @title DEPRECATED! USE THE FUNCTION alt_gsmvar INSTEAD!
#' Construct a GMVAR model based on results from an arbitrary estimation round of \code{fitGSMVAR}
#'
#' @description DEPRECATED! USE THE FUNCTION alt_gsmvar INSTEAD! \code{alt_gsmvar} constructs
#'   a GMVAR model based on results from an arbitrary estimation round of \code{fitGSMVAR}.
#'
#' @inheritParams alt_gsmvar
#' @param gmvar object of class 'gmvar'
#' @inherit alt_gsmvar references return details
#' @seealso \code{\link{alt_gsmvar}}
#' @export

alt_gmvar <- function(gmvar, which_round=1, which_largest, calc_cond_moments=TRUE, calc_std_errors=TRUE) {
  .Deprecated("alt_gsmvar")
  gsmvar <- gmvar_to_gsmvar(gmvar)
  alt_gsmvar(gsmvar, which_round=which_round, which_largest=which_largest,
             calc_cond_moments=calc_cond_moments, calc_std_errors=calc_std_errors)
}


#' @title DEPRECATED! USE THE FUNCTION fitGSMVAR INSTEAD! Two-phase maximum likelihood estimation of a GMVAR model
#'
#' @description DEPRECATED! USE THE FUNCTION fitGSMVAR INSTEAD!
#'   \code{fitGMVAR} estimates a GMVAR model model in two phases:
#'   in the first phase it uses a genetic algorithm to find starting values for a gradient based
#'   variable metric algorithm, which it then uses to finalize the estimation in the second phase.
#'   Parallel computing is utilized to perform multiple rounds of estimations in parallel.
#'
#' @inheritParams fitGSMVAR
#' @seealso \code{\link{fitGSMVAR}}
#' @inherit fitGSMVAR details return references
#' @export

fitGMVAR <- function(data, p, M, conditional=TRUE, parametrization=c("intercept", "mean"),
                      constraints=NULL, same_means=NULL, structural_pars=NULL, ncalls=M^6, ncores=2, maxit=1000,
                      seeds=NULL, print_res=TRUE, ...) {
  .Deprecated("fitGSMVAR")
  fitGSMVAR(data=data, p=p, M=M, model="GMVAR", conditional=conditional, parametrization=parametrization,
            constraints=constraints, same_means=same_means, structural_pars=structural_pars, ncalls=ncalls,
            ncores=ncores, maxit=maxit, seeds=seeds, print_res=print_res, ...)
}


#' @title DEPRECATED! USE THE FUNCTION fitGSMVAR INSTEAD!
#' Switch from two-regime reduced form GMVAR model to a structural model.
#'
#' @description DEPRECATED! USE THE FUNCTION fitGSMVAR INSTEAD!
#' \code{gsmvar_to_sgsmvar} constructs SGMVAR model based on a reduced
#'   form GMVAR, StMVAR, or G-StMVAR model.
#'
#' @inheritParams alt_gmvar
#' @seealso \code{\link{gsmvar_to_sgsmvar}}
#' @inherit gsmvar_to_sgsmvar details return references
#' @export

gmvar_to_sgmvar <- function(gmvar, calc_std_errors=TRUE) {
  .Deprecated("gsmvar_to_sgsmvar")
  gsmvar <- gmvar_to_gsmvar(gsmvar)
  gsmvar_to_sgsmvar(gsmvar, calc_std_errors=calc_std_errors)
}



#' @title DEPRECATED! USE THE FUNCTION simulate.gsmvar INSTEAD! Simulate from GMVAR process
#'
#' @description DEPRECATED! USE THE FUNCTION simulate.gsmvar INSTEAD!
#'   \code{simulateGMVAR} simulates observations from a GMVAR
#'
#' @inheritParams simulate.gsmvar
#' @param gmvar an object of class \code{'gmvar'}
#' @param nsimu number of observations to be simulated.
#' @seealso \code{\link{simulate.gsmvar}}
#' @inherit simulate.gsmvar details return references
#' @export

simulateGMVAR <- function(gsmvar, nsimu, init_values=NULL, ntimes=1, drop=TRUE, seed=NULL, girf_pars=NULL) {
  .Deprecated("simulate.gsmvar")
  gsmvar <- gmvar_to_gsmvar(gsmvar)
  simulate.gsmvar(object=gsmvar, nsim=nsimu, seed=seed, init_values=init_values,
                  ntimes=ntimes, drop=drop, girf_pars=girf_pars)
}