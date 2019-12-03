-- |
-- Solves problem 1 of https://adventofcode.com/2019
--
--------------------------------------------------------------------------------
module AOC.Problem1 where

import Data.Foldable (traverse_)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T

readNumbers :: IO [Int]
readNumbers = do
  fileText <- T.readFile "src/AOC/problem1_input.txt"
  let
    newline :: Text
    newline = T.pack "\n"
    numbers :: [Int]
    numbers = read
            . T.unpack
            <$> filter (\x -> x /= T.pack "") (T.splitOn newline fileText)
  pure numbers

calculate :: Int -> Int
calculate x = div x 3 - 2

solve :: IO ()
solve = print =<< sum . fmap calculate <$> readNumbers
