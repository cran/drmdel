\name{quantileDRM}
\alias{quantileDRM}
\title{Estimate the quantiles of the populations under the
  DRM}
\description{
  Suppose we have m+1 samples, labeled as \eqn{0, \, 1, \,
    \ldots, \, m}{0, 1, ..., m}, whose population
  distributions satisfy the density ratio model (DRM) (see
  \code{\link{drmdel}} for the definition of DRM). The
  \code{\link{quantileDRM}} function estimates the quantiles
  of the population distributions.
}
\usage{
quantileDRM(k, p, drmfit, cov=TRUE, interpolation=TRUE,
            adj=FALSE, adj_val=NULL, bw=NULL, show_bw=FALSE)
}
\arguments{
  \item{k}{a vector of labels of populations whose quantiles
    are to be estimated, with k[i] = 0, 1, ..., m. It could
    also be a single integer value (in the set of {0, 1,
      ..., m}), in which case, it means that we estimate the
    quantile of the same population at each of the
    probability value p (see below for the explaination of
    argument "p").}
  \item{p}{a vector of probabilities (the same length as
    argument "k") at which the quantiles are estimated; It
    could also be a single value, in which case, it means
    that for each population k, we estimate the quantile at
    a same probability value.}
  \item{drmfit}{a fitted DRM object (an output from the
    \code{\link{drmdel}} function). See \code{\link{drmdel}}
    for details.}
  \item{cov}{a logical variable specifying whether to
    estimate the covariance matrix of the quantile
    estimators. The default is TRUE.}
  \item{interpolation}{The EL quantile estimator is based on
    the EL CDF estimator. Hence the way the EL CDF estimate
    is calculated affects the result of the quantile
    estimation. This argument is to be passed to the
    \code{\link{cdfDRM}} function for tweaking the EL CDF
    estimator. See \code{\link{cdfDRM}} for details.}
  \item{adj}{a logical variable specifying whether to adjust
    the CDF estimation by adding a term when estimating
    quantiles; The default is FALSE. See "Details" section.}
  \item{adj_val}{a vector of the same length as the argument
    "k" (or as the argument "p" if the length of "k" is 1)
    containing the values of adjustment terms for lower or
    higher quantile estimation, if \code{adj=TRUE}. The
    default value, NULL, uses
    \eqn{-1/(2n_{k}[i])}{-1/2*n_k[i]}, where
    \eqn{n_{k}[i]}{n_k[i]} is the size of the
    k\eqn{\textsuperscript{th}}{^th} sample sample, for each
    \eqn{i}{i}, to adjust the EL quantile estimator for
    lower quantile estimation. See "Details" section}
  \item{bw}{a vector of bandwidths (the same length as the
    argument "k") for kernel density estimation required for
    estimating the covariance matrix of the quantile
    estimators; It could also be a single value, in which
    case, it means that for each population k, we use the
    same bandwidth. The default bandwidth, NULL, uses that
    described in Chen and Liu (2013).}
  \item{show_bw}{a logical variable specifying whether to
    output bandwidths when argument cov=TRUE. The default is
    FALSE.}
}
\value{
  \item{est}{quantile estimates.}
  \item{cov}{estimated covariance matrix of the quantile
    estimators, available only if argument cov=TRUE.}
  \item{bw}{bandwidths used for kernel density estimation
    required for estimating the covariance matrix of the
    quantile estimators, available only if argument cov=TRUE
    and show_bw=TRUE.}
}
\details{
  Denote the estimated CDF of the
  k\eqn{\textsuperscript{th}}{^th} population as
  \eqn{\hat{F}_k(x)}{Fhat_k(x)}. The
  p\eqn{\textsuperscript{th}}{^th} quantile of
  \eqn{F_k(x)}{F_k(x)} then is estimated as
  \deqn{\inf\{ x: \, \hat{F}_k(x) \ge p\}.}{
      inf{x: Fhat_k(x) >= p}.}

  The estimated CDF \eqn{\hat{F}_k(x)}{Fhat_k(x)} reaches
  its maximum value, 1, at the largest observed data point.
  If the true CDF \eqn{F_k(x)}{F_k(x)} is continuous,
  \eqn{F_k(x)}{F_k(x)} tends to 1 when x tends to infinity.
  Hence, when estimate an upper quanitle, say
  0.95\eqn{\textsuperscript{th}}{^th} quantile, of
  \eqn{F_k}{F_k}, the quantile estimator is likely to under
  estimate the ture quantile, especially when sample size is
  not too large. To adjust an upper quantile estimator for
  possible under-estimation, one may want to adjust the
  estimated CDF as
  \deqn{\hat{F}_k(x) + \mbox{adj\_val}.}{
      Fhat_k(x) + adj_val.}
  and use the adjusted CDF to estimate quantiles. To make an
  upper quantile estimator larger, the adj_val should have a
  positive value. Similarly, to adjust lower quantile
  estimates for possible over-estimation, the adj_val should
  have a negative value.

  The \code{\link{quantileDRM}} function, by default, does
  not adjust CDF estimators (\code{adjust=FALSE}). When
  \code{adjust=TRUE}, the default adj_val is set to
  \eqn{-1/(2n_{k}[i])}{-1/2*n_k[i]}, where
  \eqn{n_{k}[i]}{n_k[i]} is the size of the
  k\eqn{\textsuperscript{th}}{^th} sample sample, for each
  \eqn{i}{i}, to adjust the EL quantile estimator for lower
  quantile estimation.
}
\references{
  J. Chen and Y. Liu (2013),
  Quantile and quantile-function estimations under density
  ratio model.
  \emph{The Annals of Statistics}, 41(3):1669-1692.
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

# Quantile estimation
# Denote the p^th quantile of the k^th, k=0, 1, ..., 4,
# population as q_{k,p}.

# Estimate q_{0,0.25}, q_{0,0.6}, q_{1,0.1} and q_{2,0.1}.
(qe <- quantileDRM(k=c(0, 0, 1, 2), p=c(0.25, 0.6, 0.1, 0.1),
                  drmfit=drmfit))

# Estimate the 0.05^th, 0.2^th and 0.8^th quantiles of F_3
(qe1 <- quantileDRM(k=3, p=c(0.05, 0.2, 0.8), drmfit=drmfit))
 
# Estimate the 0.05^th quantiles of F_1, F_3 and F_4
(qe2 <- quantileDRM(k=c(1 , 3, 4), p=0.05, drmfit=drmfit))
}
\keyword{methods}
