//
// Created by Marcin Iwanicki on 20/03/2016.
//

#import "OCDirectionsFare.h"

NSString *const kCGGoogleDirectionsResponseAttributeFare = @"fare";

static NSString *const kCGGoogleDirectionsResponseAttributeFareCurrency = @"currency";
static NSString *const kCGGoogleDirectionsResponseAttributeFareValue = @"value";
static NSString *const kCGGoogleDirectionsResponseAttributeFareText = @"text";

@implementation OCDirectionsFare

#pragma mark - Public

+ (instancetype)fareFromDictionary:(NSDictionary *)dictionary {
    return [[OCDirectionsFare alloc] initWithDictionary:dictionary];
}

#pragma mark - Private

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _dictionary = dictionary;

        [self loadAllProperties];
    }
    return self;
}

- (void)loadAllProperties {
    [self loadCurrency];
    [self loadText];
    [self loadValue];
}

- (void)loadCurrency {
    NSString *currency = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeFareCurrency];

    _currency = currency;
}

- (void)loadText {
    NSString *text = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeFareText];

    _text = text;
}

- (void)loadValue {
    NSNumber *value = [_dictionary objectForKey:kCGGoogleDirectionsResponseAttributeFareValue];

    _value = value;
}

@end
