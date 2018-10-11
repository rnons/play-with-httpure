module Item where

import Prelude

import Text.Smolder.HTML as H
import Text.Smolder.Markup (text)

type Html a = H.Html a

type Item =
  { id :: Int
  , text :: String
  }

render :: forall a. Item -> Html a
render item = H.div $ text item.text
