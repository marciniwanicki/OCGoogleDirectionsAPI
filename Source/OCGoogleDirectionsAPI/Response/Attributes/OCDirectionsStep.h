//
//  OCDirectionsStep.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OCDirectionsCommonTypes.h"
#import "OCDirectionsDistance.h"
#import "OCDirectionsDuration.h"
#import "OCDirectionsPolyline.h"

extern NSString *const kCGGoogleDirectionsResponseAttributeEndLocation;
extern NSString *const kCGGoogleDirectionsResponseAttributeStartLocation;

@interface OCDirectionsStep : NSObject

@property (nonatomic, strong, readonly) NSDictionary *dictionary;

@property (nonatomic, strong, readonly) OCDirectionsDistance *distance;
@property (nonatomic, strong, readonly) OCDirectionsDuration *duration;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D endLocation;
@property (nonatomic, copy, readonly) NSString *htmlInstructions;
@property (nonatomic, copy, readonly) NSString *maneuver;
@property (nonatomic, strong, readonly) OCDirectionsPolyline *polyline;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D startLocation;
@property (nonatomic, assign, readonly) OCDirectionsRequestTravelMode travelMode;

+ (instancetype)stepFromDictionary:(NSDictionary *)dictionary;

@end
