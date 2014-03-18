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

- (void)testPrepareFirstStringHelper
{
	// when
	NSString *string = [self prepareFirstString];
	
	// then
	XCTAssertNotNil(string);
	XCTAssertEqual(@"London", string);
}

- (void)testPreapreSecondStringHelper
{
	// when
	NSString *string = [self prepareSecondString];
	
	// then
	XCTAssertNotNil(string);
	XCTAssertEqual(@"Reading", string);
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

#pragma mark - Test requestWithOriginString:andDestinationLocation:sensor:
- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginIsNil
{
	// given
	NSString *originString = nil;
	CLLocation *destinationLocation = [self prepareSecondLocation];
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginString:originString
							  andDestinationLocation:destinationLocation
											  sensor:NO];
		
	}];
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenDestinationIsNil
{
	// given
	NSString *originString = [self prepareFirstString];
	CLLocation *destinationLocation = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginString:originString
							  andDestinationLocation:destinationLocation
											  sensor:NO];
		
	}];
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginAndDestinationAreNil
{
	// given
	NSString *originString = nil;
	CLLocation *destinationLocation = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginString:originString
							  andDestinationLocation:destinationLocation
											  sensor:NO];
		
	}];
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginAndDestinationAreNotNil
{
	// given
	NSString *originString = [self prepareFirstString];
	CLLocation *destinationLocation = [self prepareSecondLocation];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
														 andDestinationLocation:destinationLocation
																		 sensor:NO];
	
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originString, request.originString);
	XCTAssertNil(request.originLocation);
	XCTAssertEqual(destinationLocation, request.destinationLocation);
	XCTAssertNil(request.destinationString);
	XCTAssertFalse(request.sensor);
	
	[self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginStringAndDestinationLocationWhenOriginAndDestinationAreNotNilAndSensorIsTrue
{
	// given
	NSString *originString = [self prepareFirstString];
	CLLocation *destinationLocation = [self prepareSecondLocation];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
														 andDestinationLocation:destinationLocation
																		 sensor:YES];
	
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originString, request.originString);
	XCTAssertNil(request.originLocation);
	XCTAssertEqual(destinationLocation, request.destinationLocation);
	XCTAssertNil(request.destinationString);
	XCTAssertTrue(request.sensor);
	
	[self verifyPropertiesWithDefaultValuesOfRequest:request];
}

#pragma mark - Test requestWithOriginLocation:andDestinationString:sensor:
- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginIsNil
{
	// given
	CLLocation *originLocation = nil;
	NSString *destinationString = [self prepareSecondString];
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginLocation:originLocation
								  andDestinationString:destinationString
												sensor:NO];
		
	}];
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenDestinationIsNil
{
	// given
	CLLocation *originLocation = [self prepareFirstLocation];
	NSString *destinationString = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginLocation:originLocation
								  andDestinationString:destinationString
												sensor:NO];
		
	}];
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginAndDestinationAreNil
{
	// given
	CLLocation *originLocation = nil;
	NSString *destinationString = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginLocation:originLocation
								  andDestinationString:destinationString
												sensor:NO];
		
	}];
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginAndDestinationAreNotNil
{
	// given
	CLLocation *originLocation = [self prepareFirstLocation];
	NSString *destinationString = [self prepareSecondString];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
															 andDestinationString:destinationString
																		   sensor:NO];
	
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originLocation, request.originLocation);
	XCTAssertNil(request.originString);
	XCTAssertEqual(destinationString, request.destinationString);
	XCTAssertNil(request.destinationLocation);
	XCTAssertFalse(request.sensor);
	
	[self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginLocationAndDestinationStringWhenOriginAndDestinationAreNotNilAndSensorIsTrue
{
	// given
	CLLocation *originLocation = [self prepareFirstLocation];
	NSString *destinationString = [self prepareSecondString];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:originLocation
															 andDestinationString:destinationString
																		   sensor:YES];
	
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originLocation, request.originLocation);
	XCTAssertNil(request.originString);
	XCTAssertEqual(destinationString, request.destinationString);
	XCTAssertNil(request.destinationLocation);
	XCTAssertTrue(request.sensor);
	
	[self verifyPropertiesWithDefaultValuesOfRequest:request];
}

#pragma mark - Test requestWithOriginString:andDestinationString:sensor:
- (void)testRequestWithOriginStringAndDestinationStringWhenOriginIsNil
{
	// given
	NSString *originString = nil;
	NSString *destinationString = [self prepareSecondString];
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginString:originString
								andDestinationString:destinationString
											  sensor:NO];
		
	}];
}

- (void)testRequestWithOriginStringAndDestinationStringWhenDestinationIsNil
{
	// given
	NSString *originString = [self prepareFirstString];
	NSString *destinationString = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginString:originString
								andDestinationString:destinationString
											  sensor:NO];
		
	}];
}

- (void)testRequestWithOriginStringAndDestinationStringWhenOriginAndDestinationAreNil
{
	// given
	NSString *originString = nil;
	NSString *destinationString = nil;
	
    // then
	[self verifyIfNSInvalidArgumentExceptionHasBeenThrown:^{
		
		// when
		[OCDirectionsRequest requestWithOriginString:originString
								andDestinationString:destinationString
											  sensor:NO];
		
	}];
}

- (void)testRequestWithOriginStringAndDestinationStringWhenOriginAndDestinationAreNotNil
{
	// given
	NSString *originString = [self prepareFirstString];
	NSString *destinationString = [self prepareSecondString];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
														   andDestinationString:destinationString
																		 sensor:NO];
	
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originString, request.originString);
	XCTAssertNil(request.originLocation);
	XCTAssertEqual(destinationString, request.destinationString);
	XCTAssertNil(request.destinationLocation);
	XCTAssertFalse(request.sensor);
	
	[self verifyPropertiesWithDefaultValuesOfRequest:request];
}

- (void)testRequestWithOriginStringAndDestinationStringWhenOriginAndDestinationAreNotNilAndSensorIsTrue
{
	// given
	NSString *originString = [self prepareFirstString];
	NSString *destinationString = [self prepareSecondString];
	
	// when
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:originString
														   andDestinationString:destinationString
																		 sensor:YES];
	
	// then
	XCTAssertNotNil(request);
	XCTAssertTrue([request isMemberOfClass:[OCDirectionsRequest class]]);
	XCTAssertEqual(originString, request.originString);
	XCTAssertNil(request.originLocation);
	XCTAssertEqual(destinationString, request.destinationString);
	XCTAssertNil(request.destinationLocation);
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

- (NSString *)prepareFirstString
{
	NSString *string = @"London";
	return string;
}

- (NSString *)prepareSecondString
{
	NSString *string = @"Reading";
	return string;
}

@end
