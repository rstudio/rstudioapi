#' Retrieve Launcher Information
#'
#' Retrieve information about the launcher, as well as the different clusters
#' that the launcher has been configured to use.
#'
#' @name launcher
#' @export
launcherGetInfo <- function() {
  callLauncherFun("launcher.getInfo")
}

#' Check if Launcher is Available
#'
#' Check if the RStudio launcher is available and configured to support
#' 'ad-hoc' jobs; that is, jobs normally launched by the user through
#' the RStudio IDE's user interface.
#'
#' @name launcher
#' @export
launcherAvailable <- function() {
  callLauncherFun("launcher.jobsFeatureAvailable")
}

#' Retrieve Job Information
#'
#' Retrieve information on launcher jobs.
#'
#' @param statuses Return only jobs whose status matches one of `statuses`.
#'   Valid statuses are: Pending, Running, Suspended, Failed, Finished, Killed,
#'   Canceled. When `NULL`, all jobs are returned.
#'
#' @param fields Return a subset of fields associated with each job object.
#'   When `NULL`, all fields associated with a particular job are returned.
#'
#' @param includeSessions Boolean; include jobs which are also operating
#'   as RStudio R sessions?
#'
#' @param tags An optional set of tags. Only jobs that have been assigned one
#'   of these requested tags will be returned.
#'
#' @name launcher
#' @export
launcherGetJobs <- function(statuses = NULL,
                            fields = NULL,
                            tags = NULL,
                            includeSessions = FALSE)
{
  callLauncherFun("launcher.getJobs",
                  statuses = statuses,
                  fields = fields,
                  tags = tags,
                  includeSessions = includeSessions)
}

#' Retrieve Job Information
#'
#' Retrieve information on a job with id `jobId`.
#'
#' @param jobId The id of a launcher job.
#'
#' @export
launcherGetJob <- function(jobId) {
  callLauncherFun("launcher.getJob",
                  jobId = jobId)
}

#' Define a Launcher Configuration
#'
#' Define a launcher configuration, suitable for use with the `config` argument
#' to [launcherSubmitJob()].
#'
#' @param name The name of the launcher configuration.
#' @param value The configuration value. Must either be an integer, float, or string.
#'
#' @family job submission
#' @export
launcherConfig <- function(name, value = NULL)
{
  valueType <- if (is.integer(value))
    "int"
  else if (is.double(value))
    "float"
  else if (is.character(value))
    "string"

  value <- format(value)

  callLauncherFun("launcher.newConfig",
                  name = name,
                  value = value,
                  valueType = valueType)
}

#' Define a Launcher Container
#'
#' Define a launcher container, suitable for use with the `container` argument
#' to [launcherSubmitJob()].
#'
#' @param image The container image to use.
#' @param runAsUserId The user id to run as within the container. Defaults
#'   to the container-specified user.
#' @param runAsGroupId The group id to run as within the container. Defaults
#'   to the container-specified group.
#'
#' @family job submission
#' @export
launcherContainer <- function(image,
                              runAsUserId = NULL,
                              runAsGroupId = NULL)
{
  callLauncherFun("launcher.newContainer",
                  image = image,
                  runAsUserId = runAsUserId,
                  runAsGroupId = runAsGroupId)
}

#' Define a Launcher Placement Constraint
#'
#' Define a launcher placement constraint, suitable for use with the
#' `placementConstraints` argument to [launcherSubmitJob()].
#'
#' @param name The name of this placement constraint.
#' @param value The value of the constraint. A job will only be placed on a
#'   requested node if the requested placement constraint is present.
#'
#' @family job submission
#' @export
launcherPlacementConstraint <- function(name,
                                        value = NULL)
{
  callLauncherFun("launcher.newPlacementConstraint",
                  name = name,
                  value = value)
}

#' Define a Launcher Resource Limit
#'
#' Define a launcher resource limit, suitable for use with the `resourceLimits`
#' argument to [launcherSubmitJob()].
#'
#' @param type The resource limit type. Must be one of cpuCount, cpuFrequency,
#'   cpuSet, cpuTime, memory, memorySwap. Different launcher plugins may support
#'   different subsets of these resource limit types; please consult the plugin
#'   documentation to learn which limits are supported.
#' @param value The formatted value of the requested limit.
#'
#' @family job submission
#' @export
launcherResourceLimit <- function(type, value) {
  callLauncherFun("launcher.newResourceLimit")
}

#' Define a Launcher Host Mount
#'
#' Define a launcher host mount, suitable for use with the `mounts` argument
#' to [launcherSubmitJob()]. This can be used to mount a path from the host
#' into the generated container.
#'
#' @param path The host path to be mounted.
#' @param mountPath The destination path for the mount in the container.
#' @param readOnly Boolean; should the path be mounted read-only?
#'
#' @family job submission
#' @export
launcherHostMount <- function(path,
                              mountPath,
                              readOnly = TRUE)
{
  callLauncherFun("launcher.newHostMount",
                  path = path,
                  mountPath = mountPath,
                  readOnly = readOnly)
}

#' Define a Launcher NFS Mount
#'
#' Define a launcher NFS mount, suitable for use with the `mounts` argument
#' to [launcherSubmitJob()]. This can be used to mount a path from a
#' networked filesystem into a newly generated container.
#'
#' @param host The host name, or IP address, of the NFS server.
#' @param path The NFS path to be mounted.
#' @param mountPath The destination path for the mount in the container.
#' @param readOnly Boolean; should the path be mounted read-only?
#'
#' @family job submission
#' @export
launcherNfsMount <- function(host,
                             path,
                             mountPath,
                             readOnly = TRUE)
{
  callLauncherFun("launcher.newNfsMount",
                  host = host,
                  path = path,
                  mountPath = mountPath,
                  readOnly = readOnly)
}

#' Submit a Launcher Job
#'
#' Submit a launcher job. See https://docs.rstudio.com/job-launcher/latest/index.html
#' for more information.
#'
#' @param name A descriptive name to assign to the job.
#' @param cluster The name of the cluster this job should be submitted to.
#' @param tags A set of user-defined tags, used for searching and querying
#'   jobs.
#'
#' @param command The command to run within the job. This is executed via the
#'   system shell. Only one of command or exe should be specified.
#' @param exe The (fully pathed) executable to run within the job. Only one of
#'   `command` or `exe` should be specified.
#' @param args An array of arguments to pass to the command / executable.
#' @param environment A list of environment variables to be set for processes
#'   launched with this job.
#' @param stdin Data to be written to stdin when the job process is launched.
#' @param stdoutFile The file used for the job's generated standard output. Not
#'   all launcher plugins support this parameter.
#' @param stderrFile The file used for the job's generated standard error. Not
#'   all launcher plugins support this parameter.
#' @param workingDirectory The working directory to be used by the command /
#'   executable associated with this job.
#'
#' @param host The host that the job is running on, or the desired host during
#'   job submission.
#' @param container The container to be used for launched jobs.
#' @param exposedPorts The ports that are exposed by services running on a
#'   container. Only applicable to systems that support containers.
#' @param mounts A list of mount points. See [launcherHostMount()] and
#'   [launcherNfsMount()] for more information.
#' @param placementConstraints A list of placement constraints. See
#'   [launcherPlacementConstraint()] for more information.
#' @param resourceLimits A list of resource limits. See [launcherResourceLimit()]
#'   for more information.
#' @param queues A list of available submission queues for the cluster. Only
#'   applicable to batch systems like LSF.
#'
#' @param config A list of cluster-specific configuration options. See
#'   [launcherConfig()] for more information.
#' @param user The user-name of the job owner.
#'
#' @param applyConfigSettings Apply server-configured mounts, exposedPorts, and
#'   environment, in addition to any specified in this call.
#'
#' @family job submission
#' @export
launcherSubmitJob <- function(name,
                              cluster = "Local",
                              tags = NULL,

                              command = NULL,
                              exe = NULL,
                              args = NULL,
                              environment = NULL,
                              stdin = NULL,
                              stdoutFile = NULL,
                              stderrFile = NULL,
                              workingDirectory = NULL,

                              host = NULL,
                              container = NULL,
                              exposedPorts = NULL,
                              mounts = NULL,
                              placementConstraints = NULL,
                              resourceLimits = NULL,
                              queues = NULL,

                              config = NULL,
                              user = Sys.getenv("USER"),

                              applyConfigSettings = TRUE)
{
  callLauncherFun("launcher.submitJob",
                  args = args,
                  cluster = cluster,
                  command = command,
                  config = config,
                  container = container,
                  environment = environment,
                  exe = exe,
                  exposedPorts = exposedPorts,
                  host = host,
                  mounts = mounts,
                  name = name,
                  placementConstraints = placementConstraints,
                  queues = queues,
                  resourceLimits = resourceLimits,
                  stderrFile = stderrFile,
                  stdin = stdin,
                  stdoutFile = stdoutFile,
                  tags = tags,
                  user = user,
                  workingDirectory = workingDirectory,
                  applyConfigSettings = applyConfigSettings)
}

#' Execute an R Script as a Launcher Job
#'
#' Convenience function for running an R script as a launcher job using whichever
#' R is found on the path in the launcher cluster.
#'
#' See [launcherSubmitJob()] for running jobs with full control over command,
#' environment, and so forth.
#'
#' @param script Fully qualified path of R script. Must be a path that is
#'   available in the job container (if using containerized job cluster such as Kubernetes).
#' @param cluster The name of the cluster this job should be submitted to.
#' @param container The container to be used for launched jobs.
#'
#' @family job submission
#' @export
launcherSubmitR <- function(script,
                            cluster = "Local",
                            container = NULL)
{
  # don't proactively check for existence of the script; possible the supplied
  # path only resolves correctly in the job cluster
  scriptPath <- path.expand(script)
  scriptFile <- basename(scriptPath)
  scriptArg <- paste("-f", scriptPath)
  jobTag <- paste("rstudio-r-script-job", scriptFile, sep = ":")
  callLauncherFun("launcher.submitJob",
                  args = c("--slave", "--no-save", "--no-restore", scriptArg),
                  cluster = cluster,
                  command = "R",
                  container = container,
                  name = scriptFile,
                  tags = c(jobTag),
                  applyConfigSettings = TRUE)
}

#' Interact with (Control) a Job
#'
#' Interact with a job.
#'
#' @param jobId The job id.
#' @param operation The operation to execute. The operation should be one of
#'   `c("suspend", "resume", "stop", "kill", "cancel")`. Note that different
#'   launcher plugins support different subsets of these operations -- consult
#'   your launcher plugin documentation to see which operations are supported.
#'
#' @export
launcherControlJob <- function(jobId,
                               operation = c("suspend", "resume", "stop", "kill", "cancel"))
{
  callLauncherFun("launcher.controlJob",
                  jobId = jobId,
                  operation = operation)
}
