//
//  OCAssertParameter.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/24/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OCAssertParameter(condition, args...) if (!condition) [NSException raise:NSInvalidArgumentException format:args];
#define OCAssertParameterNotNil(parameter, args...) OCAssertParameter(parameter, args);