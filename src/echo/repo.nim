import db_mysql
import strutils

type EchoRepository* = ref object
    conn*: DbConn

proc newEchoRepository* (conn: DbConn): EchoRepository =
  new result
  result.conn = conn

proc getSum*(repo: EchoRepository): int =
  result = parseInt(repo.conn.getValue(sql"SELECT 1 + 1"))

