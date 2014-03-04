//
//  OCGoogleDirectionsResponse.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/23/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsResponse.h"

static NSString *const kCGGoogleDirectionsResponseAttributeStatus = @"status";
static NSString *const kCGGoogleDirectionsResponseAttributeRoutes = @"routes";
static NSString *const kCGGoogleDirectionsResponseAttributeErrorMessage = @"error_message";

@implementation OCDirectionsResponse

+ (instancetype)responseFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsResponse *response = [[OCDirectionsResponse alloc] initWithDictionary:dictionary];
    return response;
}

- (OCDirectionsRoute *)route
{
    return self.routes.firstObject;
}

#pragma mark - Private init
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _dictionary = dictionary;
        
        [self loadStatus];
        [self loadRoutes];
        [self loadErrorMessage];
    }
    return self;
}

#pragma mark - Private methods
+ (NSDictionary *)statusDictionary
{
    static NSDictionary *dictionary;
    
    if (dictionary == nil) {
        dictionary = @{@"OK"                        : @(OCDirectionsResponseStatusOK),
                       @"NOT_FOUND"                 : @(OCDirectionsResponseStatusNotFound),
                       @"ZERO_RESULTS"              : @(OCDirectionsResponseStatusZeroResults),
                       @"MAX_WAYPOINTS_EXCEEDED"    : @(OCDirectionsResponseStatusMaxWaypointsExceeded),
                       @"INVALID_REQUEST"           : @(OCDirectionsResponseStatusInvalidRequest),
                       @"OVER_QUERY_LIMIT"          : @(OCDirectionsResponseStatusOverQueryLimit),
                       @"REQUEST_DENIED"            : @(OCDirectionsResponseStatusRequestDenied),
                       @"UNKNOWN_ERROR"             : @(OCDirectionsResponseStatusUnknownError)
                       };
    }
    return dictionary;
}

#pragma mark - Load attributes from dictionary
- (void)loadStatus
{
    NSString *statusString = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeStatus];
    
    NSNumber *statusNumber = [[OCDirectionsResponse statusDictionary] objectForKey:statusString];
    
    _status = [statusNumber unsignedIntegerValue];
}

- (void)loadRoutes
{
    NSArray *routesArray = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeRoutes];
    
    NSMutableArray *routes = [[NSMutableArray alloc] initWithCapacity:routesArray.count];
    for (NSDictionary *routeDictionary in routesArray) {
        OCDirectionsRoute *route = [OCDirectionsRoute routeFromDictionary:routeDictionary];
        [routes addObject:route];
    }
    
    _routes = routes;
}

- (void)loadErrorMessage
{
    NSString *errorMessage = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeErrorMessage];
    
    _errorMessage = errorMessage;
}

@end