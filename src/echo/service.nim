import repo

type EchoService* = ref object
    repo: EchoRepository

proc newEchoService*(repo: EchoRepository): EchoService =
   new result
   result.repo = repo

proc getSum*(svc: EchoService, req: int): int =
  let sum = svc.repo.getSum()
  result = sum + req
