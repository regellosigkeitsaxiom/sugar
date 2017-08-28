module Sugar exposing (..)

import Json.Decode
import Platform.Cmd
import Html
import Debug exposing ( log )
import Svg as S
import Svg.Attributes as A

place : Int -> Int -> S.Svg a -> S.Svg a
place x y s = S.g
  [ A.x ? x
  , A.y ? y
  , A.transform <| "translate(" ++ æ x ++ "," ++ æ y ++ ")"
  ] [ s ]

(:=) = Json.Decode.field

(:?) field value = Json.Decode.maybe ( field := value )

(?) f x = f ( toString x )
infixr 0 ?

(?!) f x = f <| fixDot <| toString ( toFloat ( round (x*100)) / 100 )
infixr 0 ?!

(?-) f x = if x >= 0
  then f <| fixDot <| "+ " ++ toString ( abs <| toFloat ( round (x*100)) / 100 )
  else f <| fixDot <| "– " ++ toString ( abs <| toFloat ( round (x*100)) / 100 )
infixr 0 ?-

fixDot : String -> String
fixDot = String.map (\x -> if x == '.' then ',' else x)

lift : ( a -> aa ) -> ( b -> bb ) -> ( a, Cmd b ) -> ( aa, Cmd bb )
lift fmodel fcmd (model,cmd) = ( fmodel model, Platform.Cmd.map fcmd cmd )

(<$>) = Platform.Cmd.map
infixr 0 <$>

(<*>) = Html.map
infixr 0 <*>

ß = toFloat
æ = toString
o_O = log "o_O"

($) = (<|)
infixr 0 $
