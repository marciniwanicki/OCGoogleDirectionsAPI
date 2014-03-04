//
//  OCDirectionsResponseVehicleType.h
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 2/26/14.
//  Copyright (c) 2014 Marcin Iwanicki. All rights reserved.
//

typedef NS_ENUM(NSUInteger, OCDirectionsResponseVehicleType) {
    //    /**
    //     Not available.
    //     */
    //    OCDirectionsResponseVehicleTypeNotAvailable,
    
    /**
     Rail.
     */
    OCDirectionsResponseVehicleTypeRail,
    
    /**
     Light rail transit.
     */
    OCDirectionsResponseVehicleTypeMetroRail,
    
    /**
     Underground light rail.
     */
    OCDirectionsResponseVehicleTypeSubway,
    
    /**
     Above ground light rail.
     */
    OCDirectionsResponseVehicleTypeTram,
    
    /**
     Monorail.
     */
    OCDirectionsResponseVehicleTypeMonorail,
    
    /**
     Heavy rail.
     */
    OCDirectionsResponseVehicleTypeHeavyRail,
    
    /**
     Commuter rail.
     */
    OCDirectionsResponseVehicleTypeCommuterTrain,
    
    /**
     High speed train.
     */
    OCDirectionsResponseVehicleTypeHighSpeedTrain,
    
    /**
     Bus.
     */
    OCDirectionsResponseVehicleTypeBus,
    
    /**
     Intercity bus.
     */
    OCDirectionsResponseVehicleTypeIntercityBus,
    
    /**
     Trolleybus.
     */
    OCDirectionsResponseVehicleTypeTrolleybus,
    
    /**
     Share taxi is a kind of bus with the ability to drop off and pick up passengers anywhere on its route.
     */
    OCDirectionsResponseVehicleTypeShareTaxi,
    
    /**
     Ferry.
     */
    OCDirectionsResponseVehicleTypeFerry,
    
    /**
     A vehicle that operates on a cable, usually on the ground. Aerial cable cars may be of the type OCDirectionsResponseVehicleTypeGondolaLift.
     */
    OCDirectionsResponseVehicleTypeCableCar,
    
    /**
     An aerial cable car.
     */
    OCDirectionsResponseVehicleTypeGondolaLift,
    
    /**
     A vehicle that is pulled up a steep incline by a cable. A Funicular typically consists of two cars, with each car acting as a counterweight for the other.
     */
    OCDirectionsResponseVehicleTypeFunicular,
    
    /**
     All other vehicles will return this type.
     */
    OCDirectionsResponseVehicleTypeOther,
};
