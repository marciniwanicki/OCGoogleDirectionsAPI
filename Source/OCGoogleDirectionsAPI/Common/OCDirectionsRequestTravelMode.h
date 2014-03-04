//
//  OCDirectionsRequestTravelMode.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

typedef NS_ENUM(NSUInteger, OCDirectionsRequestTravelMode) {
    /**
     (default) indicates standard driving directions using the road
     */
    OCDirectionsRequestTravelModeDriving,
    
    /**
     requests walking directions via pedestrian paths & sidewalks (where available).
     */
    OCDirectionsRequestTravelModeWalking,
    
    /**
     requests bicycling directions via bicycle paths & preferred streets (where available).
     */
    OCDirectionsRequestTravelModeBicycling,
    
    /**
     requests directions via public transit routes (where available).
     */
    OCDirectionsRequestTravelModeTransit
};