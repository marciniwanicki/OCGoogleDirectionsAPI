//
//  OCDirectionsWaypoint.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsWaypoint.h"
#import "CLLocation+CoortindateFromDictionary.h"

static NSString *const kCGGoogleDirectionsResponseAttributeLocation = @"location";
static NSString *const kCGGoogleDirectionsResponseAttributeStepIndex = @"step_index";
static NSString *const kCGGoogleDirectionsResponseAttributeStepInterpolation = @"step_interpolation";

@implementation OCDirectionsWaypoint

+ (instancetype)waypointFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsWaypoint *waypoint = [[OCDirectionsWaypoint alloc] initWithDictionary:dictionary];
    return waypoint;
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
    [self loadLocation];
    [self loadStepIndex];
    [self loadStepInterpolation];
}

- (void)loadLocation
{
    NSDictionary *locationDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeLocation];
    CLLocationCoordinate2D location = [CLLocation coordinateFromDictionary:locationDictionary];
    
    _location = location;
}

- (void)loadStepIndex
{
    NSNumber *stepIndex = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeStepIndex];
    
    _stepIndex = stepIndex;
}

- (void)loadStepInterpolation
{
    NSNumber *stepInterpolation = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeStepInterpolation];
    
    _stepInterpolation = stepInterpolation;
}

@end
