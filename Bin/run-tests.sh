#!/bin/bash
if [ ! -d Source ]; then
  cd ..
fi
cd Source
xctool test -project OCGoogleDirectionsAPI.xcodeproj -scheme OCGoogleDirectionsAPITests -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO
