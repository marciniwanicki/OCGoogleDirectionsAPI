//
//  OCGoogleDirectionsRequest.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/23/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsRequest.h"
#import "OCAssertParameter.h"

@interface OCDirectionsRequest ()

@property (nonatomic) CLLocation *originLocation;
@property (nonatomic, copy) NSString *originString;

@property (nonatomic) CLLocation *destinationLocation;
@property (nonatomic, copy) NSString *destinationString;

@property (nonatomic) BOOL sensor;
@property (nonatomic, getter=isSensorFlagUsed) BOOL sensorFlagUsed;

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
{
	self = [super init];
	if (self) {
		self.originLocation = origin;
		self.destinationLocation = destination;
	}
	
	return self;
}

- (instancetype)initWithOriginLocation:(CLLocation *)origin
                andDestinationLocation:(CLLocation *)destination
                                sensor:(BOOL)sensor
{
    self = [self initWithOriginLocation:origin andDestinationLocation:destination];
    if (self) {
        self.sensor = sensor;
		self.sensorFlagUsed = YES;
    }
    
    return self;
}

- (instancetype)initWithOriginString:(NSString *)origin
			  andDestinationLocation:(CLLocation *)destination
{
	self = [super init];
	if (self) {
		self.originString = origin;
		self.destinationLocation = destination;
	}
	return self;
}

- (instancetype)initWithOriginString:(NSString *)origin
              andDestinationLocation:(CLLocation *)destination
                              sensor:(BOOL)sensor
{
    self = [self initWithOriginString:origin andDestinationLocation:destination];
    if (self) {
        self.sensor = sensor;
		self.sensorFlagUsed = YES;
    }
    return self;
}

- (instancetype)initWithOriginLocation:(CLLocation *)origin
				  andDestinationString:(NSString *)destination
{
	self = [super init];
	if (self) {
		self.originLocation = origin;
		self.destinationString = destination;
	}
	return self;
}

- (instancetype)initWithOriginLocation:(CLLocation *)origin
                  andDestinationString:(NSString *)destination
                                sensor:(BOOL)sensor
{
    self = [self initWithOriginLocation:origin andDestinationString:destination];
    if (self) {
        self.sensor = sensor;
		self.sensorFlagUsed = YES;
    }
    return self;
}

- (instancetype)initWithOriginString:(NSString *)origin
				andDestinationString:(NSString *)destination
{
	self = [super init];
	if (self) {
		self.originString = origin;
		self.destinationString = destination;
	}
	return self;
}

- (instancetype)initWithOriginString:(NSString *)origin
                andDestinationString:(NSString *)destination
                              sensor:(BOOL)sensor
{
    self = [self initWithOriginString:origin andDestinationString:destination];
    if (self) {
        self.sensor = sensor;
		self.sensorFlagUsed = YES;
    }
    return self;
}

@end

@implementation OCDirectionsRequest (Creation)

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
				   andDestinationLocation:(CLLocation *)destination
{
	OCAssertParameterNotNil(origin, @"Origin location is nil.");
	OCAssertParameterNotNil(destination, @"Destination location is nil.");
	
	OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
									initWithOriginLocation:origin
									andDestinationLocation:destination];
	
	return request;
}

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
{
	OCAssertParameterNotNil(origin, @"Origin string is nil.");
	OCAssertParameterNotNil(destination, @"Destination location is nil.");
	
	OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
									initWithOriginString:origin
									andDestinationLocation:destination];
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

+ (instancetype)requestWithOriginLocation:(CLLocation *)origin
					 andDestinationString:(NSString *)destination
{
	OCAssertParameterNotNil(origin, @"Origin location is nil.");
	OCAssertParameterNotNil(destination, @"Destination string is nil.");
	
	OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
									initWithOriginLocation:origin
									andDestinationString:destination];
	return request;
}

+ (instancetype)requestWithOriginString:(NSString *)origin
                   andDestinationString:(NSString *)destination
{
    OCAssertParameterNotNil(origin, @"Origin string is nil.");
    OCAssertParameterNotNil(destination, @"Destination string is nil.");
    
    OCDirectionsRequest *request = [[OCDirectionsRequest alloc]
                                    initWithOriginString:origin
                                    andDestinationString:destination];
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
	if (self.originLocation == nil && self.originString == nil) {
		return NO;
	}
	
	if (self.destinationLocation == nil && self.destinationString == nil) {
		return NO;
	}
	
	return YES;
}

@end
