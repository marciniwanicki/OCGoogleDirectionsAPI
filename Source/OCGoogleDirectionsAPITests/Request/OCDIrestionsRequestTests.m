//
//  OCDIrestionsRequestTests.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 3/11/14.
//
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "OCDirectionsRequest.h"

@interface OCDIrestionsRequestTests : XCTestCase

@end

@implementation OCDIrestionsRequestTests

#pragma mark - Test helpers
- (void)testPrepareFirstLocationHelper
{
	// when
	CLLocation *location = [self prepareFirstLocation];
	
	// then
	XCTAssertNotNil(location);
	XCTAssertTrue([location isMemberOfClass:[CLLocation class]]);
}

- (void)testPrepareSecondLocationHelper
{
	// when
	CLLocation *location = [self prepareSecondLocation];
	
	// then
	XCTAssertNotNil(location);
	XCTAssertTrue([location isMemberOfClass:[CLLocation class]]);
}

#pragma mark - Test requestWithOriginLocation:andDestinationLocation:sensor:
- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginIsNil
{
	// given
	CLLocation *originLocation = nil;
	CLLocation *destinationLocation = [self prepareSecondLocation];
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginLocation:originLocation
								andDestinationLocation:destinationLocation
												sensor:NO];
		
	}];
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenDestinationIsNil
{
	// given
	CLLocation *originLocation = [self prepareFirstLocation];
	CLLocation *destinationLocation = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginLocation:originLocation
								andDestinationLocation:destinationLocation
												sensor:NO];
		
	}];
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginAndDestinationAreNil
{
	// given
	CLLocation *originLocation = nil;
	CLLocation *destinationLocation = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginLocation:originLocation
								andDestinationLocation:destinationLocation
												sensor:NO];
		
	}];
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginAndDestinationAreNotNil
{
	// given
	CLLocation *originLocation = [self prepareFirstLocation];
	CLLocation *destinationLocation = [self prepareSecondLocation];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
															   andDestinationLocation:destinationLocation
																			   sensor:NO];
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originLocation, request.originLocation);
	XCTAssertNil(request.originString);
	XCTAssertEqual(destinationLocation, request.destinationLocation);
	XCTAssertNil(request.destinationString);
	XCTAssertFalse(request.sensor);
	
	[self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginLocationAndDestinationLocationWhenOriginAndDestinationAreNotNilAndSensorIsTrue
{
	// given
	CLLocation *originLocation = [self prepareFirstLocation];
	CLLocation *destinationLocation = [self prepareSecondLocation];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
														   andDestinationLocation:destinationLocation
																		   sensor:YES];
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originLocation, request.originLocation);
	XCTAssertNil(request.originString);
	XCTAssertEqual(destinationLocation, request.destinationLocation);
	XCTAssertNil(request.destinationString);
	XCTAssertTrue(request.sensor);
	
	[self verifyPropertiesWithDefaultValuesOfRequest:request];
}

#pragma mark - Custom verifiers
- (void)verifyPropertiesWithDefaultValuesOfRequest:(OCDirectionsRequest *)request
{
	XCTAssertFalse(request.alternatives);
	XCTAssertTrue(request.isValid);
	XCTAssertEqual(OCDirectionsRequestTravelModeDriving, request.travelMode);
	XCTAssertEqual(OCDirectionsRequestUnitDefault, request.unit);
	XCTAssertNil(request.waypoints);
	XCTAssertFalse(request.waypointsOptimise);
}

- (void)verifyIfNSInvalidArgumentExceptionHasBeenThrown:(void(^)())block
{
	BOOL exceptionOccured = NO;
	
	@try {
		block();
		
		XCTFail(@"An exception should be thrown.");
	}
	@catch (NSException *exception) {
		if ([exception.name isEqualToString:NSInvalidArgumentException]) {
			exceptionOccured = YES;
		}
	}
	
	XCTAssertTrue(exceptionOccured, @"NSInvalidArgumentException should be thrown.");
}

#pragma mark - Helpers
- (CLLocation *)prepareFirstLocation
{
	CLLocation *location = [[CLLocation alloc] initWithLatitude:10.0 longitude:20.0];
	return location;
}

- (CLLocation *)prepareSecondLocation
{
	CLLocation *location = [[CLLocation alloc] initWithLatitude:30.0 longitude:40.0];
	return location;
}

@end
