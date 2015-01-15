import List
import Signal
import Time
import Html (..)
import Cycler


main : Signal Html
main = Signal.map view state


hellos =
  [ "Hello World"
  , "Hola Mundo"
  , "Bonjour tout le Monde"
  , "Hallo Welt"
  ]

type Update = NoOp | Next

type alias State = Cycler.Cycler String

step : Update -> State -> State
step u s =
  case u of
    NoOp -> s
    Next -> Cycler.next s

view : State -> Html
view s = text (Cycler.value s)

initState = Cycler.new hellos

updates : Signal Update
updates = Signal.map (\_ -> Next) (Time.every 1500)

state : Signal State
state = Signal.foldp step initState updates
