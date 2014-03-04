//
//  OCDirectionsStep.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsStep.h"
#import "CLLocation+CoortindateFromDictionary.h"

NSString *const kCGGoogleDirectionsResponseAttributeEndLocation = @"end_location";
NSString *const kCGGoogleDirectionsResponseAttributeStartLocation = @"start_location";

static NSString *const kCGGoogleDirectionsResponseAttributeHtmlInstructions = @"html_instructions";
static NSString *const kCGGoogleDirectionsResponseAttributManeuver = @"maneuver";
static NSString *const kCGGoogleDirectionsResponseAttributPolyline = @"polyline";

static NSString *const kCGGoogleDirectionsResponseAttributTravelMode = @"travel_mode";

@implementation OCDirectionsStep

+ (instancetype)stepFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsStep *step = [[OCDirectionsStep alloc] initWithDictionary:dictionary];
    return step;
}

#pragma mark - Private init
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _dictionary = dictionary;
        
        [self loadAllProperties];
    }
    return self;
}

#pragma mark - Load properties from dictionary
- (void)loadAllProperties
{
    [self loadDistance];
    [self loadDuration];
    [self loadEndLocation];
    [self loadHtmlInstructions];
    [self loadManeuver];
    [self loadPolyline];
    [self loadStartLocation];
    [self loadTravelMode];
}

- (void)loadDistance
{
    NSDictionary *distanceDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeDistance];
    OCDirectionsDistance *distance = [OCDirectionsDistance distanceFromDictionary:distanceDictionary];
    
    _distance = distance;
}

- (void)loadDuration
{
    NSDictionary *durationDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeDuration];
    OCDirectionsDuration *duration = [OCDirectionsDuration durationFromDictionary:durationDictionary];
    
    _duration = duration;
}

- (void)loadEndLocation
{
    NSDictionary *endLocationDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeEndLocation];
    CLLocationCoordinate2D endLocation = [CLLocation coordinateFromDictionary:endLocationDictionary];
    
    _endLocation = endLocation;
}

- (void)loadHtmlInstructions
{
    NSString *htmlInstructions = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeHtmlInstructions];
    
    _htmlInstructions = htmlInstructions;
}

- (void)loadManeuver
{
    NSString *maneuver = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributManeuver];
    
    _maneuver = maneuver;
}

- (void)loadPolyline
{
    NSDictionary *polylineDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributPolyline];
    OCDirectionsPolyline *polyline = [OCDirectionsPolyline polylineFromDictionary:polylineDictionary];
    
    _polyline = polyline;
}

- (void)loadStartLocation
{
    NSDictionary *startLocationDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeStartLocation];
    CLLocationCoordinate2D startLocation = [CLLocation coordinateFromDictionary:startLocationDictionary];
    
    _startLocation = startLocation;
}

- (void)loadTravelMode
{
    NSString *travelModeString = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributTravelMode];
    OCDirectionsRequestTravelMode travelMode = [OCDirectionsCommonTypes travelModeFromString:travelModeString];
    
    _travelMode = travelMode;
}

@end
