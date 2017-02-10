#!/usr/bin/env bash
set -e
FullExecPath=$PWD
pushd `dirname $0` > /dev/null
FullScriptPath=`pwd`
popd > /dev/null

MySystem=`uname -s`
cd $FullScriptPath

if [ "$MySystem" == "Linux" ]; then
  ../../../Libraries/gyp/gyp --depth=. --generator-output=../.. -Goutput_dir=out Telegram.gyp --format=cmake
  cd ../../out/Debug
  cmake .
  cd ../Release
  cmake .
  cd ../../Telegram/gyp
else
  #gyp --depth=. --generator-output=../.. -Goutput_dir=out Telegram.gyp --format=ninja
  #gyp --depth=. --generator-output=../.. -Goutput_dir=out Telegram.gyp --format=xcode-ninja
  #gyp --depth=. --generator-output=../.. -Goutput_dir=out Telegram.gyp --format=xcode
  # use patched gyp with Xcode project generator
  ../../../Libraries/gyp/gyp --depth=. --generator-output=../.. -Goutput_dir=out Telegram.gyp -Gxcode_upgrade_check_project_version=820 --format=xcode
fi

cd ../..

cd $FullExecPath
exit

