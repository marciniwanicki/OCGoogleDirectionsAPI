//
//  OCDirectionsBounds.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface OCDirectionsBounds : NSObject

@property (nonatomic, readonly) NSDictionary *dictionary;

@property (nonatomic, readonly) CLLocationCoordinate2D southwest;
@property (nonatomic, readonly) CLLocationCoordinate2D northeast;

+ (instancetype)boundsFromDictionary:(NSDictionary *)dictionary;

@end
