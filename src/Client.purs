module Client where

import Prelude

import Data.Foldable (traverse_)
import Effect (Effect)
import Effect.Console as Console
import Item as Item
import Text.Smolder.HTML as H
import Text.Smolder.Markup (text, (!))
import Text.Smolder.Renderer.DOM as DOM
import Text.Smolder.SVG as Svg
import Text.Smolder.SVG.Attributes as SvgA
import Web.DOM.Document (createElement)
import Web.DOM.Element as Element
import Web.DOM.Node (appendChild)
import Web.HTML (window)
import Web.HTML.HTMLDocument as HTMLDocument
import Web.HTML.HTMLElement as HTMLElement
import Web.HTML.Window as Window

type Html a = H.Html a

view :: forall a. Html a
view = Item.render { id: 2, text: "item from frontend" }

icon :: forall a. Html a
icon = Svg.svg $ do
  Svg.path
    ! SvgA.d "M9.5 3L8 4.5 11.5 8 8 11.5 9.5 13 14 8 9.5 3zm-5 0L0 8l4.5 5L6 11.5 2.5 8 6 4.5 4.5 3z"
    $ text ""

main :: Effect Unit
main = do
  Console.log "hello world"
  htmlDocument <- window >>= Window.document
  let doc = HTMLDocument.toDocument htmlDocument
  el <- createElement "div" doc
  HTMLDocument.body htmlDocument >>= traverse_ \body -> do
    void $ appendChild (Element.toNode el) (HTMLElement.toNode body)
    DOM.render el view
    DOM.render el icon
