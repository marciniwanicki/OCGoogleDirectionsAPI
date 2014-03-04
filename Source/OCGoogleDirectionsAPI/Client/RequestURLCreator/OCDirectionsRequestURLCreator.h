//
//  OCDirectionsRequestURLCreator.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDirectionsRequest.h"

@protocol OCDirectionsRequestURLCreator <NSObject>

- (NSString *)stringFromRequest:(OCDirectionsRequest *)request useHttps:(BOOL)useHttps andKey:(NSString *)key;

- (NSURL *)urlFromRequest:(OCDirectionsRequest *)request useHttps:(BOOL)useHttps andKey:(NSString *)key;

@end
