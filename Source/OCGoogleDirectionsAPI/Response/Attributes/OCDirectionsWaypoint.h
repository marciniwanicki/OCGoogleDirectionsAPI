//
//  OCDirectionsWaypoint.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OCDirectionsWaypoint : NSObject

@property (nonatomic, readonly) NSDictionary *dictionary;

/**
 Not documented yet.
 */
@property (nonatomic, readonly) CLLocationCoordinate2D location;

/**
 Not documented yet.
 */
@property (nonatomic, readonly) NSNumber *stepIndex;

/**
 Not documented yet.
 */
@property (nonatomic, readonly) NSNumber *stepInterpolation;

+ (instancetype)waypointFromDictionary:(NSDictionary *)dictionary;

@end
