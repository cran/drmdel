\name{summaryDRM}
\alias{summaryDRM}
\title{Print simple summaries of a DRM fit object}
\description{
  Print simple summaries of a density ratio model (DRM) fit
  object, i.e. an output from \code{\link{drmdel}} function.
}
\usage{
summaryDRM(drmfit)
}
\arguments{
  \item{drmfit}{a fitted DRM object (an output from the
    \code{\link{drmdel}} function). See \code{\link{drmdel}}
    for details.}
}
\value{
  Summaries of the fitted DRM object, including the basic
  information about the fitted DRM, maximum empirical
  likelihood estimates (MELE) of the DRM parameters, results
  of the dual empirical likelihood ratio (DELR) test for
  hypothesis about the DRM parameter \eqn{\beta}{beta} and
  some summary statistics of the estimated distribution
  functions \eqn{F_k}{F_k}, \eqn{k = 0, 1, ..., m}{k = 0, 1,
    ..., m}.
}
\note{
  For more detailed but less user-friendly formatted
  information about a fitted DRM object, one should directly
  check the output from the \code{\link{drmdel}} function.
  See \code{\link{drmdel}} for details.
}
\examples{
# Data generation
set.seed(25)
n_samples <- c(100, 200, 180, 150, 175)  # sample sizes
x0 <- rgamma(n_samples[1], shape=5, rate=1.8)
x1 <- rgamma(n_samples[2], shape=12, rate=1.2)
x2 <- rgamma(n_samples[3], shape=12, rate=1.2)
x3 <- rgamma(n_samples[4], shape=18, rate=5)
x4 <- rgamma(n_samples[5], shape=25, rate=2.6)
x <- c(x0, x1, x2, x3, x4)

# Fit a DRM with the basis function q(x) = (x, log(abs(x))),
# which is the basis function for gamma family. This basis
# function is the built-in basis function 6.
drmfit <- drmdel(x=x, n_samples=n_samples, basis_func=6)

# A brief summary of the DRM fit
summaryDRM(drmfit)

# List the details of the DRM fit.  See help(drmdel) for
# details.
names(drmfit)
}
