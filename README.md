wildcard
========

Wildcard pattern match in Haskell

Usage
------------

* '*' matches any characters.
* '?' matches any one character.

example

    "hoge" `match` "*og*" -- True
    "hoge" `match` "h*g*" -- True
    "hoge" `match` "ho*a"   -- False

　　"hoge" `match` "hog?" -- True
    "hoge" `match` "hig?" -- False
