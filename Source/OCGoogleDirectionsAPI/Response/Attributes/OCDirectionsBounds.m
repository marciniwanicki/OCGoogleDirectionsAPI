//
//  OCDirectionsBounds.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsBounds.h"
#import "CLLocation+CoortindateFromDictionary.h"

static NSString *const kCGGoogleDirectionsResponseAttributeBoundsSouthwest = @"southwest";
static NSString *const kCGGoogleDirectionsResponseAttributeBoundsNortheast = @"northeast";

@implementation OCDirectionsBounds

+ (instancetype)boundsFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsBounds *bounds = [[OCDirectionsBounds alloc] initWithDictionary:dictionary];
    return bounds;
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
    [self loadSouthwest];
    [self loadNortheast];
}

- (void)loadSouthwest
{
    NSDictionary *southwestDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeBoundsSouthwest];
    CLLocationCoordinate2D coordinate = [CLLocation coordinateFromDictionary:southwestDictionary];

    _southwest = coordinate;
}

- (void)loadNortheast
{
    NSDictionary *northeastDictionary = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeBoundsNortheast];
    CLLocationCoordinate2D coordinate = [CLLocation coordinateFromDictionary:northeastDictionary];
    
    _northeast = coordinate;
}

@end
