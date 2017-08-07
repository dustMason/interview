# Tic Tac Toe

A simple Tic Tac Toe game, playable by two players in a terminal. See `ai.rb`
for a simple AI opponent.

## Playing

```ruby
$ ruby main.rb
```

The 3x3 grid of left-most letter keys corresponds to the squares of the game
board:

```
q | w | e
--+---+--
a | s | d
--+---+--
z | x | c
```

Press the corresponding key to place your mark. Press `p` to quit.

## MinMax AI

This AI uses a [minmax](https://en.wikipedia.org/wiki/Minimax) algorithm to
evaluate all possible future states of the game. It executes the first move that
leads to the "best" result (a win in as few moves as possible). It assumes the
opponent plays with the same strategy, so each possible future game state
follows from the opponent's best possible moves.

As a brute-force solution, it is not very efficient, but the problem space of
Tic Tac Toe is small enough to make this suitable. Because it exhaustively
explores all possible states it is guaranteed to play perfectly.

## Lightweight AI

Another successful AI strategy exists that could power an optimized algorithm.
It should follow these simple rules:

- If there's a move that results in a win, take it 
- Else if there's a move that prevents the opponent from immediately winning, take it
- Else if the center square is open, take it
- Else if any corner squares are open, take one of them at random
- Else take an available edge square at random

## Problem Space

See [relevant xkcd](https://xkcd.com/832/) for a beautiful visualization of the
tree of optimal moves.
