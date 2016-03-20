//
//  OCDirectionsCommonTypes.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OCDirectionsRequestTravelMode.h"
#import "OCDirectionsRequestRestriction.h"
#import "OCDirectionsRequestUnit.h"
#import "OCDirectionsResponseVehicleType.h"
#import "OCDirectionsRequestTransitMode.h"
#import "OCDirectionsRequestTrafficModel.h"

@interface OCDirectionsCommonTypes : NSObject

@end

@interface OCDirectionsCommonTypes (TravelMode)

+ (NSString *)stringFormTravelMode:(OCDirectionsRequestTravelMode)travelMode;

+ (OCDirectionsRequestTravelMode)travelModeFromString:(NSString *)travelModeString;

+ (NSDictionary *)travelModeDictionary;

@end

@interface OCDirectionsCommonTypes (VehicalType)

+ (OCDirectionsResponseVehicleType)vehicleTypeFromString:(NSString *)vehicleTypeString;

+ (NSDictionary *)vehicleTypesDictionary;

@end

@interface OCDirectionsCommonTypes (TransitMode)

+ (NSString *)stringFromTransitModel:(OCDirectionsRequestTransitMode)transitMode;

+ (NSDictionary *)transitModeDictionary;

@end

@interface OCDirectionsCommonTypes (TrafficModel)

+ (NSString *)stringFromTrafficModel:(OCDirectionsRequestTrafficModel)trafficModel;

+ (NSDictionary *)trafficModelDictionary;

@end