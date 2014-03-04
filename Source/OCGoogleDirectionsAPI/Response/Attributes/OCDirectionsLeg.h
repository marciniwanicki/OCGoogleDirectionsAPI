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

@property (nonatomic, strong, readonly) NSDictionary *dictionary;

@property (nonatomic, strong, readonly) OCDirectionsDistance *distance;
@property (nonatomic, strong, readonly) OCDirectionsDuration *duration;
@property (nonatomic, copy, readonly) NSString *endAddress;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D endLocation;
@property (nonatomic, copy, readonly) NSString *startAddress;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D startLocation;
@property (nonatomic, strong, readonly) NSArray *steps;
@property (nonatomic, strong, readonly) NSArray *viaWaypoint;

+ (instancetype)legFromDictionary:(NSDictionary *)dictionary;

@end
