//
//  OCGoogleDirectionsResponse.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/23/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDirectionsRoute.h"

typedef NS_ENUM(NSUInteger, OCDirectionsResponseStatus) {
    OCDirectionsResponseStatusNotInitialized, // indicated the status has not been loaded yet.
    OCDirectionsResponseStatusOK, // indicates the response contains a valid result.
    OCDirectionsResponseStatusNotFound, // indicates at least one of the locations specified in the request's origin, destination, or waypoints could not be geocoded.
    OCDirectionsResponseStatusZeroResults, // indicates no route could be found between the origin and destination.
    OCDirectionsResponseStatusMaxWaypointsExceeded, // indicates that too many waypointss were provided in the request The maximum allowed waypoints is 8, plus the origin, and destination. ( Google Maps API for Business customers may contain requests with up to 23 waypoints.)
    OCDirectionsResponseStatusInvalidRequest, // indicates that the provided request was invalid. Common causes of this status include an invalid parameter or parameter value.
    OCDirectionsResponseStatusOverQueryLimit, // indicates the service has received too many requests from your application within the allowed time period.
    OCDirectionsResponseStatusRequestDenied, // indicates that the service denied use of the directions service by your application.
    OCDirectionsResponseStatusUnknownError // indicates a directions request could not be processed due to a server error. The request may succeed if you try again.
};

@interface OCDirectionsResponse : NSObject

@property (nonatomic, strong, readonly) NSDictionary *dictionary;

/**
 "status" contains metadata on the request. See Status Codes above.
 */
@property (nonatomic, assign, readonly) OCDirectionsResponseStatus status;

/**
 "routes" contains an array of routes from the origin to the destination.
 */
@property (nonatomic, strong, readonly) NSArray *routes;

/**
 "errorMessage" (optional) field contains more detailed information about the reasons behind the given status code.
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;

+ (instancetype)responseFromDictionary:(NSDictionary *)dictionary;

/**
 returns first object as a default route
 */
- (OCDirectionsRoute *)route;

@end
