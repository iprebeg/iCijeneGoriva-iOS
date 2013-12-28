//
//  CijeneGorivaTests.m
//  CijeneGorivaTests
//
//  Created by Ivor Prebeg on 29/10/13.
//  Copyright (c) 2013 Ivor Prebeg. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ObjectLoader.h"
#import "CijeneGoriva-Prefix.pch"

@interface CijeneGorivaTests : XCTestCase<ObjectLoaderProtocol>

@property (nonatomic, strong) NSArray *objects;

@end

@implementation CijeneGorivaTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    self.objects = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAutoplin
{
    ObjectLoader *ol = [[ObjectLoader alloc] init];
    XCTAssert(ol != nil);
    
    NSString *url = [NSString stringWithFormat:@"%@?kategorija=Autoplin&distributeri=CRODUX,OMV,Lukoil,Petrol,Tifon,INA&Autocesta=DA",kURLGoriva];
    NSLog(@"using url: %@", url);

    [ol loadObjectsFromUrl:url forDelegate:self];
    
    NSDate *fiveSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [[NSRunLoop currentRunLoop] runUntilDate:fiveSecondsFromNow];
    
    XCTAssert(self.objects != nil);
    
    XCTAssert([self.objects count] > 0);
    
    NSLog(@"count:%d", [self.objects count]);
}

- (void)testSuper95
{
    ObjectLoader *ol = [[ObjectLoader alloc] init];
    XCTAssert(ol != nil);
    
    NSString *url = [NSString stringWithFormat:@"%@?kategorija=Super95&distributeri=CRODUX,OMV,Lukoil,Petrol,Tifon,INA&Autocesta=DA",kURLGoriva];
    NSLog(@"using url: %@", url);

    [ol loadObjectsFromUrl:url forDelegate:self];
    
    NSDate *fiveSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [[NSRunLoop currentRunLoop] runUntilDate:fiveSecondsFromNow];
    
    XCTAssert(self.objects != nil);
    
    XCTAssert([self.objects count] > 0);
    
    NSLog(@"count:%d", [self.objects count]);
}

- (void)testSuper98
{
    ObjectLoader *ol = [[ObjectLoader alloc] init];
    XCTAssert(ol != nil);
    
    NSString *url = [NSString stringWithFormat:@"%@?kategorija=Super98&distributeri=CRODUX,OMV,Lukoil,Petrol,Tifon,INA&Autocesta=DA",kURLGoriva];
    NSLog(@"using url: %@", url);

    [ol loadObjectsFromUrl:url forDelegate:self];
    
    NSDate *fiveSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [[NSRunLoop currentRunLoop] runUntilDate:fiveSecondsFromNow];
    
    XCTAssert(self.objects != nil);
    
    XCTAssert([self.objects count] > 0);
    
    NSLog(@"count:%d", [self.objects count]);
}

- (void)testLozulje
{
    ObjectLoader *ol = [[ObjectLoader alloc] init];
    XCTAssert(ol != nil);
    
    NSString *url = [NSString stringWithFormat:@"%@?kategorija=Lozulje&distributeri=CRODUX,OMV,Lukoil,Petrol,Tifon,INA&Autocesta=DA",kURLGoriva];
    NSLog(@"using url: %@", url);

    [ol loadObjectsFromUrl:url forDelegate:self];
    
    NSDate *fiveSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [[NSRunLoop currentRunLoop] runUntilDate:fiveSecondsFromNow];
    
    XCTAssert(self.objects != nil);
    
    XCTAssert([self.objects count] > 0);
    
    NSLog(@"count:%d", [self.objects count]);
}


- (void)testDizel
{
    ObjectLoader *ol = [[ObjectLoader alloc] init];
    XCTAssert(ol != nil);
    
    NSString *url = [NSString stringWithFormat:@"%@?kategorija=Dizel&distributeri=CRODUX,OMV,Lukoil,Petrol,Tifon,INA&Autocesta=DA",kURLGoriva];
    NSLog(@"using url: %@", url);
    
    [ol loadObjectsFromUrl:url forDelegate:self];
    
    NSDate *fiveSecondsFromNow = [NSDate dateWithTimeIntervalSinceNow:1.0];
    [[NSRunLoop currentRunLoop] runUntilDate:fiveSecondsFromNow];
    
    XCTAssert(self.objects != nil);
    
    XCTAssert([self.objects count] > 0);
    
    NSLog(@"count:%d", [self.objects count]);
}


- (void) didLoadObjects:(NSArray *)objects
{
    self.objects = objects;
    NSLog(@"callback invoked");
}

- (void) failedToLoadObjects:(NSError *)error
{
    NSLog(@"OMG Failed to load objects");
}

@end
