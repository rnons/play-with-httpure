module Main where

import Prelude

import Data.Foldable (for_)
import Effect.Console as Console
import HTTPure as HTTPure
import Text.Smolder.HTML as H
import Text.Smolder.HTML.Attributes as HA
import Text.Smolder.Markup ((!), text)
import Text.Smolder.Renderer.String (render)

type Tab =
  { id :: Int
  , text :: String
  }

type Html = H.Html Unit

tabs :: Array Tab
tabs =
  [ { id: 1
    , text: "Home"
    }
  , { id: 2
    , text: "About"
    }
  ]

renderTab :: Html
renderTab =
  H.div $ do
    H.ul $
      for_ tabs \tab ->
        H.li $ text tab.text
    when true $
      H.p
      ! HA.className "cls"
      ! HA.style "color: blue"
      $ text "visible content"
    when false $
      H.p $ text "invisible content"

homepage :: Html
homepage = H.html ! HA.lang "en" $ do
  renderTab

router :: HTTPure.Request -> HTTPure.ResponseM
router { path: [] }   =
  HTTPure.ok $ render homepage
router { path: [ "hello" ] }   = HTTPure.ok "hello"
router _                       = HTTPure.notFound

-- | Boot up the server
main :: HTTPure.ServerM
main = HTTPure.serve 8080 router do
  Console.log $ "Server now up on port 8080"
