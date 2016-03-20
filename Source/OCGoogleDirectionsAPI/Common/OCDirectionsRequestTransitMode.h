//
//  OCDirectionsRequestTravelMode.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 3/20/16.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, OCDirectionsRequestTransitMode) {
    /**
     * not specified
     */
            OCDirectionsRequestTransitModeDefault = 0,

    /**
     * indicates that the calculated route should prefer travel by bus.
     */
            OCDirectionsRequestTransitModeBus = 1 << 1,

    /**
     * indicates that the calculated route should prefer travel by subway.
     */
            OCDirectionsRequestTransitModeSubway = 1 << 2,

    /**
     * indicates that the calculated route should prefer travel by train.
     */
            OCDirectionsRequestTransitModeTrain = 1 << 3,

    /**
     * indicates that the calculated route should prefer travel by tram and light rail.
     */
            OCDirectionsRequestTransitModeTram = 1 << 4,

    /**
     * indicates that the calculated route should prefer travel by train, tram, light rail, and subway.
     * This is equivalent to train|tram|subway.
     */
            OCDirectionsRequestTransitModeRail = 1 << 5
};
