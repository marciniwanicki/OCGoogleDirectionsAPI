//
//  OCDirectionsDuration.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsDuration.h"

NSString *const kCGGoogleDirectionsResponseAttributeDuration = @"duration";

static NSString *const kCGGoogleDirectionsResponseAttributeDurationText = @"text";
static NSString *const kCGGoogleDirectionsResponseAttributeDurationValue = @"value";

@implementation OCDirectionsDuration

+ (instancetype)durationFromDictionary:(NSDictionary *)dictionary
{
    OCDirectionsDuration *duration = [[OCDirectionsDuration alloc] initWithDictionary:dictionary];
    return duration;
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
    NSString *text = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeDurationText];
    
    _text = text;
}

- (void)loadValue
{
    NSNumber *value = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeDurationValue];
    
    _value = value;
}

@end
