//
//  OCDirectionsRequestURLCreatorJSON.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsRequestURLCreatorJSON.h"
#import "OCAssertParameter.h"

static NSString *const kOCGoogleDirectionsAPIHTTP = @"http://";
static NSString *const kOCGoogleDirectionsAPIHTTPS = @"https://";
static NSString *const kOCGoogleDirectionsAPIJSON = @"maps.googleapis.com/maps/api/directions/json?";

static NSString *const kOCGoogleDirectionsRequestAttributeOrigin = @"origin=";
static NSString *const kOCGoogleDirectionsRequestAttributeDestination = @"&destination=";
static NSString *const kOCGoogleDirectionsRequestAttributeSensor = @"&sensor=";
static NSString *const kOCGoogleDirectionsRequestAttributeTravelMode = @"&mode=";
static NSString *const kOCGoogleDirectionsRequestAttributeWaypoints = @"&waypoints=";
static NSString *const kOCGoogleDirectionsRequestAttributeWaypointsOptimize = @"optimize:true";
static NSString *const kOCGoogleDirectionsRequestAttributeRestrictions = @"&avoid=";
static NSString *const kOCGoogleDirectionsRequestAttributeUnits = @"&units=";
static NSString *const kOCGoogleDirectionsRequestAttributeRegion = @"&region=";
static NSString *const kOCGoogleDirectionsRequestAttributeArrivalTime = @"&arrival_time=";
static NSString *const kOCGoogleDirectionsRequestAttributeDepartureTime = @"&departure_time=";
static NSString *const kOCGoogleDirectionsRequestAttributeLanguage = @"&language=";
static NSString *const kOCGoogleDirectionsRequestAttributeKey = @"&key=";
static NSString *const kOCGoogleDirectionsRequestAttributeAlternatives = @"&alternatives=";
static NSString *const kOCGoogleDirectionsRequestAttributeTrafficModel = @"&traffic_model=";
static NSString *const kOCGoogleDirectionsRequestAttributeTransitMode = @"&transit_mode=";
static NSString *const kOCGoogleDirectionsRequestAttributeTransitRoutingPreference = @"&transit_routing_preference=";

static NSString *const kOCGoogleDirectionsRequestAttributeSeparator = @"|";

static NSString *const kOCGoogleDirectionsRequestAttributeValueDepartureTimeNow = @"now";

@implementation OCDirectionsRequestURLCreatorJSON

#pragma mark - Public methods

- (NSString *)stringFromRequest:(OCDirectionsRequest *)request useHttps:(BOOL)useHttps andKey:(NSString *)key {
    OCAssertParameterNotNil(request, @"Request is nil.");

    NSMutableString *string = [self baseStringWithHttps:useHttps];

    [self appendOrigin:request toString:string];
    [self appendDestination:request toString:string];
    [self appendSensor:request toString:string];
    [self appendTravelMode:request toString:string];
    [self appendWaypoints:request toString:string];
    [self appendRestrictions:request toString:string];
    [self appendLanguage:request toString:string];
    [self appendUnit:request toString:string];
    [self appendRegion:request toString:string];
    [self appendArrivalTime:request toString:string];
    [self appendDepartureTime:request toString:string];
    [self appendAlternatives:request toString:string];
    [self appendTrafficModel:request toString:string];
    [self appendTransitMode:request toString:string];
    [self appendTransitRoutingPreference:request toString:string];
    [self appendKey:key toString:string];

    return string;
}

- (NSURL *)urlFromRequest:(OCDirectionsRequest *)request useHttps:(BOOL)useHttps andKey:(NSString *)key {
    OCAssertParameterNotNil(request, @"Request is nil.");
    OCAssertParameterNotNil(key, @"Key is nil.");

    NSString *requestString = [self stringFromRequest:request useHttps:useHttps andKey:key];
    NSURL *url = [[NSURL alloc] initWithString:requestString];
    return url;
}

#pragma mark - Private methods

- (NSMutableString *)baseStringWithHttps:(BOOL)useHttps {
    NSMutableString *baseString = [NSMutableString new];
    if (useHttps) {
        [baseString appendString:kOCGoogleDirectionsAPIHTTPS];
    } else {
        [baseString appendString:kOCGoogleDirectionsAPIHTTP];
    }
    [baseString appendString:kOCGoogleDirectionsAPIJSON];

    return baseString;
}

#pragma mark -

- (void)appendOrigin:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    [string appendString:kOCGoogleDirectionsRequestAttributeOrigin];

    if (request.originLocation) {
        NSString *originString = [self stringFormCLLocation:request.originLocation];
        [string appendString:originString];
    } else {
        [string appendString:[self encodeParameter:request.originString]];
    }
}

- (void)appendDestination:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    [string appendString:kOCGoogleDirectionsRequestAttributeDestination];

    if (request.destinationLocation) {
        NSString *destinationString = [self stringFormCLLocation:request.destinationLocation];
        [string appendString:destinationString];
    } else {
        [string appendString:[self encodeParameter:request.destinationString]];
    }
}

- (void)appendSensor:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    /*
        Checks if sensor flag is set. If no, just skip it as it is no longer required.
     */
    if (!request.sensorFlagUsed) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeSensor];

    NSString *sensorString = [self stringFromBOOL:request.sensor];
    [string appendString:sensorString];
}

- (void)appendTravelMode:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.travelMode == OCDirectionsRequestTravelModeDriving) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeTravelMode];

    NSString *travelModeString = [OCDirectionsCommonTypes stringFormTravelMode:request.travelMode];
    [string appendString:travelModeString];
}

- (void)appendWaypoints:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.waypoints == nil) {
        return;
    }

    if ([request.waypoints count] == 0) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeWaypoints];

    if (request.waypointsOptimise) {
        [string appendString:kOCGoogleDirectionsRequestAttributeWaypointsOptimize];
        [string appendString:[self encodeParameter:kOCGoogleDirectionsRequestAttributeSeparator]];
    }

    NSUInteger count = [request.waypoints count];
    NSUInteger iter = 0;
    for (id <NSObject> waypoint in request.waypoints) {
        if ([waypoint isKindOfClass:[NSString class]]) {
            NSString *waypointString = (NSString *) waypoint;
            [string appendString:[self encodeParameter:waypointString]];
        } else if ([waypoint isKindOfClass:[CLLocation class]]) {
            CLLocation *waypointLocation = (CLLocation *) waypoint;
            NSString *waypointString = [self stringFormCLLocation:waypointLocation];
            [string appendString:[self encodeParameter:waypointString]];
        }

        if (++iter < count) {
            [string appendString:[self encodeParameter:kOCGoogleDirectionsRequestAttributeSeparator]];
        }
    }
}

- (void)appendRestrictions:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.restrictions == nil) {
        return;
    }

    if ([request.restrictions count] == 0) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeRestrictions];

    NSUInteger count = [request.waypoints count];
    NSUInteger iter = 0;
    for (NSString *restriction in request.restrictions) {
        [string appendString:[self encodeParameter:restriction]];

        if (++iter < count) {
            [string appendString:[self encodeParameter:kOCGoogleDirectionsRequestAttributeSeparator]];
        }
    }
}

- (void)appendUnit:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.unit == OCDirectionsRequestUnitDefault) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeUnits];

    NSString *unitString = [self stringFormUnit:request.unit];
    [string appendString:unitString];
}

- (void)appendRegion:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.region == nil) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeRegion];
    [string appendString:[self encodeParameter:request.region]];
}

- (void)appendArrivalTime:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.arrivalTime == nil) {
        return;
    }

    NSString *arrivalTimeValue = @(request.arrivalTime.timeIntervalSince1970).stringValue;

    [string appendString:kOCGoogleDirectionsRequestAttributeArrivalTime];
    [string appendString:arrivalTimeValue];
}

- (void)appendDepartureTime:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.departureTime == nil) {
        return;
    }

    NSString *departureTimeString = [request.departureTime isEqualToDate:kOCDirectionsRequestDepartureTimeNow]
            ? kOCGoogleDirectionsRequestAttributeValueDepartureTimeNow
            : @(request.departureTime.timeIntervalSince1970).stringValue;

    [string appendString:kOCGoogleDirectionsRequestAttributeDepartureTime];
    [string appendString:departureTimeString];
}

- (void)appendLanguage:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.language == nil) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeLanguage];
    [string appendString:[self encodeParameter:request.language]];
}

- (void)appendAlternatives:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (!request.alternatives) {
        return;
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeAlternatives];

    NSString *alternativesString = [self stringFromBOOL:request.alternatives];
    [string appendString:alternativesString];
}

- (void)appendTrafficModel:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.trafficModel == OCDirectionsRequestTrafficModelDefault) {
        return;
    }

    NSString *trafficModelString = [OCDirectionsCommonTypes stringFromTrafficModel:request.trafficModel];

    [string appendString:kOCGoogleDirectionsRequestAttributeTrafficModel];
    [string appendString:trafficModelString];
}

- (void)appendTransitMode:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.transitMode == OCDirectionsRequestTransitModeDefault) {
        return;
    }

    NSMutableString *transitModeString = [NSMutableString string];
    for (NSUInteger transitMode = OCDirectionsRequestTransitModeBus;
         transitMode < (OCDirectionsRequestTransitModeRail << 1);
         transitMode <<= 1) {

        if ((request.transitMode & transitMode) == 0) {
            continue;
        }

        if (transitModeString.length > 0) {
            [transitModeString appendString:[self encodeParameter:kOCGoogleDirectionsRequestAttributeSeparator]];
        }

        [transitModeString appendString:[OCDirectionsCommonTypes stringFromTransitModel:transitMode]];
    }

    [string appendString:kOCGoogleDirectionsRequestAttributeTransitMode];
    [string appendString:transitModeString];
}

- (void)appendTransitRoutingPreference:(OCDirectionsRequest *)request toString:(NSMutableString *)string {
    if (request.transitRoutingPreference == OCDirectionsRequestTransitRoutingPreferenceDefault) {
        return;
    }

    NSString *transitRoutingPreferenceString = [OCDirectionsCommonTypes stringFromTransitRoutingPreference:request.transitRoutingPreference];
    [string appendString:kOCGoogleDirectionsRequestAttributeTransitRoutingPreference];
    [string appendString:transitRoutingPreferenceString];
}

- (void)appendKey:(NSString *)key toString:(NSMutableString *)string {
    /**
     API key is not required.
     */
    if (key) {
        [string appendString:kOCGoogleDirectionsRequestAttributeKey];
        [string appendString:[self encodeParameter:key]];
    }
}

#pragma mark - Helpers

- (NSString *)stringFormCLLocation:(CLLocation *)location {
    NSString *string = [NSString stringWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    return string;
}

- (NSString *)stringFromBOOL:(BOOL)boolValue {
    NSString *string = boolValue ? @"true" : @"false";
    return string;
}


- (NSString *)stringFormUnit:(OCDirectionsRequestUnit)unit {
    switch (unit) {
        case OCDirectionsRequestUnitDefault:
            return @""; // should never happen
        case OCDirectionsRequestUnitImperial:
            return @"imperial";
        case OCDirectionsRequestUnitMetric:
            return @"metric";
    }
    return @"";
}

- (NSString *)encodeParameter:(NSString *)parameter {
    NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
    NSString *encodedParameter = [parameter stringByAddingPercentEncodingWithAllowedCharacters:set];
    return encodedParameter;
}

@end
