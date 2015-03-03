//
//  OCDirectionsRequestURLCreatorJSONTests.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 3/30/14.
//
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>
#import "OCDirectionsRequestURLCreator.h"
#import "OCDirectionsRequestURLCreatorJSON.h"
#import "OCDirectionsRequest.h"
#import "OCDirectionsResponse.h"

static NSString *const kTestKey = @"0123456789abcdef";

@interface OCDirectionsRequestURLCreatorJSONTests : XCTestCase

@property (nonatomic, strong) OCDirectionsRequestURLCreatorJSON *urlCreator;

@end

@implementation OCDirectionsRequestURLCreatorJSONTests

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (void)setUp
{
    [super setUp];

	self.urlCreator = [OCDirectionsRequestURLCreatorJSON new];
}

- (void)tearDown
{
    self.urlCreator = nil;
	
    [super tearDown];
}

- (void)testConformsToOCDiretionsRequestURLCreatorProtocol
{
    XCTAssertTrue([self.urlCreator conformsToProtocol:@protocol(OCDirectionsRequestURLCreator)]);
}

#pragma mark - Test stringFromRequest:useHttps:andKey: when arguments are invalid
- (void)testStringFromRequestWhenRequestIsNil
{
	// given
	OCDirectionsRequest *request = nil;
	NSString *key = [self prepareTestKey];
	
	// then
	XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
}

- (void)testStringFromRequestWhenKeyIsNil
{
	// given
	OCDirectionsRequest *request = [self prepareRequest];
	NSString *key = nil;
	
	// then
	XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
}

- (void)testStringFromRequestWhenRequestAndKeyAreNil
{
	// given
	OCDirectionsRequest *request = nil;
	NSString *key = nil;
	
	// then
	XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
}

#pragma mark - Test stringFromRequest:useHttps:andKey: when arguments are valid
- (void)testStringFromRequestWhenAllArgumentsAreValid
{
	// given
	OCDirectionsRequest *request = [self prepareRequest];
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenAllArgumentsAreValidButNoSensor
{
	// given
	OCDirectionsRequest *request = [self prepareNoSensorRequest];
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenSensorIsTrue
{
	// given
	OCDirectionsRequest *request = [self prepareRequestWithSensor];
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=true&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenOriginAndDestinationAreLocations
{
	// given
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:[self prepareFirstLocation]
														   andDestinationLocation:[self prepareSecondLocation]
																		   sensor:NO];
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=20.100000,30.100000&destination=40.100000,50.100000&sensor=false&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenOriginAndDestinationAreLocationsButNoSensor
{
	// given
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:[self prepareFirstLocation]
														   andDestinationLocation:[self prepareSecondLocation]];
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=20.100000,30.100000&destination=40.100000,50.100000&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenOriginIsStringAndDestinationIsLocation
{
	// given
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"Lodz"
														 andDestinationLocation:[self prepareSecondLocation]
																		 sensor:NO];
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=Lodz&destination=40.100000,50.100000&sensor=false&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenOriginIsLocationAndDestinationIsString
{
	// given
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:[self prepareFirstLocation]
															 andDestinationString:@"Lodz"
																		   sensor:NO];
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=20.100000,30.100000&destination=Lodz&sensor=false&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenTravelModeIsDriving
{
	// given
	OCDirectionsRequest *request = [self prepareRequest];
	request.travelMode = OCDirectionsRequestTravelModeDriving;
	
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&key=0123456789abcdef", response); // no mode parameter, it is default mode
}

- (void)testStringFromRequestWhenTravelModeIsWalking
{
	// given
	OCDirectionsRequest *request = [self prepareRequest];
	request.travelMode = OCDirectionsRequestTravelModeWalking;
	
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&mode=walking&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenTravelModeIsBicycling
{
	// given
	OCDirectionsRequest *request = [self prepareRequest];
	request.travelMode = OCDirectionsRequestTravelModeBicycling;
	
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&mode=bicycling&key=0123456789abcdef", response);
}

- (void)testStringFromRequestWhenTravelModeIsTransit
{
	// given
	OCDirectionsRequest *request = [self prepareRequest];
	request.travelMode = OCDirectionsRequestTravelModeTransit;
	
	NSString *key = [self prepareTestKey];
	
	// when
	NSString *response = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];
	
	// then
	XCTAssertNotNil(response);
	XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&mode=transit&key=0123456789abcdef", response);
}

#pragma mark - Helpers
- (NSString *)prepareTestKey
{
	return kTestKey;
}

- (OCDirectionsRequest *)prepareRequest
{
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"London" andDestinationString:@"Lodz" sensor:NO];
	return request;
}

- (OCDirectionsRequest *)prepareNoSensorRequest
{
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"London" andDestinationString:@"Lodz"];
	return request;
}
									
- (OCDirectionsRequest *)prepareRequestWithSensor
{
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"London" andDestinationString:@"Lodz" sensor:YES];
	return request;
}

- (CLLocation *)prepareFirstLocation
{
	CLLocation *location = [[CLLocation alloc] initWithLatitude:20.1 longitude:30.1];
	return location;
}

- (CLLocation *)prepareSecondLocation
{
	CLLocation *location = [[CLLocation alloc] initWithLatitude:40.1 longitude:50.1];
	return location;
}

#pragma clang diagnostic pop

@end
