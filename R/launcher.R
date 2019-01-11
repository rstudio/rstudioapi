launcherGetInfo <- function() {
  callFun("launcher.getInfo")
}

launcherAvailable <- function() {
  callFun("launcher.jobsFeatureAvailable")
}

launcherGetJobs <- function(statuses = NULL,
                            fields = NULL,
                            includeSessions = FALSE)
{
  callFun("launcher.getJobs",
          statuses = statuses,
          fields = fields,
          includeSessions = includeSessions)
}

launcherGetJob <- function(jobId) {
  callFun("launcher.getJob",
          jobId = jobId)
}

launcherNewContainer <- function(image,
                                 runAsUserId = NULL,
                                 runAsGroupId = NULL)
{
  callFun("launcher.new_Container",
          image = image,
          runAsUserId = runAsUserId,
          runAsGroupId = runAsGroupId)
}

launcherNewHostMount <- function(path,
                                 mountPath,
                                 readOnly = TRUE)
{
  callFun("launcher.new_HostMount",
          path = path,
          mountPath = mountPath,
          readOnly = readOnly)
}

launcherNewNfsMount <- function(host,
                                path,
                                mountPath,
                                readOnly = TRUE)
{
  callFun("launcher.new_NfsMount",
          host = host,
          path = path,
          mountPath = mountPath,
          readOnly = readOnly)
}

# TODO: Copy over not-yet-implemented parameters when ready.
launcherSubmitJob <- function(args = NULL,
                              cluster = "Local",
                              command = NULL,
                              container = NULL,
                              environment = NULL,
                              exe = NULL,
                              exposedPorts = NULL,
                              host = NULL,
                              mounts = NULL,
                              name,
                              stderrFile = NULL,
                              stdin = NULL,
                              stdoutFile = NULL,
                              tags = NULL,
                              user = Sys.getenv("USER"),
                              workingDirectory = NULL)
{
  callFun("launcher.submitJob",
          args = args,
          cluster = cluster,
          command = command,
          container = container,
          environment = environment,
          exe = exe,
          exposedPorts = exposedPorts,
          host = host,
          mounts = mounts,
          name = name,
          stderrFile = stderrFile,
          stdin = stdin,
          stdoutFile = stdoutFile,
          tags = tags,
          user = user,
          workingDirectory = workingDirectory)
}

launcherControlJob <- function(jobId, operation) {
  callFun("launcher.controlJob",
          jobId = jobId,
          operation = operation)
}

launcherStartStatusStream <- function(jobId = "*") {
  callFun("launcher.startStatusStream",
          jobId = jobId)
}

launcherStopStatusStream <- function(jobId = "*") {
  callFun("launcher.stopStatusStream",
          jobId = jobId)
}

launcherStreamOutput <- function(jobId, listening) {
  callFun("launcher.streamOutput",
          jobId = jobId,
          listening = listening)
}
