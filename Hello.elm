import List
import Signal
import Time
import Time (Time)
import Html (..)
import Html.Events (..)
import Cycler
import Cycler (Cycler)


main : Signal Html
main = Signal.map view state


hellos =
  [ "Hello World"
  , "Hola Mundo"
  , "Bonjour tout le Monde"
  , "Hallo Welt"
  ]
  
cycleDelay = 2500
cycleFps = 10 / (cycleDelay / 1000)

type Update = NoOp | Tick Time | Next

type alias State = 
  { time : Time
  , cycler : Cycler String
  }

step : Update -> State -> State
step u s =
  let next s' = { initState | cycler <- Cycler.next s'.cycler }
      nextIf s' = if s'.time >= cycleDelay then (next s') else s'
  in 
      case u of
        NoOp -> s
        Tick dt -> nextIf { s | time <- (s.time + dt) }
        Next -> next s

view : State -> Html
view s = 
  h1 [ onClick (Signal.send updateChannel Next) ]
    [ text (Cycler.value s.cycler) ]

initState = { time = 0, cycler = Cycler.new hellos }

updateChannel : Signal.Channel Update
updateChannel = Signal.channel NoOp

updates : Signal Update
updates = 
  Signal.merge
    (Signal.map (\dt -> Tick dt) (Time.fps cycleFps))
    (Signal.subscribe updateChannel)

state : Signal State
state = Signal.foldp step initState updates
