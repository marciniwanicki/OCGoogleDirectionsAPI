//
//  OCDirectionsCommonTypes.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsCommonTypes.h"


@implementation OCDirectionsCommonTypes

@end

@implementation OCDirectionsCommonTypes (TravelMode)

+ (NSString *)stringFormTravelMode:(OCDirectionsRequestTravelMode)travelMode {
    NSArray *keys = [[self travelModeDictionary] allKeysForObject:@(travelMode)];
    return [keys firstObject];
}

+ (OCDirectionsRequestTravelMode)travelModeFromString:(NSString *)travelModeString {
    NSNumber *number = [self travelModeDictionary][travelModeString];
    OCDirectionsRequestTravelMode travelMode = (OCDirectionsRequestTravelMode) number.unsignedIntegerValue;
    return travelMode;
}

+ (NSDictionary *)travelModeDictionary {
    static NSDictionary *dictionary;

    if (dictionary == nil) {
        dictionary = @{
                @"driving" : @(OCDirectionsRequestTravelModeDriving),
                @"walking" : @(OCDirectionsRequestTravelModeWalking),
                @"bicycling" : @(OCDirectionsRequestTravelModeBicycling),
                @"transit" : @(OCDirectionsRequestTravelModeTransit)
        };
    }

    return dictionary;
}

@end

@implementation OCDirectionsCommonTypes (VehicalType)

+ (OCDirectionsResponseVehicleType)vehicleTypeFromString:(NSString *)vehicleTypeString {
    NSNumber *number = [self vehicleTypesDictionary][vehicleTypeString];
    OCDirectionsResponseVehicleType vehicleType = (OCDirectionsResponseVehicleType) number.unsignedIntegerValue;
    return vehicleType;
}

+ (NSDictionary *)vehicleTypesDictionary {
    static NSDictionary *dictionary;

    if (dictionary == nil) {
        dictionary = @{
                @"RAIL" : @(OCDirectionsResponseVehicleTypeRail),
                @"METRO_RAIL" : @(OCDirectionsResponseVehicleTypeMetroRail),
                @"SUBWAY" : @(OCDirectionsResponseVehicleTypeSubway),
                @"TRAM" : @(OCDirectionsResponseVehicleTypeTram),
                @"MONORAIL" : @(OCDirectionsResponseVehicleTypeMonorail),
                @"HEAVY_RAIL" : @(OCDirectionsResponseVehicleTypeHeavyRail),
                @"COMMUTER_TRAIN" : @(OCDirectionsResponseVehicleTypeCommuterTrain),
                @"HIGH_SPEED_TRAIN" : @(OCDirectionsResponseVehicleTypeHighSpeedTrain),
                @"BUS" : @(OCDirectionsResponseVehicleTypeBus),
                @"INTERCITY_BUS" : @(OCDirectionsResponseVehicleTypeIntercityBus),
                @"TROLLEYBUS" : @(OCDirectionsResponseVehicleTypeTrolleybus),
                @"SHARE_TAXI" : @(OCDirectionsResponseVehicleTypeShareTaxi),
                @"FERRY" : @(OCDirectionsResponseVehicleTypeFerry),
                @"CABLE_CAR" : @(OCDirectionsResponseVehicleTypeCableCar),
                @"GONDOLA_LIFT" : @(OCDirectionsResponseVehicleTypeGondolaLift),
                @"FUNICULAR" : @(OCDirectionsResponseVehicleTypeFunicular),
                @"OTHER" : @(OCDirectionsResponseVehicleTypeOther)
        };
    }

    return dictionary;
}

@end

@implementation OCDirectionsCommonTypes (TransitMode)

+ (NSString *)stringFromTransitModel:(OCDirectionsRequestTransitMode)transitMode {
    return [self transitModeDictionary][@(transitMode)];
}

+ (NSDictionary *)transitModeDictionary {
    static NSDictionary *transitModeDictionary;
    if (transitModeDictionary == nil) {
        transitModeDictionary = @{
                @(OCDirectionsRequestTransitModeBus) : @"bus",
                @(OCDirectionsRequestTransitModeSubway) : @"subway",
                @(OCDirectionsRequestTransitModeTrain) : @"train",
                @(OCDirectionsRequestTransitModeTram) : @"tram",
                @(OCDirectionsRequestTransitModeRail) : @"rail"
        };
    }
    return transitModeDictionary;
}

@end

@implementation OCDirectionsCommonTypes (TrafficModel)

+ (NSString *)stringFromTrafficModel:(OCDirectionsRequestTrafficModel)trafficModel {
    return [self trafficModelDictionary][@(trafficModel)];
}

+ (NSDictionary *)trafficModelDictionary {
    static NSDictionary *trafficModelDictionary;
    if (trafficModelDictionary == nil) {
        trafficModelDictionary = @{
                @(OCDirectionsRequestTrafficModelBestGuess) : @"best_guess",
                @(OCDirectionsRequestTrafficModelPessimistic) : @"pessimistic",
                @(OCDirectionsRequestTrafficModelOptimistic) : @"optimistic"
        };
    }
    return trafficModelDictionary;
}

@end

@implementation OCDirectionsCommonTypes (TransitRoutingPreference)

+ (NSString *)stringFromTransitRoutingPreference:(OCDirectionsRequestTransitRoutingPreference)transitRoutingPreference {
    return [self transitRoutingPreferenceDictionary][@(transitRoutingPreference)];
}

+ (NSDictionary *)transitRoutingPreferenceDictionary {
    static NSDictionary *transitRoutingPreference;
    if (transitRoutingPreference == nil) {
        transitRoutingPreference = @{
                @(OCDirectionsRequestTransitRoutingPreferenceLessWalking) : @"less_walking",
                @(OCDirectionsRequestTransitRoutingPreferenceFewerTransfers) : @"fewer_transfers",
        };
    }
    return transitRoutingPreference;
}

@end
