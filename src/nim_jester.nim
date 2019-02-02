# Hello Nim!
import jester, posix
import db_mysql
import ospaths

onSignal(SIGINT, SIGTERM):
  ## Handle SIGABRT from systemd
  # Lines printed to stdout will be received by systemd and logged
  # Start with "<severity>" from 0 to 7
  echo "<2>Received"
  quit(QuitSuccess)


type 
  Config  = ref object
    dbHost: string
    dbUser: string
    dbPass: string
    dbName: string

proc newConfig(): Config = 
  var c: Config
  new(c)
  c.dbHost = getEnv("DB_HOST", "127.0.0.1")
  c.dbUser = getEnv("DB_USER", "john")
  c.dbPass = getEnv("DB_PASS", "123456")
  c.dbName = getEnv("DB_NAME", "nim_test")
  return c
  
let c = newConfig()
let db = open(c.dbHost, c.dbUser, c.dbPass, c.dbName)

let result = db.getRow(sql"SELECT 1 + 1")
echo result
db.close()

routes:
  get "/":
    resp "Hello world"

if isMainModule:
  runForever()
