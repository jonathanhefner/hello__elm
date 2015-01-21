import List
import Signal
import Time
import Time (Time)
import Html (..)
import Html.Events (..)
import Cycler
import Cycler (Cycler)


main : Signal Html
main = Signal.map view model


hellos =
  [ "Hello World"
  , "Hola Mundo"
  , "Bonjour tout le Monde"
  , "Hallo Welt"
  ]
  
cycleDelay = 2500
cycleFps = 10 / (cycleDelay / 1000)

type Action = NoOp | Tick Time | Next

type alias Model = 
  { time : Time
  , cycler : Cycler String
  }

update : Action -> Model -> Model
update action model =
  let next m = { init | cycler <- Cycler.next m.cycler }
      timedNext m = if m.time >= cycleDelay then (next m) else m
  in 
      case action of
        NoOp -> model
        Tick dt -> timedNext { model | time <- (model.time + dt) }
        Next -> next model

view : Model -> Html
view model = 
  h1 [ onClick (Signal.send actionChannel Next) ]
    [ text (Cycler.value model.cycler) ]

init = { time = 0, cycler = Cycler.new hellos }

actionChannel : Signal.Channel Action
actionChannel = Signal.channel NoOp

actions : Signal Action
actions = 
  Signal.merge
    (Signal.map (\dt -> Tick dt) (Time.fps cycleFps))
    (Signal.subscribe actionChannel)

model : Signal Model
model = Signal.foldp update init actions
