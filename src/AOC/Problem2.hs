-- |
-- Solves problem 2 of https://adventofcode.com/2019
--
--------------------------------------------------------------------------------
module AOC.Problem2 (solveP2) where

import Data.Foldable (traverse_)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Data.Vector (Vector, (!), (//))
import qualified Data.Vector as V
import Control.Monad.State (State)
import qualified Control.Monad.State as S

readInput :: IO (Vector Int)
readInput = do
  fileText <- T.readFile "src/AOC/problem2_input.txt"
  let
    numbers :: Vector Int
    numbers = V.fromList
            . fmap (read . T.unpack)
            . T.splitOn (T.pack ",")
            . mconcat
            $ T.lines fileText
  pure numbers

preprocessCodes :: Vector Int -> Vector Int
preprocessCodes codes = codes // [(1, 12), (2, 2)]

interpretOpCode :: Int -> Vector Int -> Vector Int
interpretOpCode idx codes
  | codes ! idx == 1 = interpretOpCode nextOp (codes // [(resLoc, arg1 + arg2)])
  | codes ! idx == 2 = interpretOpCode nextOp (codes // [(resLoc, arg1 * arg2)])
  | codes ! idx == 99 = codes
  where
    nextOp = idx + 4
    arg1   = codes ! (codes ! (idx + 1))
    arg2   = codes ! (codes ! (idx + 2))
    resLoc = codes ! (idx + 3)

solveP2 :: IO ()
solveP2
  = print
  . flip V.unsafeIndex 0
  . interpretOpCode 0
  . preprocessCodes
  =<< readInput
