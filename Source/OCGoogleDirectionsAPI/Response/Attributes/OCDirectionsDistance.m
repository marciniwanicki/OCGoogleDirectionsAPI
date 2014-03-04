//
//  OCDirectionsDistance.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsDistance.h"

NSString *const kCGGoogleDirectionsResponseAttributeDistance = @"distance";

static NSString *const kCGGoogleDirectionsResponseAttributeDistanceText = @"text";
static NSString *const kCGGoogleDirectionsResponseAttributeDistanceValue = @"value";

@implementation OCDirectionsDistance

+ (instancetype)distanceFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsDistance *distance = [[OCDirectionsDistance alloc] initWithDictionary:dictionary];
    return distance;
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
    [self loadText];
    [self loadValue];
}

- (void)loadText
{
    NSString *text = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeDistanceText];
    
    _text = text;
}

- (void)loadValue
{
    NSNumber *value = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeDistanceValue];
    
    _value = value;
}

@end
