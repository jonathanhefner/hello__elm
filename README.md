# Hello World

A [Hello World][1], implemented in Elm.

  [1]: https://en.wikipedia.org/wiki/%22Hello,_world!%22_program


## Prerequisites

* Install the Haskell Platform:

  ```bash
  sudo apt-get install haskell-platform
  ```

* Install Elm 0.14:

  ```bash
  cabal update
  cabal install cabal-install
  cabal install -j elm-compiler-0.14.1 elm-package-0.4 elm-make-0.1.1
  cabal install -j elm-repl-0.4 elm-reactor-0.3
  ```

* Make sure `~/.cabal/bin` is in your PATH variable


## Usage

```bash
cd /path/to/project

elm-reactor
```

Open a web browser and visit http://localhost:8000/hello.elm
