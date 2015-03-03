//
//  OCDirectionsAPIClient.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDirectionsRequest.h"
#import "OCDirectionsResponse.h"
#import "OCDirectionsRequestURLCreator.h"
#import "OCDirectionsRequestURLCreatorJSON.h"

typedef void (^OCDirectionsRequestCallback)(OCDirectionsResponse *response, NSError *error);

@interface OCDirectionsAPIClient : NSObject

@property (nonatomic, retain) id<OCDirectionsRequestURLCreator> requestURLCreator;

- (instancetype)init;

- (instancetype)initWithKey:(NSString *)key;

- (instancetype)initWithNoKeyUseHttps:(BOOL)useHttps;

- (instancetype)initWithKey:(NSString *)key useHttps:(BOOL)https;

+ (void)provideAPIKey:(NSString *)key;

- (void)directions:(OCDirectionsRequest *)request response:(OCDirectionsRequestCallback)callback;

- (NSURL *)urlFromRequest:(OCDirectionsRequest *)request;

@end
