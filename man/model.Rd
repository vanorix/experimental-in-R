% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model.R
\name{model}
\alias{model}
\title{Represents the functional dependency of the experimental model. It uses the 'euler'
method and the ODE function from the DeSolve package to generate the output.}
\usage{
model(df, Aef, Aint, hm, hd)
}
\arguments{
\item{df}{Data frame containing the data capture during the experimental session.}

\item{Aef}{Effective section of the discharge.}

\item{Aint}{Effective interception area.}

\item{hm}{Maximum lamina the produces a discharge.}

\item{hd}{Value of the lamina that triggers the discharge in the container.}
}
\value{
A DeSolve object containing the columns 't', 'h(t)', 'Qd(t)', which correspond to
the times, behavior of the laminas in time t, and functional dependency of the discharge
time t, respectively.
}
\description{
Represents the functional dependency of the experimental model. It uses the 'euler'
method and the ODE function from the DeSolve package to generate the output.
}
\note{
The parameter df must contain the columns "Tiempo" and "Descarga", each containing
time values and their respective water discharge quantities.
}
