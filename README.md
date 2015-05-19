# OCGoogleDirectionsAPI
[![Build Status](https://travis-ci.org/marciniwanicki/OCGoogleDirectionsAPI.png?branch=master)](https://travis-ci.org/marciniwanicki/OCGoogleDirectionsAPI) 

A lightweight wrapper for The Google Directions API. See the [Google Maps API Web Services documentation](https://developers.google.com/maps/documentation/directions/).

As Google wrote:
<i>"The Google Directions API is a service that calculates directions between locations using an HTTP request. You can search for directions for several modes of transportation, include transit, driving, walking or cycling. Directions may specify origins, destinations and waypoints either as text strings (e.g. "Chicago, IL" or "Darwin, NT, Australia") or as latitude/longitude coordinates. The Directions API can return multi-part directions using a series of waypoints."</i>


# 0.1.4

The OCGoogleDirectionsAPI library allows your iOS apps to deal with this powerful service easily. <b>IMPORTANT:</b> It uses `NSURLSession` only available in iOS 7.0+. It is <b>not compatible with iOS 6.x and lower</b>.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is the dependency manager for Objective-C projects. It has thousands of libraries and can help you scale your projects elegantly.

#### Podfile
```ruby
platform :ios, '7.0'
pod "OCGoogleDirectionsAPI", "~> 0.1.4"
```

## How to get started

It's really simple. To get directions you need to do <b>4 easy steps</b>.

1. Importing headers. From now all `OCDirections*` general classes will be accessible for you.

    ```objc
    #import <OCGoogleDirectionsAPI/OCGoogleDirectionsAPI.h>
    ````
 
2. Secondly you can provide your Google API Key. The method `application:didFinishLaunchingWithOptions:` in AppDelegate seams to be a good place for this code.
However the API Key is now optional. Please check [API Key section](https://developers.google.com/maps/documentation/directions/#api_key) to decide if you need the key or not.

   ```objc
   [OCDirectionsAPIClient provideAPIKey:@"<YOUR API KEY>"];
   ```

3. Prepare a `OCDirectionsRequest` object to specify route(s) you want to retrieve from the service.

   ```objc
   OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"<ORIGIN>" andDestinationString:@"<DESTINATION>"];
   ```

4. Create an instance of `OCDirectionsAPIClient` and call `directions:response:` method to retrieve required data (`OCDirectionsResponse`) asynchronously.

   ```objc
   OCDirectionsAPIClient *client = [OCDirectionsAPIClient new];
   [client directions:request response:^(OCDirectionsResponse *response, NSError *error) {
 
        // e.g.
        if (error) {
            return;
        }
        if (response.status != OCDirectionsResponseStatusOK) {
            return
        }
        
        // some code 
   }];
   ```
   
Some init methods of `OCDirectionsAPIClient`:
   
   ```objc
	- (instancetype)initWithKey:(NSString *)key;

	- (instancetype)initWithNoKeyUseHttps:(BOOL)useHttps;

	- (instancetype)initWithKey:(NSString *)key useHttps:(BOOL)https;
   ```

<b>Sequence diagram</b>

![Sequence diagram](https://raw.github.com/marciniwanicki/OCGoogleDirectionsAPI/master/UML/GetDirectionsSequenceDiagram.png)

That's all! It's quite easy, isn't it? If you like to know a bit more about requests please read the next section [OCDirectionsRequest](#ocdirectionsrequest).

## OCDirectionsRequest

### Creating an instance

To create an isntance of `OCDirectionsRequest` you can use one of the following factory methods.

```objc
+ (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationLocation:(CLLocation *)destination;

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationLocation:(CLLocation *)destination sensor:(BOOL)sensor;

+ (instancetype)requestWithOriginString:(NSString *)origin andDestinationLocation:(CLLocation *)destination;

+ (instancetype)requestWithOriginString:(NSString *)origin andDestinationLocation:(CLLocation *)destination sensor:(BOOL)sensor;

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationString:(NSString *)destination;

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationString:(NSString *)destination sensor:(BOOL)sensor;

+ (instancetype)requestWithOriginString:(NSString *)origin andDestinationString:(NSString *)destination;

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

#### Language
```objc
[request setLanguage:@"pl"];
```
Here you can find the list of supported languages: [https://developers.google.com/maps/faq#languagesupport](https://developers.google.com/maps/faq#languagesupport)

#### Restrictions

There are 3 different restrictions:
* `OCDirectionsRequestRestrictionAvoidTolls`
* `OCDirectionsRequestRestrictionAvoidHighways`
* `OCDirectionsRequestRestrictionAviodFerries`


You can ask to avoid one or even all of them by calling the `setRestrictions:` method.
```objc
[request setRestrictions:@[@(OCDirectionsRequestRestrictionAvoidTolls), @(OCDirectionsRequestRestrictionAviodFerries)];
```


#### Travel mode

The API allows to choose one of the following travel modes:
* `OCDirectionsRequestTravelModeDriving`
* `OCDirectionsRequestTravelModeWalking`
* `OCDirectionsRequestTravelModeBicycling`
* `OCDirectionsRequestTravelModeTransit`

```objc
[request setTravelMode:OCDirectionsRequestTravelModeBicycling];
```

### Unit

Available units:
* `OCDirectionsRequestUnitDefault`
* `OCDirectionsRequestUnitMetric`
* `OCDirectionsRequestUnitImperia`

```objc
[request setUnit:OCDirectionsRequestUnitMetric];
```

### Waypoints

You need to set `NSArray` of `NSString` and `CLLocation` objects.
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
* [OCDirectionsResponse](#ocdirectionsresponse)
* [OCDirectionsResponseStatus](#ocdirectionsresponsestatus)
* [OCDirectionsRoute](#ocdirectionsroute)
* [OCDirectionsLeg](#ocdirectionsleg)
* [OCDirectionsPolyline](#ocdirectionspolyline)
* [OCDirectionsBounds](#ocdirectionsbounds)
* [OCDirectionsDistance](#ocdirectionsdistance)
* [OCDirectionsDuration](#ocdirectionsduration)
* [OCDirectionsStep](#ocdirectionsstep)
* [OCDirectionsWaypoint](#ocdirectionswaypoint)


### OCDirectionsResponse

Properties:
* dictionary `NSDictionary*`
* status `OCDirectionsResponseStatus`
* routes `NSArray*` (array of `OCDirectionsRoute*`)
* errorMessage `NSString*`
* route `NSDirectionsRoute*`


### OCDirectionsResponseStatus 

Enum:
* `OCDirectionsResponseStatusNotInitialized`
* `OCDirectionsResponseStatusOK`
* `OCDirectionsResponseStatusNotFound`
* `OCDirectionsResponseStatusZeroResults`
* `OCDirectionsResponseStatusMaxWaypointsExceeded`
* `OCDirectionsResponseStatusInvalidRequest`
* `OCDirectionsResponseStatusOverQueryLimit`
* `OCDirectionsResponseStatusRequestDenied`
* `OCDirectionsResponseStatusUnknownError`


### OCDirectionsRoute

Properties:
* dictionary `NSDictionary*`
* legs `NSArray*` (array of `OCDirectionsLeg*`)
* copyrights `NSString*`
* warnings `NSArray*` (array of `NSString*`)
* waypointOrder `NSArray*` (array of `NSNumber*`)
* overviewPolyline `OCDirectionsPolyline*`
* bounds `OCDirectionsBounds*`
* summary `NSString*`


### OCDirectionsLeg

Properties:
* dictionary `NSDictionary*`
* distance `OCDirectionsDistance*`
* duration `OCDirectionsDuration*`
* endAddress `NSString*`
* endLocation `OCLocationCoordinate2D`
* startAddress `NSString*`
* startLocation `OCLocationCoordinate2D`
* steps `NSArray*` (array of `OCDirectionsStep*`)
* viaWaypoint `NSArray*` (array of `OCDirectionsWaypoint*`)


### OCDirectionsPolyline

Properties:
* dictionary `NSDictionary*`
* points `NSString*`


### OCDirectionsBounds

Properties:
* dictionary `NSDictionary*`
* southwest `CLLocationCoordinate2D`
* northeast `CLLocationCoordinate2D`


### OCDirectionsDistance

Properties:
* dictionary `NSDictionary*`
* text `NSString*`
* value `NSNumber*`


### OCDirectionsDuration

Properties:
* dictionary `NSDictionary*`
* text `NSString*`
* value `NSNumber*` 


### OCDirectionsStep

Properties:
* dictionary `NSDictionary*`
* distance `OCDirectionsDistance*`
* duration `OCDirectionsDuration*`
* endLocation `CLLocationCoordinate2D`
* htmlInstructions `NSString*`
* maneuver `NSString*`
* polyline `OCDirectionsPolyline*`
* startLocation `CLLocationCoordinate2D`
* travelMode `OCDirectionsRequestTravelMode`


### OCDirectionsWaypoint

Properties:
* dictionary `NSDictionary*`
* location `CLLocationCoordinate2D`
* stepIndex `NSNumber*` 
* stepInterpolation `NSNumber*` 


## Contact

Did you find a bug? Do you have great ideas how to make the library better? or you just want to say hello:) ... please do not hesitate to contact me via mail marcin.iwanicki[at]live.com or twitter @marciniwanicki.

## To Do

* Add samples.
* Write unit tests.
* Implement releasing dictionary object when the response tree is fully initialised.

## License

OCGoogleDirectionsAPI is available under the MIT license. See the LICENSE file for more info.
