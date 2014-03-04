//
//  OCDirectionsRequestValidator.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDirectionsRequest.h"

@interface OCDirectionsRequestValidator : NSObject

- (BOOL)isValid:(OCDirectionsRequest *)request;

@end
