% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/terminal.R
\name{terminalClear}
\alias{terminalClear}
\title{Clear Terminal Buffer}
\usage{
terminalClear(id)
}
\arguments{
\item{id}{The terminal id. The \code{id} is obtained from
\code{\link{terminalList}()}, \code{\link{terminalVisible}()},
\code{\link{terminalCreate}()}, or \code{\link{terminalExecute}()}.}
}
\description{
Clears the buffer for specified terminal.
}
\note{
The \code{terminalClear} function was added in version 1.1.350 of
RStudio.
}
\examples{

\dontrun{
termId <- rstudioapi::terminalCreate()
rstudioapi::terminalSend(termId, 'ls -l\n')
Sys.sleep(3)
rstudioapi::terminalClear(termId)
}


}
