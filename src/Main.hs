module Main where

import Data.List ( findIndex, isPrefixOf, isSuffixOf )
import System.Process ( readCreateProcess, shell )

{-# INLINE monitorExtract #-}
monitorExtract :: String -> Maybe Int
monitorExtract str = let lst = filter ("Output" `isPrefixOf`) . lines $ str
                     in findIndex ("(focused)" `isSuffixOf` ) lst

main = do
  let command = shell "swaymsg -s $SWAYSOCK -t get_outputs -p"
  swayOutput <- readCreateProcess command ""
  case monitorExtract swayOutput of
    Just n -> putStr . show $ n + 1
    Nothing -> putStr "1"
