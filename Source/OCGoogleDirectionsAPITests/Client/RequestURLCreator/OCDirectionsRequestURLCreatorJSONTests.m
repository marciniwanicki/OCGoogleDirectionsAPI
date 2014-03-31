//
//  OCDirectionsRequestURLCreatorJSONTests.m
//  OCGoogleDirectionsAPI
//
//  Created by Marcin Iwanicki on 3/30/14.
//
//

#import <XCTest/XCTest.h>
#import "OCDirectionsRequestURLCreator.h"
#import "OCDirectionsRequestURLCreatorJSON.h"
#import "OCDirectionsRequest.h"
#import "OCDirectionsResponse.h"

static NSString *const kTestKey = @"0123456789abcdef";

@interface OCDirectionsRequestURLCreatorJSONTests : XCTestCase

@property (nonatomic, strong) OCDirectionsRequestURLCreatorJSON *urlCreator;

@end

@implementation OCDirectionsRequestURLCreatorJSONTests

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
									
- (OCDirectionsRequest *)prepareRequestWithSensor
{
	OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"London" andDestinationString:@"Lodz" sensor:YES];
	return request;
}

@end
