//
//  OCDirectionsDuration.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kCGGoogleDirectionsResponseAttributeDuration;
extern NSString *const kCGGoogleDirectionsResponseAttributeDurationInTraffic;

@interface OCDirectionsDuration : NSObject

@property (nonatomic, readonly) NSDictionary *dictionary;

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, readonly) NSNumber *value;

+ (instancetype)durationFromDictionary:(NSDictionary *)dictionary;

@end
