//
//  OCDirectionsAPIClient.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsAPIClient.h"

@interface OCDirectionsAPIClient ()

@property (nonatomic, copy) NSString *key;
@property (nonatomic) BOOL useHttps;

@end

@implementation OCDirectionsAPIClient

static NSString *_defaultKey;

- (instancetype)init
{
	return [self initWithKey:_defaultKey];
}

- (instancetype)initWithNoKey
{
	return [self initWithKey:nil];
}

- (instancetype)initWithNoKeyUseHttps:(BOOL)useHttps
{
	return [self initWithKey:nil useHttps:useHttps];
}

- (instancetype)initWithKey:(NSString *)key
{
    return [self initWithKey:key useHttps:YES];
}

- (instancetype)initWithKey:(NSString *)key useHttps:(BOOL)useHttps
{
    self = [super init];
    if (self) {
        self.key = key;
        self.useHttps = useHttps;
		self.requestURLCreator = [OCDirectionsRequestURLCreatorJSON new];
    }
    return self;
}

+ (void)provideAPIKey:(NSString *)key
{
    _defaultKey = key;
}

- (void)directions:(OCDirectionsRequest *)request response:(OCDirectionsRequestCallback)callback
{
    NSURL *url = [self urlFromRequest:request];
    
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

- (NSURL *)urlFromRequest:(OCDirectionsRequest *)request
{
	NSURL *url = [self.requestURLCreator urlFromRequest:request useHttps:self.useHttps andKey:self.key];
	return url;
}

@end
