//
//  OCDirectionsAPIClient.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsAPIClient.h"

@interface OCDirectionsAPIClient ()

@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, assign, readonly) BOOL useHttps;

@end

@implementation OCDirectionsAPIClient

static NSString *_defaultKey;

- (instancetype)init
{
    if (_defaultKey == nil) {
        [NSException raise:NSInternalInconsistencyException format:@"The Directions API key has not been provided."];
    }
    
    return [self initWithKey:_defaultKey];
}

- (instancetype)initWithKey:(NSString *)key
{
    return [self initWithKey:key useHttps:YES];
}

- (instancetype)initWithKey:(NSString *)key useHttps:(BOOL)useHttps
{
    self = [super init];
    if (self) {
        _key = key;
        _useHttps = useHttps;
    }
    return self;
}

+ (void)provideAPIKey:(NSString *)key
{
    _defaultKey = key;
}

- (void)directions:(OCDirectionsRequest *)request response:(OCDirectionsRequestCallback)callback
{
    NSURL *url = [self.requestURLCreator urlFromRequest:request useHttps:self.useHttps andKey:self.key];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                if (error) {
                    callback(nil, error);
                    return;
                }
                
                NSError *jsonParsingError = nil;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonParsingError];
                
                if (jsonParsingError) {
                    callback(nil, jsonParsingError);
                    return;
                }
                                
                OCDirectionsResponse *directionsResponse = [OCDirectionsResponse responseFromDictionary:dictionary];
                callback(directionsResponse, nil);
                return;
                
            }] resume];
}

- (id<OCDirectionsRequestURLCreator>)requestURLCreator
{
    if (_requestURLCreator == nil) {
        self.requestURLCreator = [OCDirectionsRequestURLCreatorJSON new];
    }
    return _requestURLCreator;
}

@end
