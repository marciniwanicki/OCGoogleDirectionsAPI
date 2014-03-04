//
//  CLLocation+CoortindateFromDictionary.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "CLLocation+CoortindateFromDictionary.h"
#import <CoreLocation/CoreLocation.h>

static NSString *const kCGGoogleDirectionsResponseAttributeLat = @"lat";
static NSString *const kCGGoogleDirectionsResponseAttributeLng = @"lng";

@implementation CLLocation (CoortindateFromDictionary)

+ (CLLocationCoordinate2D)coordinateFromDictionary:(NSDictionary *)dictionary
{
    NSNumber *lat = [dictionary objectForKey:kCGGoogleDirectionsResponseAttributeLat];
    NSNumber *lng = [dictionary objectForKey:kCGGoogleDirectionsResponseAttributeLng];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat.doubleValue, lng.doubleValue);
    return coordinate;
}

@end
