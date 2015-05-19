//
//  OCGoogleDirectionsRequest.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/23/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OCDirectionsCommonTypes.h"

@interface OCDirectionsRequest : NSObject

#pragma mark - Required
/**
 Origin - The address or textual latitude/longitude value from which you wish to calculate directions. If you pass an address as a string, the Directions service will geocode the string and convert it to a latitude/longitude coordinate to calculate directions. If you pass coordinates, ensure that no space exists between the latitude and longitude values.
 */
@property (nonatomic, readonly) CLLocation *originLocation; // CLLocation or NSString
@property (nonatomic, copy, readonly) NSString *originString;

/**
 Destination - The address or textual latitude/longitude value from which you wish to calculate directions. If you pass an address as a string, the Directions service will geocode the string and convert it to a latitude/longitude coordinate to calculate directions. If you pass coordinates, ensure that no space exists between the latitude and longitude values.
 */
@property (nonatomic, readonly) CLLocation *destinationLocation; // CLLocation or NSString
@property (nonatomic, copy, readonly) NSString *destinationString;

/*
 Indicates whether or not the directions request comes from a device with a location sensor. This value must be either true or false.
 */
@property (nonatomic, readonly) BOOL sensor;

#pragma mark - Optional
@property (nonatomic) OCDirectionsRequestTravelMode travelMode;

/**
 When calculating routes using the Directions API, you may also specify waypoints for driving, walking or bicycling directions. Waypoints are not available for transit directions. Waypoints allow you to calculate routes through additional locations, in which case the returned route passes through the given waypoints.
 
 Formally it is an array of NSStrings and CLLocations.
 */
@property (nonatomic) NSArray *waypoints;

/**
 Optimizes the provided route by rearranging the waypoints in a more efficient order. (This optimization is an application of the Travelling Salesman Problem.)
 */
@property (nonatomic) BOOL waypointsOptimise;

/**
 Directions may be calculated that adhere to certain restrictions.
 Use an array of DirectionsRequestRestriction types ie. @[DirectionsRequestAvoidTollsRestriction, DirectionsRequestAviodFerriesRestriction]
 */
@property (nonatomic) NSArray *restrictions;

/**
 Directions results contain text within distance fields that may be displayed to the user to indicate the distance of a particular "step" of the route. By default, this text uses the unit system of the origin's country or region.
 */
@property (nonatomic) OCDirectionsRequestUnit unit;
/**
 You can also set the Directions service to return results biased to a particular region by use of the region parameter. This parameter takes a ccTLD (country code top-level domain) argument specifying the region bias. Most ccTLD codes are identical to ISO 3166-1 codes, with some notable exceptions. For example, the United Kingdom's ccTLD is "uk" (.co.uk) while its ISO 3166-1 code is "gb" (technically for the entity of "The United Kingdom of Great Britain and Northern Ireland").
 
 You may utilize any domain in which the main Google Maps application has launched driving directions.
 */
@property (nonatomic, copy) NSString *region;

/**
 You can also set the Directions service to return results is specific language.
	If language is not supplied, the service will attempt to use the native language of the domain from which the request is sent.
 */
@property (nonatomic, copy) NSString *language;

/**
 Directions service may return several routes if you pass alternatives.
 */
@property (nonatomic) BOOL alternatives;

/**
 Indicates whether sensor flag has been used or not.
 */
@property (nonatomic, getter=isSensorFlagUsed, readonly) BOOL sensorFlagUsed;

@end

@interface OCDirectionsRequest (Creation)

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
                   andDestinationLocation:(CLLocation *)destination;

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
                   andDestinationLocation:(CLLocation *)destination
                                   sensor:(BOOL)sensor __deprecated_msg("Sensor parameter is no longer required. Use + (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationLocation:(CLLocation *)destination");

+ (instancetype)requestWithOriginString:(NSString *)origin
                 andDestinationLocation:(CLLocation *)destination;

+ (instancetype)requestWithOriginString:(NSString *)origin
                 andDestinationLocation:(CLLocation *)destination
                                 sensor:(BOOL)sensor __deprecated_msg("Sensor parameter is no longer required. Use + (instancetype)requestWithOriginString:(NSString *)origin andDestinationLocation:(CLLocation *)destination");

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
                     andDestinationString:(NSString *)destination;

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
                     andDestinationString:(NSString *)destination
                                   sensor:(BOOL)sensor __deprecated_msg("Sensor parameter is no longer required. Use + (instancetype)requestWithOriginLocation:(CLLocation *)origin andDestinationString:(NSString *)destination");

+ (instancetype)requestWithOriginString:(NSString *)origin
                   andDestinationString:(NSString *)destination;

+ (instancetype)requestWithOriginString:(NSString *)origin
                   andDestinationString:(NSString *)destination
                                 sensor:(BOOL)sensor __deprecated_msg("Sensor parameter is no longer required. Use + (instancetype)requestWithOriginString:(NSString *)origin andDestinationString:(NSString *)destination");

- (BOOL)isValid;

@end