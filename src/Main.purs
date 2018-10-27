module Main where

import Prelude

import Control.Monad.Except as Except
import Effect.Aff as Aff
import Effect.Console as Console
import Effect.Exception as Exception
import HTTPure as HTTPure

router :: HTTPure.Request -> HTTPure.ResponseM
router { path: [] }   = do
  void $ Aff.throwError $ Aff.error "test"
  HTTPure.ok "homepage"
  -- Except.throwError $ Exception.error "fail!"
router _                       = HTTPure.notFound

-- | Boot up the server
main :: HTTPure.ServerM
main = HTTPure.serve 8080 router do
  Console.log $ "Server now up on port 8080"
