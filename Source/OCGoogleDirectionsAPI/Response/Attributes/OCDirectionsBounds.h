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

@property (nonatomic, retain, readonly) NSDictionary *dictionary;

@property (nonatomic, assign, readonly) CLLocationCoordinate2D southwest;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D northeast;

+ (instancetype)boundsFromDictionary:(NSDictionary *)dictionary;

@end
