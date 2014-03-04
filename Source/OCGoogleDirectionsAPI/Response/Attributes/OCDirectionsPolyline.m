//
//  OCDirectionsPolyline.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsPolyline.h"

static NSString *const kCGGoogleDirectionsResponseAttributePolylinePoints = @"points";

@implementation OCDirectionsPolyline

+ (instancetype)polylineFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsPolyline *polyline = [[OCDirectionsPolyline alloc] initWithDictionary:dictionary];
    return polyline;
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
    [self loadPoints];
}

- (void)loadPoints
{
    NSString *points = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributePolylinePoints];
    
    _points = points;
}

@end
