# OCGoogleDirectionsAPI CHANGELOG

## 0.1.7

- Resolved #10 by adding factory method to return initialised instance of NSURLSessionDataTask (thanks @markst)

## 0.1.6

- Fix #9 by encoding request attribute separator.

## 0.1.5

- Added scripts to build and run tests (Bin/run-build.sh, Bin/run-tests.sh)
- Added fare and duration_in_traffic to response
- Added transit_mode, transit_routing_preference, traffic_model, arrival_time,
departure_time to request

## 0.1.2

- Fixed copy-paste error of kCGGoogleDirectionsResponseAttributeBounds. (thanks @djmadcat)

## 0.1.1

- Fixed init method to initialise locationString property properly.
- Fixed missing summary parsing. (thanks @DmitryPR)

## 0.1.0

Initial release.
