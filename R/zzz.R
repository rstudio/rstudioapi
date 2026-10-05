.onLoad <- function(libname, pkgname) {

  # take the IPC secret out of the environment, so that processes spawned by
  # an RStudio job don't inherit the ability to call back into the IDE
  secret <- Sys.getenv("RSTUDIOAPI_IPC_SHARED_SECRET", unset = NA)
  if (!is.na(secret)) {
    options(rstudioapi.ipc.secret = secret)
    Sys.unsetenv("RSTUDIOAPI_IPC_SHARED_SECRET")
  }

}
