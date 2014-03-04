//
//  OCDirectionsLeg.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsLeg.h"
#import "OCDirectionsStep.h"
#import "OCDirectionsWaypoint.h"
#import "CLLocation+CoortindateFromDictionary.h"

static NSString *const kCGgoogleDirectionsResponseAttributeEndAddress = @"end_address";
static NSString *const kCGgoogleDirectionsResponseAttributeStartAddress = @"start_address";
static NSString *const kCGGoogleDirectionsResponseAttributeHtmlInstructions = @"html_instructions";
static NSString *const kCGGoogleDirectionsResponseAttributeSteps = @"steps";
static NSString *const kCGGoogleDirectionsResponseAttributeViaWaypoint = @"via_waypoint";

@implementation OCDirectionsLeg

+ (instancetype)legFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsLeg *leg = [[OCDirectionsLeg alloc] initWithDictionary:dictionary];
    
    return leg;
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
    [self loadEndAddress];
    [self loadEndLocation];
    [self loadStartAddress];
    [self loadStartLocation];
    [self loadSteps];
    [self loadViaWaypoint];
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

- (void)loadEndAddress
{
    NSString *endAddress = [_dictionary objectForKey:kCGgoogleDirectionsResponseAttributeEndAddress];

    _endAddress = endAddress;
}

- (void)loadEndLocation
{
    NSDictionary *endLocationDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeEndLocation];
    CLLocationCoordinate2D endLocation = [CLLocation coordinateFromDictionary:endLocationDictionary];
    
    _endLocation = endLocation;
}

- (void)loadStartAddress
{
    NSString *startAddress = [_dictionary objectForKey:kCGgoogleDirectionsResponseAttributeStartAddress];
    
    _startAddress = startAddress;
}

- (void)loadStartLocation
{
    NSDictionary *startLocationDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeStartLocation];
    CLLocationCoordinate2D startLocation = [CLLocation coordinateFromDictionary:startLocationDictionary];
    
    _startLocation = startLocation;
}

- (void)loadSteps
{
    NSArray *stepsArray = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeSteps];
    NSMutableArray *steps = [[NSMutableArray alloc] initWithCapacity:stepsArray.count];
    
    for (NSDictionary *stepDictionary in stepsArray) {
        OCDirectionsStep *step = [OCDirectionsStep stepFromDictionary:stepDictionary];
        [steps addObject:step];
    }
    
    _steps = steps;
}

- (void)loadViaWaypoint
{
    NSArray *viaWaypointArray = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeViaWaypoint];
    NSMutableArray *viaWaypoint = [[NSMutableArray alloc] initWithCapacity:viaWaypointArray.count];
    for (NSDictionary *viaWaypointDictionary in viaWaypointArray) {
        OCDirectionsWaypoint *waypoint = [OCDirectionsWaypoint waypointFromDictionary:viaWaypointDictionary];
        [viaWaypoint addObject:waypoint];
    }
    
    _viaWaypoint = viaWaypoint;
}

@end
