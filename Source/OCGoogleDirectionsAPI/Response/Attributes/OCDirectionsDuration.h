//
//  OCDirectionsDuration.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kCGGoogleDirectionsResponseAttributeDuration;

@interface OCDirectionsDuration : NSObject

@property (nonatomic, retain, readonly) NSDictionary *dictionary;

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSNumber *value;

+ (instancetype)durationFromDictionary:(NSDictionary *)dictionary;

@end
