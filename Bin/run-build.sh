#!/bin/bash
if [ ! -d Source ]; then
  cd ..
fi
cd Source
xctool build -project OCGoogleDirectionsAPI.xcodeproj -scheme OCGoogleDirectionsAPI -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO
