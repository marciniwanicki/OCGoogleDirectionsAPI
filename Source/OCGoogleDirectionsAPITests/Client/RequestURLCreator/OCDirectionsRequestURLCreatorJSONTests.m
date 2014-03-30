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

static NSString *const kTestKey = @"0123456789abcde";

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

#pragma mark - Test when arguments are invalid
- (void)testWhenRequestIsNil
{
	// given
	OCDirectionsRequest *request = nil;
	NSString *key = [self prepareTestKey];
	
	// then
	XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
}

- (void)testWhenKeyIsNil
{
	// given
	OCDirectionsRequest *request = [self prepareRequest];
	NSString *key = nil;
	
	// then
	XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
}

- (void)testWhenRequestAndKeyAreNil
{
	// given
	OCDirectionsRequest *request = nil;
	NSString *key = nil;
	
	// then
	XCTAssertThrowsSpecificNamed([self.urlCreator stringFromRequest:request useHttps:YES andKey:key], NSException, NSInvalidArgumentException);
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

@end
