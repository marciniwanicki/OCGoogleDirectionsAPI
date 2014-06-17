//
//  OCDirectionsRoute.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsRoute.h"
#import "OCDirectionsLeg.h"

static NSString *const kCGGoogleDirectionsResponseAttributeRouteSummary = @"summary";
static NSString *const kCGGoogleDirectionsResponseAttributeRouteLegs = @"legs";
static NSString *const kCGGoogleDirectionsResponseAttributeRouteWaypointOrder = @"waypoint_order";
static NSString *const kCGGoogleDirectionsResponseAttributeRouteOverviewPolyline = @"overview_polyline";
static NSString *const kCGGoogleDirectionsResponseAttributeRouteBounds = @"bounds";
static NSString *const kCGGoogleDirectionsResponseAttributeRouteCopyrights = @"copyrights";
static NSString *const kCGGoogleDirectionsResponseAttributeRouteWarnings = @"warnings";

@implementation OCDirectionsRoute

+ (instancetype)routeFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsRoute *route = [[OCDirectionsRoute alloc] initWithDictionary:dictionary];
    return route;
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
    [self loadLegs];
    [self loadCopyrights];
    [self loadWarnings];
    [self loadWaypointOrder];
    [self loadOverviewPolyline];
    [self loadBounds];
	[self loadSummary];
}

- (void)loadLegs
{
    NSArray *legsArray = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRouteLegs];
    NSMutableArray *legs = [[NSMutableArray alloc] initWithCapacity:legsArray.count];
    for (NSDictionary *legDictionary in legsArray) {
        OCDirectionsLeg *leg = [OCDirectionsLeg legFromDictionary:legDictionary];
        [legs addObject:leg];
    }
    
    _legs = legs;
}

- (void)loadCopyrights
{
    NSString *copyrights = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRouteCopyrights];
    
    _copyrights = copyrights;
}

- (void)loadWarnings
{
    NSArray *warningsArray = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRouteWarnings];
    
    _warnings = warningsArray;
}

- (void)loadWaypointOrder
{
    NSArray *waypointOrder = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRouteWaypointOrder];
    
    _waypointOrder = waypointOrder;
}

- (void)loadOverviewPolyline
{
    NSDictionary *overviewPolyline = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRouteOverviewPolyline];
    OCDirectionsPolyline *polyline = [OCDirectionsPolyline polylineFromDictionary:overviewPolyline];
    
    _overviewPolyline = polyline;
}

- (void)loadBounds
{
    NSDictionary *boundsDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRouteBounds];
    OCDirectionsBounds *bounds = [OCDirectionsBounds boundsFromDictionary:boundsDictionary];
    
    _bounds = bounds;
}

- (void)loadSummary
{
    NSString *summary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRouteSummary];
    _summary = summary;
}

@end
