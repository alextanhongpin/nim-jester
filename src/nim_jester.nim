# Hello Nim!
import jester, posix
import db_mysql
import ospaths
import json
import strutils

import echo/echo

var db: DbConn

onSignal(SIGINT, SIGTERM):
  ## Handle SIGABRT from systemd
  # Lines printed to stdout will be received by systemd and logged
  # Start with "<severity>" from 0 to 7
  echo "terminating"
  db.close()
  quit(QuitSuccess)


type 
  Config  = ref object
    dbHost: string
    dbUser: string
    dbPass: string
    dbName: string

proc newConfig(): Config =
  new result
  result.dbHost = getEnv("DB_HOST", "127.0.0.1")
  result.dbUser = getEnv("DB_USER", "john")
  result.dbPass = getEnv("DB_PASS", "123456")
  result.dbName = getEnv("DB_NAME", "nim_test")

proc main() =
  let c = newConfig()
  db = open(c.dbHost, c.dbUser, c.dbPass, c.dbName)
  let ctrl = newEchoController(db)
  ctrl.setup()


if isMainModule:
  main()
  runForever()
