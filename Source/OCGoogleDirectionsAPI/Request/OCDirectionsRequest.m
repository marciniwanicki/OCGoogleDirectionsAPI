//
//  OCGoogleDirectionsRequest.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/23/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsRequest.h"
#import "OCAssertParameter.h"
#import "OCDirectionsRequestValidator.h"

@interface OCDirectionsRequest ()

@property (nonatomic, strong) OCDirectionsRequestValidator *requestValidator;

@end

@implementation OCDirectionsRequest

#pragma mark - Public init
- (instancetype)init
{
    self = [super init];
    if (self) {
        // Do nothing
    }
    return self;
}

#pragma mark - Private init
- (instancetype)initWithOriginLocation:(CLLocation *)origin
                andDestinationLocation:(CLLocation *)destination
                                sensor:(BOOL)sensor
{
    self = [super init];
    if (self) {
        _originLocation = origin;
        _destinationLocation = destination;
        _sensor = sensor;
    }
    
    return self;
}

- (instancetype)initWithOriginString:(NSString *)origin
              andDestinationLocation:(CLLocation *)destination
                              sensor:(BOOL)sensor
{
    self = [super init];
    if (self) {
        _originString = origin;
        _destinationLocation = destination;
        _sensor = sensor;
    }
    return self;
}

- (instancetype)initWithOriginLocation:(CLLocation *)origin
                  andDestinationString:(NSString *)destination
                                sensor:(BOOL)sensor
{
    self = [super init];
    if (self) {
        _originLocation = origin;
        _destinationString = destination;
        _sensor = sensor;
    }
    return self;
}

- (instancetype)initWithOriginString:(NSString *)origin
                andDestinationString:(NSString *)destination
                              sensor:(BOOL)sensor
{
    self = [super init];
    if (self) {
        _originString = origin;
        _destinationString = destination;
        _sensor = sensor;
    }
    return self;
}

- (OCDirectionsRequestValidator *)requestValidator
{
    if (_requestValidator == nil) {
        self.requestValidator = [OCDirectionsRequestValidator new];
    }
    return _requestValidator;
}

@end

@implementation OCDirectionsRequest (Creation)

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
                   andDestinationLocation:(CLLocation *)destination
                                   sensor:(BOOL)sensor
{
    OCAssertParameterNotNil(origin, @"Origin location is nil.");
    OCAssertParameterNotNil(destination, @"Destination location is nil.");
    
    OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
                                    initWithOriginLocation:origin
                                    andDestinationLocation:destination
                                    sensor:sensor];
    
    return request;
}

+ (instancetype)requestWithOriginString:(NSString *)origin
                 andDestinationLocation:(CLLocation *)destination
                                 sensor:(BOOL)sensor
{
    OCAssertParameterNotNil(origin, @"Origin string is nil.");
    OCAssertParameterNotNil(destination, @"Destination location is nil.");
    
    OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
                                    initWithOriginString:origin
                                    andDestinationLocation:destination
                                    sensor:sensor];
    return request;
}

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
                     andDestinationString:(NSString *)destination
                                   sensor:(BOOL)sensor
{
    OCAssertParameterNotNil(origin, @"Origin location is nil.");
    OCAssertParameterNotNil(destination, @"Destination string is nil.");
    
    OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
                                    initWithOriginLocation:origin
                                    andDestinationString:destination
                                    sensor:sensor];
    return request;
}

+ (instancetype)requestWithOriginString:(NSString *)origin
                   andDestinationString:(NSString *)destination
                                 sensor:(BOOL)sensor
{
    OCAssertParameterNotNil(origin, @"Origin string is nil.");
    OCAssertParameterNotNil(destination, @"Destination string is nil.");
    
    OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
                                    initWithOriginString:origin
                                    andDestinationString:destination
                                    sensor:sensor];
    return request;
}

- (BOOL)isValid
{
    BOOL isValid = [self.requestValidator isValid:self];
    return isValid;
}

@end
