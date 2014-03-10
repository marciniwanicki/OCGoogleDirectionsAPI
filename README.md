---

<b>Not finished yet!</b>

---

# OCGoogleDirectionsAPI
[![Build Status](https://travis-ci.org/marciniwanicki/OCGoogleDirectionsAPI.png?branch=master)](https://travis-ci.org/marciniwanicki/OCGoogleDirectionsAPI) 

A lightweight wrapper for The Google Directions API. See the [Google Maps API Web Services documentation](https://developers.google.com/maps/documentation/directions/).

As Google wrote:
<i>"The Google Directions API is a service that calculates directions between locations using an HTTP request. You can search for directions for several modes of transportation, include transit, driving, walking or cycling. Directions may specify origins, destinations and waypoints either as text strings (e.g. "Chicago, IL" or "Darwin, NT, Australia") or as latitude/longitude coordinates. The Directions API can return multi-part directions using a series of waypoints."</i>


# 0.1.0

The OCGoogleDirectionsAPI library allows your iOS apps to deal with this powerful service easily. <b>IMPORTANT:</b> It uses `NSURLSession` only available in iOS 7.0+. It is <b>not compatible with iOS 6.x and lower</b>.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is the dependency manager for Objective-C projects. It has thousands of libraries and can help you scale your projects elegantly.

#### Podfile
```ruby
platform :ios, '7.0'
pod "OCGoogleDirectionsAPI", "~> 0.1.0"
```

## How to get started

It's really simple. To get directions you need to do <b>4 easy steps</b>.

1. Importing headers. From now all `OCDirections*` general class will be accessible for you.

    ```objc
    #import <OCGoogleDirectionsAPI/OCGoogleDirectionsAPI.h>
    ````
 
2. Secondly you must provide your Google API Key. The method `application:didFinishLaunchingWithOptions:` in AppDelegate seams to be a good place for this code.

   ```objc
   [OCDirectionsAPIClient provideAPIKey:@"<YOUR KEY>"];
   ```

3. Prepare `OCDirectionsRequest` object to specify all data you want to retrieve from the service.

   ```objc
   OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"<ORIGIN>" andDestinationString:@"<DESTINATION>" sensor:NO];
   ```

4. Call `directions` method to retrieve required data (`OCDirectionsResponse`) asynchronously.


That's all! It's quite easy, isn't it? If you like to specify more and more your queries please read the next section [OCDirectionsRequest](#ocdirectionsrequest).

## OCDirectionsRequest

### Creating an instance

To create an isntance of `OCDirectionsRequest` you can use one of the following factory methods.

```objc
+ (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationLocation:(CLLocation *)destination sensor:(BOOL)sensor;

+ (instancetype)requestWithOriginString:(NSString *)origin andDestinationLocation:(CLLocation *)destination sensor:(BOOL)sensor;

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationString:(NSString *)destination sensor:(BOOL)sensor;

+ (instancetype)requestWithOriginString:(NSString *)origin andDestinationString:(NSString *)destination sensor:(BOOL)sensor;
```

### Request attributes

To read more about available attributes please see the [Request parameters](https://developers.google.com/maps/documentation/directions/#RequestParameters) page.

#### Alternatives
```objc
[request setAlternatives:YES];
```

#### Region
```objc
[request setRegion:@"pl"];
```

#### Restrictions

There are 3 restrictions:
```objc
OCDirectionsRequestRestrictionAvoidTolls,
OCDirectionsRequestRestrictionAvoidHighways,
OCDirectionsRequestRestrictionAviodFerries
```

You can ask to avoid one or even all of them by calling the `setRestrictions:` method.
```objc
[request setRestrictions:@[@(OCDirectionsRequestRestrictionAvoidTolls), @(OCDirectionsRequestRestrictionAviodFerries)];
```


#### Travel mode

The API allows to choose one of the following travel modes
```objc
OCDirectionsRequestTravelModeDriving,
OCDirectionsRequestTravelModeWalking,
OCDirectionsRequestTravelModeBicycling,
OCDirectionsRequestTravelModeTransit
```

and setter
```objc
[request setTravelMode:@(OCDirectionsRequestTravelModeBicycling)];
```

### Unit

Available units
```objc
OCDirectionsRequestUnitDefault,
OCDirectionsRequestUnitMetric,
OCDirectionsRequestUnitImperial
```

and setter
```objc
[request setUnit:@(OCDirectionsRequestUnitMetric)];
```

### Waypoints

You need to set `NSArray` of `NSString` and `CLLocation` objects
```objc
CLLocation *firstLocation = [[CLLocation alloc] initWithLatitude:51.2314 longitude:21.3243];
CLLocation *secondLocation = [[CLLocation alloc] initWithLatitude:51.1314 longitude:21.1321];
[request setWaypoints:@[@"London", firstLocation, "Reading", secondLocation]];
```

### Waypoints optimise

```objc
[request setWaypointsOptimise:YES];
```


## Response

Classes:
* [OCDirectionsResponse](#OCDirectionsResponse)
* [OCDirectionsRoute](#OCDirectionsRoute)
* [OCDirectionsLeg](#OCDirectionsLeg)


### OCDirectionsResponse

Properties

* dictionary `NSDictionary*`
* status `OCDirectionsResponseStatus`
* routes `NSArray*` (`NSArray` of `OCDirectionsRoute*`)
* errorMessage `NSString*`
* route `NSDirectionsRoute*`

### OCDirectionsRoute

Properties

* dictionary `NSDictionary*`
* legs `NSArray*` (`NSArray` of `OCDirectionsLeg*`)
* copyrights `NSString*`
* warnings `NSArray*` (`NSArray` of `NSString*`)
* waypointOrder `NSArray*` (`NSArray` of `NSNumber*`)
* overviewPolyline `OCDirectionsPolyline*`
* bounds `OCDirectionsBounds*`
* summary `NSString*`

### OCDirectionsLeg

Properties


## Contact

Did you find a bug? Do you have great ideas how to make the library better? or you just want to say hello... please do not hesitate to mail me at marcin.iwanicki [at] live.com.

## To Do

* Add samples.
* Write unit tests.
* Implement releasing dictionary object when the response tree is fully initialised.

## License

OCGoogleDirectionsAPI is available under the MIT license. See the LICENSE file for more info.
