module Main where

import System.Directory (doesPathExist)

main :: IO ()
main = do
    vpnRunning <- doesPathExist "/proc/sys/net/ipv4/conf/tun0"
    putStrLn (if vpnRunning then vpnIcon else "")
  where
    vpnIcon :: String
    vpnIcon = "\xf023"
