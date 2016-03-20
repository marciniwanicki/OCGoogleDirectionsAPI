//
//  OCDirectionsRequestTrafficModel.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 3/20/16.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//


typedef NS_ENUM(NSUInteger, OCDirectionsRequestTransitRoutingPreference) {
    /**
     * not specified
     */
            OCDirectionsRequestTransitRoutingPreferenceDefault,

    /**
     * indicates that the calculated route should prefer limited amounts of walking.
     */
            OCDirectionsRequestTransitRoutingPreferenceLessWalking,

    /**
     * indicates that the calculated route should prefer a limited number of transfers.
     */
            OCDirectionsRequestTransitRoutingPreferenceFewerTransfers
};
