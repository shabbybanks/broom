% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/stats-decompose-tidiers.R
\name{augment.decomposed.ts}
\alias{augment.decomposed.ts}
\alias{decompose_tidiers}
\title{Augment data with information from a(n) decomposed.ts object}
\usage{
\method{augment}{decomposed.ts}(x, ...)
}
\arguments{
\item{x}{A \code{decomposed.ts} object returned from \code{\link[stats:decompose]{stats::decompose()}}.}

\item{...}{Additional arguments. Not used. Needed to match generic
signature only. \strong{Cautionary note:} Misspelled arguments will be
absorbed in \code{...}, where they will be ignored. If the misspelled
argument has a default value, the default value will be used.
For example, if you pass \code{conf.lvel = 0.9}, all computation will
proceed using \code{conf.level = 0.95}. Additionally, if you pass
\code{newdata = my_tibble} to an \code{\link[=augment]{augment()}} method that does not
accept a \code{newdata} argument, it will use the default value for
the \code{data} argument.}
}
\value{
A \link[tibble:tibble]{tibble::tibble} with one row for each observation in the
original times series:

\item{\code{.seasonal}}{The seasonal component of the decomposition.}
\item{\code{.trend}}{The trend component of the decomposition.}
\item{\code{.remainder}}{The remainder, or "random" component of the
decomposition.}
\item{\code{.weight}}{The final robust weights (\code{stl} only).}
\item{\code{.seasadj}}{The seasonally adjusted (or "deseasonalised")
series.}
}
\description{
Augment accepts a model object and a dataset and adds
information about each observation in the dataset. Most commonly, this
includes predicted values in the \code{.fitted} column, residuals in the
\code{.resid} column, and standard errors for the fitted values in a \code{.se.fit}
column. New columns always begin with a \code{.} prefix to avoid overwriting
columns in the original dataset.

Users may pass data to augment via either the \code{data} argument or the
\code{newdata} argument. If the user passes data to the \code{data} argument,
it \strong{must} be exactly the data that was used to fit the model
object. Pass datasets to \code{newdata} to augment data that was not used
during model fitting. This still requires that all columns used to fit
the model are present.

Augment will often behavior different depending on whether \code{data} or
\code{newdata} is specified. This is because there is often information
associated with training observations (such as influences or related)
measures that is not meaningfully defined for new observations.

For convenience, many augment methods provide default \code{data} arguments,
so that \code{augment(fit)} will return the augmented training data. In these
cases augment tries to reconstruct the original data based on the model
object, with some varying degrees of success.

The augmented dataset is always returned as a \link[tibble:tibble]{tibble::tibble} with the
\strong{same number of rows} as the passed dataset. This means that the
passed data must be coercible to a tibble. At this time, tibbles do not
support matrix-columns. This means you should not specify a matrix
of covariates in a model formula during the original model fitting
process, and that \code{\link[splines:ns]{splines::ns()}}, \code{\link[stats:poly]{stats::poly()}} and
\code{\link[survival:Surv]{survival::Surv()}} objects are not supported in input data. If you
encounter errors, try explicitly passing a tibble, or fitting the original
model on data in a tibble.

We are in the process of defining behaviors for models fit with various
\link{na.action} arguments, but make no guarantees about behavior when data is
missing at this time.
}
\examples{

# Time series of temperatures in Nottingham, 1920-1939:
nottem

# Perform seasonal decomposition on the data with both decompose
# and stl:
d1 <- stats::decompose(nottem)
d2 <- stats::stl(nottem, s.window = "periodic", robust = TRUE)

# Compare the original series to its decompositions.

cbind(broom::tidy(nottem), broom::augment(d1),
      broom::augment(d2))

# Visually compare seasonal decompositions in tidy data frames.

library(tibble)
library(dplyr)
library(tidyr)
library(ggplot2)

decomps <- tibble(
    # Turn the ts objects into data frames.
    series = list(as.data.frame(nottem), as.data.frame(nottem)),
    # Add the models in, one for each row.
    decomp = c("decompose", "stl"),
    model = list(d1, d2)
) \%>\%
    rowwise() \%>\%
    # Pull out the fitted data using broom::augment.
    mutate(augment = list(broom::augment(model))) \%>\%
    ungroup() \%>\%
    # Unnest the data frames into a tidy arrangement of
    # the series next to its seasonal decomposition, grouped
    # by the method (stl or decompose).
    group_by(decomp) \%>\%
    unnest(series, augment) \%>\%
    mutate(index = 1:n()) \%>\%
    ungroup() \%>\%
    select(decomp, index, x, adjusted = .seasadj)

ggplot(decomps) +
    geom_line(aes(x = index, y = x), colour = "black") +
    geom_line(aes(x = index, y = adjusted, colour = decomp,
                  group = decomp))

}
\seealso{
\code{\link[=augment]{augment()}}, \code{\link[stats:decompose]{stats::decompose()}}

Other decompose tidiers: \code{\link{augment.stl}}
}
\concept{decompose tidiers}
