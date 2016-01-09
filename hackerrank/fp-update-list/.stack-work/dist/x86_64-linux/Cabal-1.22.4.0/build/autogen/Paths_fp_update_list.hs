module Paths_fp_update_list (
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

bindir     = "/home/pascal/Projects/algorithms/hackerrank/fp-update-list/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/bin"
libdir     = "/home/pascal/Projects/algorithms/hackerrank/fp-update-list/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/lib/x86_64-linux-ghc-7.10.2/fp-update-list-0.1.0.0-FVp5QmWA5gK7rfv2XvT6zg"
datadir    = "/home/pascal/Projects/algorithms/hackerrank/fp-update-list/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/share/x86_64-linux-ghc-7.10.2/fp-update-list-0.1.0.0"
libexecdir = "/home/pascal/Projects/algorithms/hackerrank/fp-update-list/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/libexec"
sysconfdir = "/home/pascal/Projects/algorithms/hackerrank/fp-update-list/.stack-work/install/x86_64-linux/lts-3.9/7.10.2/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "fp_update_list_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "fp_update_list_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "fp_update_list_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "fp_update_list_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "fp_update_list_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
