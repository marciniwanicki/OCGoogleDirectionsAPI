//
//  OCDirectionsPolyline.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/25/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCDirectionsPolyline : NSObject

@property (nonatomic, retain, readonly) NSDictionary *dictionary;

@property (nonatomic, copy, readonly) NSString *points;

+ (instancetype)polylineFromDictionary:(NSDictionary *)dictionary;

@end
