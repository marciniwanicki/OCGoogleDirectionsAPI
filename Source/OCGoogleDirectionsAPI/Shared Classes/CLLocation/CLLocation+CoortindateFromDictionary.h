//
//  CLLocation+CoortindateFromDictionary.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (CoortindateFromDictionary)

+ (CLLocationCoordinate2D)coordinateFromDictionary:(NSDictionary *)dictionary;

@end
