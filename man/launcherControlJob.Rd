% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/launcher-functions.R
\name{launcherControlJob}
\alias{launcherControlJob}
\title{Interact with (Control) a Job}
\usage{
launcherControlJob(
  jobId,
  operation = c("suspend", "resume", "stop", "kill", "cancel")
)
}
\arguments{
\item{jobId}{The job id.}

\item{operation}{The operation to execute. The operation should be one of
\code{c("suspend", "resume", "stop", "kill", "cancel")}. Note that different
launcher plugins support different subsets of these operations -- consult
your launcher plugin documentation to see which operations are supported.}
}
\description{
Interact with a job.
}
