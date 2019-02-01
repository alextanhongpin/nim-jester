# Hello Nim!
import jester, posix

onSignal(SIGINT, SIGTERM):
  ## Handle SIGABRT from systemd
  # Lines printed to stdout will be received by systemd and logged
  # Start with "<severity>" from 0 to 7
  echo "<2>Received"
  quit(QuitSuccess)

routes:
  get "/":
    resp "Hello world"
