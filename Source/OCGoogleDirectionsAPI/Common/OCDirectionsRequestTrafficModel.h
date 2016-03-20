//
//  OCDirectionsRequestTrafficModel.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 3/20/16.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//


typedef NS_ENUM(NSUInteger, OCDirectionsRequestTrafficModel) {
    /**
     * not specified
     */
            OCDirectionsRequestTrafficModelDefault,

    /**
     * (default) indicates that the returned duration_in_traffic should be the best estimate of travel time given
     * what is known about both historical traffic conditions and live traffic.
     * Live traffic becomes more important the closer the departure_time is to now.
     */
            OCDirectionsRequestTrafficModelBestGuess,

    /**
     * indicates that the returned duration_in_traffic should be longer than the actual travel time on most days,
     * though occasional days with particularly bad traffic conditions may exceed this value.
     */
            OCDirectionsRequestTrafficModelPessimistic,

    /**
     * indicates that the returned duration_in_traffic should be shorter than the actual travel time on most days,
     * though occasional days with particularly good traffic conditions may be faster than this value.
     */
            OCDirectionsRequestTrafficModelOptimistic
};
