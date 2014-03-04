//
//  OCDirectionsRequestRestriction.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

typedef NS_ENUM(NSUInteger, OCDirectionsRequestRestriction) {
    /**
     avoid tools
     */
    OCDirectionsRequestRestrictionAvoidTolls,
    
    /**
     avoid highways
     */
    OCDirectionsRequestRestrictionAvoidHighways,
    
    /**
     avoid ferries
     */
    OCDirectionsRequestRestrictionAviodFerries
};
