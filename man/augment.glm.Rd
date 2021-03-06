% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stats-glm-tidiers.R
\name{augment.glm}
\alias{augment.glm}
\title{Augment a(n) glm object}
\usage{
\method{augment}{glm}(x, ...)
}
\arguments{
\item{x}{A \code{glm} object returned from \code{\link[stats:glm]{stats::glm()}}.}

\item{...}{Arguments passed on to \code{augment.lm}
\describe{
  \item{data}{A \code{\link[=data.frame]{data.frame()}} or \code{\link[tibble:tibble]{tibble::tibble()}} containing the original
data that was used to produce the object \code{x}. Defaults to
\code{stats::model.frame(x)} so that \code{augment(my_fit)} returns the augmented
original data. \strong{Do not} pass new data to the \code{data} argument.
Augment will report information such as influence and cooks distance for
data passed to the \code{data} argument. These measures are only defined for
the original training data.}
  \item{newdata}{A \code{\link[=data.frame]{data.frame()}} or \code{\link[tibble:tibble]{tibble::tibble()}} containing all
the original predictors used to create \code{x}. Defaults to \code{NULL}, indicating
that nothing has been passed to \code{newdata}. If \code{newdata} is specified,
the \code{data} argument will be ignored.}
  \item{type.predict}{Type of predictions to use when \code{x} is a \code{glm} object.
Passed to \code{\link[stats:predict.glm]{stats::predict.glm()}}.}
  \item{type.residuals}{Type of residuals to use when \code{x} is a \code{glm} object.
Passed to \code{\link[stats:residuals.glm]{stats::residuals.glm()}}.}
  \item{x}{An \code{lm} object created by \code{\link[stats:lm]{stats::lm()}}.}
}}
}
\value{
When \code{newdata} is not supplied \code{augment.lm} returns
one row for each observation, with seven columns added to the original
data:

\item{.hat}{Diagonal of the hat matrix}
\item{.sigma}{Estimate of residual standard deviation when
corresponding observation is dropped from model}
\item{.cooksd}{Cooks distance, \code{\link[=cooks.distance]{cooks.distance()}}}
\item{.fitted}{Fitted values of model}
\item{.se.fit}{Standard errors of fitted values}
\item{.resid}{Residuals}
\item{.std.resid}{Standardised residuals}

Some unusual \code{lm} objects, such as \code{rlm} from MASS, may omit \code{.cooksd}
and \code{.std.resid}. \code{gam} from mgcv omits \code{.sigma}.

When \code{newdata} is supplied, returns one row for each observation, with
three columns added to the new data:

\item{.fitted}{Fitted values of model}
\item{.se.fit}{Standard errors of fitted values}
\item{.resid}{Residuals of fitted values on the new data}
}
\description{
This augment method wraps \code{\link[=augment.lm]{augment.lm()}}.
}
\seealso{
\code{\link[=augment]{augment()}}, \code{\link[=augment.lm]{augment.lm()}}

\code{\link[stats:glm]{stats::glm()}}

Other lm tidiers: \code{\link{augment.lm}},
  \code{\link{glance.glm}}, \code{\link{glance.lm}},
  \code{\link{tidy.glm}}, \code{\link{tidy.lm}}
}
\concept{lm tidiers}
