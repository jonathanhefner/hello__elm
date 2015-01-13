module Cycler where

import List


type alias Cycler a = (List a, List a)

new : List a -> Cycler a
new items = (items, items)

next : Cycler a -> Cycler a
next cycler =
  case cycler of
    ([], full) -> (full, full)
    (hd::[], full) -> (full, full)
    (hd::tl, full) -> (tl, full)
    
value : Cycler a -> a
value cycler = 
  case cycler of
    ([], hd::_) -> hd
    (hd::_, _) -> hd
