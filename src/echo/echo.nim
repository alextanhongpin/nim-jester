import jester
import json
import service, repo
import db_mysql

type EchoController* = ref object
  svc: EchoService

proc newEchoController*(conn: DbConn): EchoController =
  new result
  let repo = newEchoRepository(conn)
  result.svc = newEchoService(repo)

proc setup*(ctrl: EchoController) =
  routes:
    get "/":
      resp "Hello world"
    post "/":
      # Getting query string
      # echo @"name"
      let req = parseJson(request.body)
      resp %*{"sum": ctrl.svc.getSum(req["a"].getInt(0))}

