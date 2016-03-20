//
// Created by Marcin Iwanicki on 20/03/2016.
//

#import <Foundation/Foundation.h>

extern NSString *const kCGGoogleDirectionsResponseAttributeFare;

@interface OCDirectionsFare : NSObject

@property (nonatomic, readonly) NSDictionary *dictionary;

/**
 * An ISO 4217 currency code indicating the currency that the amount is expressed in.
 */
@property (nonatomic, copy, readonly) NSString *currency;

/**
 * The total fare amount, formatted in the requested language.
 */
@property (nonatomic, copy, readonly) NSString *text;

/**
 * The total fare amount, in the currency specified above.
 */
@property (nonatomic, readonly) NSNumber *value;

+ (instancetype)fareFromDictionary:(NSDictionary *)dictionary;

@end
