//
//  OCDirectionsRequestUnit.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

typedef NS_ENUM(NSUInteger, OCDirectionsRequestUnit) {
    /**
     when not specified
     */
    OCDirectionsRequestUnitDefault,
    
    /**
     specifies usage of the metric system. Textual distances are returned using kilometers and meters.
     */
    OCDirectionsRequestUnitMetric,
    
    /**
     specifies usage of the Imperial (English) system. Textual distances are returned using miles and feet.
     */
    OCDirectionsRequestUnitImperial
};