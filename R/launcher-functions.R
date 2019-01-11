
launcherGetInfo <- function() {
  callLauncherFun("launcher.getInfo")
}

launcherAvailable <- function() {
  callLauncherFun("launcher.jobsFeatureAvailable")
}

launcherGetJobs <- function(statuses = NULL,
                            fields = NULL,
                            includeSessions = FALSE)
{
  callLauncherFun("launcher.getJobs",
                  statuses = statuses,
                  fields = fields,
                  includeSessions = includeSessions)
}

launcherGetJob <- function(jobId) {
  callLauncherFun("launcher.getJob",
                  jobId = jobId)
}

launcherNewConfig <- function(name,
                              value = NULL,
                              valueType = NULL)
{
  callLauncherFun("launcher.new_Config",
                  name = name,
                  value = value,
                  valueType = valueType)
}

launcherNewContainer <- function(image,
                                 runAsUserId = NULL,
                                 runAsGroupId = NULL)
{
  callLauncherFun("launcher.new_Container",
                  image = image,
                  runAsUserId = runAsUserId,
                  runAsGroupId = runAsGroupId)
}

launcherNewPlacementConstraint <- function(name,
                                           value = NULL)
{
  callLauncherFun("launcher.new_PlacementConstraint",
                  name = name,
                  value = value)
}

launcherNewResourceLimit <- function(type, value) {
  callLauncherFun("launcher.new_resourceLimit")
}

launcherNewHostMount <- function(path,
                                 mountPath,
                                 readOnly = TRUE)
{
  callLauncherFun("launcher.new_HostMount",
                  path = path,
                  mountPath = mountPath,
                  readOnly = readOnly)
}

launcherNewNfsMount <- function(host,
                                path,
                                mountPath,
                                readOnly = TRUE)
{
  callLauncherFun("launcher.new_NfsMount",
                  host = host,
                  path = path,
                  mountPath = mountPath,
                  readOnly = readOnly)
}

launcherSubmitJob <- function(args = NULL,
                              cluster = "Local",
                              command = NULL,
                              config = NULL,
                              container = NULL,
                              environment = NULL,
                              exe = NULL,
                              exposedPorts = NULL,
                              host = NULL,
                              mounts = NULL,
                              name,
                              placementConstraints = NULL,
                              queues = NULL,
                              resourceLimits = NULL,
                              stderrFile = NULL,
                              stdin = NULL,
                              stdoutFile = NULL,
                              tags = NULL,
                              user = Sys.getenv("USER"),
                              workingDirectory = NULL)
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
                  workingDirectory = workingDirectory)
}

launcherControlJob <- function(jobId, operation) {
  callLauncherFun("launcher.controlJob",
                  jobId = jobId,
                  operation = operation)
}

launcherStartStatusStream <- function(jobId = "*") {
  callLauncherFun("launcher.startStatusStream",
                  jobId = jobId)
}

launcherStopStatusStream <- function(jobId = "*") {
  callLauncherFun("launcher.stopStatusStream",
                  jobId = jobId)
}

launcherStreamOutput <- function(jobId, listening) {
  callLauncherFun("launcher.streamOutput",
                  jobId = jobId,
                  listening = listening)
}
