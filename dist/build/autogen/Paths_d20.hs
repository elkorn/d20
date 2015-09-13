module Paths_d20 (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/elkorn/.cabal/bin"
libdir     = "/home/elkorn/.cabal/lib/x86_64-linux-ghc-7.10.1/d20_JspbrsyxItGFVyoVR8jD5B"
datadir    = "/home/elkorn/.cabal/share/x86_64-linux-ghc-7.10.1/d20-0.1.0.0"
libexecdir = "/home/elkorn/.cabal/libexec"
sysconfdir = "/home/elkorn/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "d20_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "d20_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "d20_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "d20_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "d20_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
