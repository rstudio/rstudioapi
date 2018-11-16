
#' Add a Job
#'
#' Inform RStudio's Jobs pane that a job has been added.
#'
#' @param name The job's name.
#' @param status The initial status text for the job; optional.
#' @param progressUnits The integer number of units of work in the job; for example, \code{100L}
#'   if the job's progress is expressed in percentages. Use \code{0L} if the number of units of 
#'   work is unknown.
#' @param actions A list of actions that can be performed on the job (see Actions).
#' @param running Whether the job is currently running.
#' @param autoRemove Whether to remove the job from the Jobs pane when it's complete.
#' @param show Whether to show the job in the Jobs pane.
#' @return An ID representing the newly added job, used as a handle to provide
#'   further updates of the job's status.
#'
#' @section Actions:
#' The \code{actions} parameter is a named list of functions that the user can invoke on the job;
#' for example: \code{actions = list(stop = function(id) { ... })}. The function will be passed a
#' parameter named \code{id} with the job ID that invoked it. 
#' 
#' There are two special action names:
#' \describe{
#'    \item{stop}{If there is an action named \code{stop}, then the job will
#'    have a Stop button in in the Jobs pane, and pressing that button will invoke
#'    the \code{stop} action.}
#'    \item{info}{If there is an action named \code{info}, then the job will
#'    have an informational link in the Jobs pane rather than an output
#'    display, and clicking the link will invoke the \code{info} action.}
#' }
#'
#' @export
jobAdd <- function(name, status = "", progressUnits = 0L, actions = NULL, running = FALSE, 
                   autoRemove = TRUE, show = TRUE) {
    callFun("addJob", name          = name,
                      status        = status,
                      progressUnits = progressUnits,
                      actions       = actions,
                      running       = running,
                      autoRemove    = autoRemove,
                      show          = show)
}

#' Remove a Job
#'
#' Remove a job from RStudio's Jobs pane.
#' 
#' @param job The ID of the job to remove.
#'
#' @export
jobRemove <- function(job) {
    callFun("removeJob", job = job)
}

#' Set Job Progress
#'
#' Updates the progress for a job.
#' 
#' @param job The ID of the job to set progress for.
#' @param units The integer number of total units of work completed so far.
#'
#' @export
jobSetProgress <- function(job, units) {
    callFun("setJobProgress", job = job, units = units)
}

#' Add Job Progress
#'
#' Adds incremental progress units to a job.
#' 
#' @param job The ID of the job to update progress for.
#' @param units The integer number of new progress units completed.
#'
#' @export
jobAddProgress <- function(job, units) {
    callFun("addJobProgress", job = job, units = units)
}

#' Set Job Status
#'
#' Update a job's informational status text.
#'
#' @param job The ID of the job to update.
#' @param status Text describing job's new status.
#'
#' @export
jobSetStatus <- function(job, status) {
    callFun("setJobStatus", job = job, status = status)
}


#' Set Job State
#'
#' Changes the state of a job.
#' 
#' @param job The ID of the job on which to change state.
#' @param state The new job state.
#'
#' @section States:
#' The following states are supported:
#' \describe{
#'   \item{idle}{The job is waiting to run.}
#'   \item{running}{The job is actively running.}
#'   \item{succeeded}{The job has finished successfully.}
#'   \item{cancelled}{The job was cancelled.}
#'   \item{failed}{The job finished but did not succeed.}
#' }
#'
#' @export
jobSetState <- function(job, state = c("idle", "running", "succeeded", "cancelled", "failed")) {
    callFun("setJobState", job = job, state = state)
}


#' Add Job Output
#'
#' Adds text output to a job.
#' 
#' @param job The ID of the job that has emitted text.
#' @param output The text output emitted by the job.
#' @param error Whether the output represents an error.
#'
#' @export
jobAddOutput <- function(job, output, error = FALSE) {
    callFun("addJobOutput", job = job, output = output, error = error)
}


#' Run R Script As Job
#'
#' Starts an R script as a background job.
#' 
#' @param path The path to the R script to be run.
#' @param encoding The text encoding of the script, if known.
#' @param workingDir The working directory in which to run the job. When \code{NULL} (the default),
#'   the parent directory of the R script is used.
#' @param importEnv Whether to import the global environment into the job.
#' @param exportEnv The name of the environment in which to export the R objects created by the
#'   job. Use \code{""} (the default) to skip export, \code{"R_GlobalEnv"}` to export to the 
#'   global environment, or the name of an environment object to create an object with that name.
#'
#' @export
jobRunScript <- function(path, encoding = "unknown", workingDir = NULL, importEnv = FALSE,
                         exportEnv = "") {
    callFun("runScriptJob", path       = path,
                            encoding   = encoding,
                            workingDir = workingDir,
                            importEnv  = importEnv,
                            exportEnv  = exportEnv)
}
