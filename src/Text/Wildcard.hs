module Text.Wildcard (match) where


import Data.List (isPrefixOf)


-- |
-- 
-- Whether the string matches the wildcard expression.
-- '?' matches any single charactor. e.g. "hoge" `match` "ho?e" -> True
-- '*' matches any characotr. e.g. "hoge" `match` "h*e" -> True
-- >>> "hoge" `match` "*og*"
-- True
-- >>> "hoge" `match` "ho"
-- False
-- >>> "hoge" `match` "hog?"
-- True
-- >>> "hoge" `match` "hig?"
-- False
match :: String -> String -> Bool
match "" "" = True
match _ "*" = True
match _ ""  = False
match "" xs = all (=='*') xs
match
  str@(x:xs)
  wild@(y:ys)
  | str == wild      = True
  | all (=='*') wild = True
  | x == y           = match xs ys
  | y == '?'         = match xs ys
  | idTrue           = True
  | y == '*'         = isSubstring && match tailX tailY
  | otherwise        = False
  where
    idTrue = let (a, b) = break (=='?') wild in all (=='*') a && b == "?"
    (headY, tailY) = break (\c -> c=='*' || c=='?') $ dropWhile (=='*') ys
    (tailX, isSubstring) = headY `isSubStringOf` str

isSubStringOf :: String -> String -> (String, Bool)
x `isSubStringOf` y
  | length y >= length x = if x `isPrefixOf` y then
                               (drop (length x) y, True)
                           else
                               x `isSubStringOf` tail y
  | otherwise            = ("", False)
