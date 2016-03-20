//
//  OCDirectionsLeg.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OCDirectionsDistance.h"
#import "OCDirectionsDuration.h"

@interface OCDirectionsLeg : NSObject

@property (nonatomic, readonly) NSDictionary *dictionary;

@property (nonatomic, readonly) OCDirectionsDistance *distance;
@property (nonatomic, readonly) OCDirectionsDuration *duration;
@property (nonatomic, readonly) OCDirectionsDuration *durationInTraffic;
@property (nonatomic, copy, readonly) NSString *endAddress;
@property (nonatomic, readonly) CLLocationCoordinate2D endLocation;
@property (nonatomic, copy, readonly) NSString *startAddress;
@property (nonatomic, readonly) CLLocationCoordinate2D startLocation;
@property (nonatomic, readonly) NSArray *steps;
@property (nonatomic, readonly) NSArray *viaWaypoint;

+ (instancetype)legFromDictionary:(NSDictionary *)dictionary;

@end
