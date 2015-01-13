import List
import Signal
import Graphics.Element (..)
import Text (..)
import Time
import Cycler


main : Signal Element
main =
  Signal.map plainText (toCycle hellos (Time.every 1500))


hellos =
  [ "Hello World"
  , "Hola Mundo"
  , "Bonjour tout le Monde"
  , "Hallo Welt"
  ]

toCycle : List a -> Signal b -> Signal a
toCycle items sampler = 
  sampler
  |> Signal.foldp (\_ acc -> Cycler.next acc) (Cycler.new items)
  |> Signal.map Cycler.value
