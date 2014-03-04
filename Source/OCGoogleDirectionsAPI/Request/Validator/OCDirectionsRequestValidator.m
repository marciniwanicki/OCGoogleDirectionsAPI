//
//  OCDirectionsRequestValidator.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import "OCDirectionsRequestValidator.h"


@implementation OCDirectionsRequestValidator

/**
 TODO: Finish me!
 */
- (BOOL)isValid:(OCDirectionsRequest *)request
{
    if (request.originLocation == nil && request.originString == nil) {
        return NO;
    }
    
    if (request.destinationLocation == nil && request.destinationString == nil) {
        return NO;
    }
    
    return YES;
}

@end
