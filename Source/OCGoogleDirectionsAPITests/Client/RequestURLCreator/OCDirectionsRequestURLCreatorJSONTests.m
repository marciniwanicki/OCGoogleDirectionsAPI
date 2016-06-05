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

static NSString *const kTestKey = @"0123456789abcdef";

@interface OCDirectionsRequestURLCreatorJSONTests : XCTestCase

@property(nonatomic, strong) OCDirectionsRequestURLCreatorJSON *urlCreator;

@end

@implementation OCDirectionsRequestURLCreatorJSONTests

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (void)setUp {
    [super setUp];

    self.urlCreator = [OCDirectionsRequestURLCreatorJSON new];
}

- (void)tearDown {
    self.urlCreator = nil;

    [super tearDown];
}

- (void)testConformsToOCDiretionsRequestURLCreatorProtocol {
    XCTAssertTrue([self.urlCreator conformsToProtocol:@protocol(OCDirectionsRequestURLCreator)]);
}

#pragma mark - Test stringFromRequest:useHttps:andKey: when arguments are invalid

- (void)testStringFromRequestWhenRequestIsNil {
    // given
    OCDirectionsRequest *request = nil;
    NSString *key = [self prepareTestKey];

    // then
    XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
}

- (void)testStringFromRequestWhenKeyIsNil {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    NSString *key = nil;

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false", urlString);
}

- (void)testStringFromRequestWhenRequestAndKeyAreNil {
    // given
    OCDirectionsRequest *request = nil;
    NSString *key = nil;

    // then
    XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
}

#pragma mark - Test stringFromRequest:useHttps:andKey: when arguments are valid

- (void)testStringFromRequestWhenAllArgumentsAreValid {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenAllArgumentsAreValidButNoSensor {
    // given
    OCDirectionsRequest *request = [self prepareNoSensorRequest];
    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenSensorIsTrue {
    // given
    OCDirectionsRequest *request = [self prepareRequestWithSensor];
    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=true&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenOriginAndDestinationAreLocations {
    // given
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:[self prepareFirstLocation]
                                                           andDestinationLocation:[self prepareSecondLocation]
                                                                           sensor:NO];
    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=20.100000,30.100000&destination=40.100000,50.100000&sensor=false&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenOriginAndDestinationAreLocationsButNoSensor {
    // given
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:[self prepareFirstLocation]
                                                           andDestinationLocation:[self prepareSecondLocation]];
    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=20.100000,30.100000&destination=40.100000,50.100000&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenOriginIsStringAndDestinationIsLocation {
    // given
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"Lodz"
                                                         andDestinationLocation:[self prepareSecondLocation]
                                                                         sensor:NO];
    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=Lodz&destination=40.100000,50.100000&sensor=false&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenOriginIsLocationAndDestinationIsString {
    // given
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginLocation:[self prepareFirstLocation]
                                                             andDestinationString:@"Lodz"
                                                                           sensor:NO];
    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=20.100000,30.100000&destination=Lodz&sensor=false&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenTravelModeIsDriving {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.travelMode = OCDirectionsRequestTravelModeDriving;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&key=0123456789abcdef", urlString); // no mode parameter, it is default mode
}

- (void)testStringFromRequestWhenTravelModeIsWalking {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.travelMode = OCDirectionsRequestTravelModeWalking;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&mode=walking&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenTravelModeIsBicycling {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.travelMode = OCDirectionsRequestTravelModeBicycling;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&mode=bicycling&key=0123456789abcdef", urlString);
}

- (void)testStringFromRequestWhenTravelModeIsTransit {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.travelMode = OCDirectionsRequestTravelModeTransit;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertNotNil(urlString);
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&mode=transit&key=0123456789abcdef", urlString);
}

- (void)testStringWhenUnitsIsSet {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.unit = OCDirectionsRequestUnitMetric;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&units=metric&key=0123456789abcdef", urlString);
}

- (void)testStringWhenArrivalTimeIsSet {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.arrivalTime = [NSDate dateWithTimeIntervalSince1970:2524668300000];

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&arrival_time=2524668300000&key=0123456789abcdef", urlString);
}

- (void)testStringWhenDepartureTimeIsSet {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.departureTime = [NSDate dateWithTimeIntervalSince1970:2524668300000];

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&departure_time=2524668300000&key=0123456789abcdef", urlString);
}

- (void)testStringWhenDepartureTimeIsNow {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.departureTime = kOCDirectionsRequestDepartureTimeNow;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&departure_time=now&key=0123456789abcdef", urlString);
}

- (void)testStringWhenTrafficModelIsOptimistic {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.trafficModel = OCDirectionsRequestTrafficModelOptimistic;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&traffic_model=optimistic&key=0123456789abcdef", urlString);

}

- (void)testStringWhenTransitModeIsNotSpecified {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.transitMode = OCDirectionsRequestTransitModeDefault;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&key=0123456789abcdef", urlString);
}

- (void)testStringWhenTransitModeIsBus {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.transitMode = OCDirectionsRequestTransitModeBus;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&transit_mode=bus&key=0123456789abcdef", urlString);
}

- (void)testStringWhenTransitModeIsRail {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.transitMode = OCDirectionsRequestTransitModeRail;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&transit_mode=rail&key=0123456789abcdef", urlString);
}

- (void)testStringWhenTransitModeIsSubwayAndTram {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.transitMode = OCDirectionsRequestTransitModeSubway | OCDirectionsRequestTransitModeTram;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&transit_mode=subway%7Ctram&key=0123456789abcdef", urlString);
}

- (void)testStringWhenTransitRoutingPreferenceIsLessWalking {
    // given
    OCDirectionsRequest *request = [self prepareRequest];
    request.transitRoutingPreference = OCDirectionsRequestTransitRoutingPreferenceLessWalking;

    NSString *key = [self prepareTestKey];

    // when
    NSString *urlString = [self.urlCreator stringFromRequest:request useHttps:YES andKey:key];

    // then
    XCTAssertEqualObjects(@"https://maps.googleapis.com/maps/api/directions/json?origin=London&destination=Lodz&sensor=false&transit_routing_preference=less_walking&key=0123456789abcdef", urlString);
}

#pragma mark - Helpers

- (NSString *)prepareTestKey {
    return kTestKey;
}

- (OCDirectionsRequest *)prepareRequest {
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"London" andDestinationString:@"Lodz" sensor:NO];
    return request;
}

- (OCDirectionsRequest *)prepareNoSensorRequest {
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"London" andDestinationString:@"Lodz"];
    return request;
}

- (OCDirectionsRequest *)prepareRequestWithSensor {
    OCDirectionsRequest *request = [OCDirectionsRequest requestWithOriginString:@"London" andDestinationString:@"Lodz" sensor:YES];
    return request;
}

- (CLLocation *)prepareFirstLocation {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:20.1 longitude:30.1];
    return location;
}

- (CLLocation *)prepareSecondLocation {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.1 longitude:50.1];
    return location;
}

#pragma clang diagnostic pop

@end
