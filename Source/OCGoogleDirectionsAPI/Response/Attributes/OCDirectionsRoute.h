//
//  OCDirectionsRoute.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDirectionsPolyline.h"
#import "OCDirectionsBounds.h"

@interface OCDirectionsRoute : NSObject

@property (nonatomic, retain, readonly) NSDictionary *dictionary;

/**
 legs[] contains an array which contains information about a leg of the route, between two locations within the given route. A separate leg will be present for each waypoint or destination specified. (A route with no waypoints will contain exactly one leg within the legs array.) Each leg consists of a series of steps. (See Directions Legs below.)
 */
@property (nonatomic, strong, readonly) NSArray *legs;

/**
 copyrights contains the copyrights text to be displayed for this route. You must handle and display this information yourself.
 */
@property (nonatomic, copy, readonly) NSString *copyrights;

/*
 warnings[] contains an array of warnings to be displayed when showing these directions. You must handle and display these warnings yourself.
 */
@property (nonatomic, strong, readonly) NSArray *warnings;

/**
 waypoint_order contains an array indicating the order of any waypoints in the calculated route. This waypoints may be reordered if the request was passed optimize:true within its waypoints parameter.
 */
@property (nonatomic, strong, readonly) NSArray *waypointOrder;

/**
 overview_polyline contains an object holding an array of encoded points that represent an approximate (smoothed) path of the resulting directions.
 */
@property (nonatomic, strong, readonly) OCDirectionsPolyline *overviewPolyline;

/**
 bounds contains the viewport bounding box of the overview_polyline.
 */
@property (nonatomic, strong, readonly) OCDirectionsBounds *bounds;

/**
 summary contains a short textual description for the route, suitable for naming and disambiguating the route from alternatives.
 */
@property (nonatomic, strong, readonly) NSString *summary;

+ (instancetype)routeFromDictionary:(NSDictionary *)dictionary;

@end
