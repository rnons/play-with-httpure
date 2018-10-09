module Main where

import Prelude

import Effect.Console as Console
import HTTPure as HTTPure
import Data.TemplateString.Unsafe ((<~>))

renderTab :: Int -> String
renderTab n = "Tab: " <> show n

type IndexContext =
  { tab :: String
  }

renderIndex :: IndexContext -> String
renderIndex = (<~>) """
index page
${tab}
"""

router :: HTTPure.Request -> HTTPure.ResponseM
router { path: [] }   =
  HTTPure.ok $ renderIndex { tab: renderTab 1 }
router { path: [ "hello" ] }   = HTTPure.ok "hello"
router _                       = HTTPure.notFound

-- | Boot up the server
main :: HTTPure.ServerM
main = HTTPure.serve 8080 router do
  Console.log $ "Server now up on port 8080"
