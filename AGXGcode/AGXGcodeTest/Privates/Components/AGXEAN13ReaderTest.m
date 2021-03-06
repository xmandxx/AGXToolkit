//
//  AGXEAN13ReaderTest.m
//  AGXGcode
//
//  Created by Char Aznable on 2016/8/1.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AGXCore/AGXCore.h>
#import "AGXEAN13Reader.h"
#import "AGXGcodeError.h"

@interface AGXEAN13ReaderTest : XCTestCase
@property (nonatomic, AGX_STRONG) AGXResources *resources;
@property (nonatomic, AGX_STRONG) AGXEAN13Reader *reader;
@end

@implementation AGXEAN13ReaderTest

- (void)setUp {
    [super setUp];
    _resources = AGX_RETAIN(AGXResources.application.subpathAppendBundleNamed(@"Resources"));
    _reader = [[AGXEAN13Reader alloc] init];
}

- (void)tearDown {
    AGX_RELEASE(_resources);
    AGX_RELEASE(_reader);
    [super tearDown];
}

- (void)testean131 {
    _resources.subpathAppend(@"blackbox/ean13-1");
    AGXGcodeResult *result = nil;
    NSError *error = nil;
    int all = 0, passed = 0;

    result = [_reader decode:_resources.imageWithFileNamed(@"1.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8413000065504", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"2.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8480010092271", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"3.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8480000823274", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"4.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5449000039231", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"5.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8410054010412", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"6.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8480010045062", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"7.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9788430532674", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"8.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8480017507990", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"9.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"3166298099809", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"10.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8480010001136", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"12.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5201815331227", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"13.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"8413600298517", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"14.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"3560070169443", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"15.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"4045787034318", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"18.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"3086126100326", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"19.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"4820024790635", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"20.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"4000539017100", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"21.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"7622200008018", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"22.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5603667020517", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"23.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"7622400791949", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"24.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5709262942503", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"25.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780140013993", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"26.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"4901780188352", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"28.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9771699057002", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"29.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"4007817327098", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"30.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5025121072311", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"31.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780393058673", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"32.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780393058673", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"33.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781558604971", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"34.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781558604971", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"35.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5030159003930", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"36.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5000213101025", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"37.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"5000213002834", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"38.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201752847", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    NSLog(@"%@:%@, all:%d, passed:%d", NSStringFromClass(self.class), NSStringFromSelector(_cmd), all, passed);
}

- (void)testean132 {
    _resources.subpathAppend(@"blackbox/ean13-2");
    AGXGcodeResult *result = nil;
    NSError *error = nil;
    int all = 0, passed = 0;

    result = [_reader decode:_resources.imageWithFileNamed(@"01.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780804816632", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"02.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780804816632", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"03.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780804816632", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"04.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780804816632", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"05.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780804816632", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"06.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780804816632", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"07.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780804816632", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"08.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345348036", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"09.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345348036", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"10.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345348036", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"11.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345348036", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"12.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345348036", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"13.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"14.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"15.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"16.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"17.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"18.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"19.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"20.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"21.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"22.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"23.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"1920081045006", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"24.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"25.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"26.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"27.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9784872348880", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"28.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"1920081045006", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    NSLog(@"%@:%@, all:%d, passed:%d", NSStringFromClass(self.class), NSStringFromSelector(_cmd), all, passed);
}

- (void)testean133 {
    _resources.subpathAppend(@"blackbox/ean13-3");
    AGXGcodeResult *result = nil;
    NSError *error = nil;
    int all = 0, passed = 0;

    result = [_reader decode:_resources.imageWithFileNamed(@"01.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"02.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"03.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"04.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"05.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"06.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"07.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"08.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"09.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780764544200", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"10.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"11.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"12.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"13.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"14.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"15.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"16.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"17.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"18.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"19.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"20.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"21.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780596008574", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"22.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"23.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"24.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"25.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"26.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"27.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"28.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"29.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"30.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"31.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"32.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"33.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"34.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"35.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780201310054", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"36.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"37.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"38.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"39.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"40.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"41.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"42.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"43.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9781585730575", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"44.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"45.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"46.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"47.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"48.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"49.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"50.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"51.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"52.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"53.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"54.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"55.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780735619937", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    NSLog(@"%@:%@, all:%d, passed:%d", NSStringFromClass(self.class), NSStringFromSelector(_cmd), all, passed);
}

- (void)testean134 {
    _resources.subpathAppend(@"blackbox/ean13-4");
    AGXGcodeResult *result = nil;
    NSError *error = nil;
    int all = 0, passed = 0;

    result = [_reader decode:_resources.imageWithFileNamed(@"01.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"02.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"03.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"04.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"05.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"06.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"07.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"08.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"09.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"10.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"11.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"12.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"13.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"14.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"15.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"16.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"17.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"18.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"19.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"20.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"21.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"22.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780441014989", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    NSLog(@"%@:%@, all:%d, passed:%d", NSStringFromClass(self.class), NSStringFromSelector(_cmd), all, passed);
}

- (void)testean135 {
    _resources.subpathAppend(@"blackbox/ean13-5");
    AGXGcodeResult *result = nil;
    NSError *error = nil;
    int all = 0, passed = 0;

    result = [_reader decode:_resources.imageWithFileNamed(@"01.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780679601050", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"02.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780679601050", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"03.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780679601050", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"04.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780679601050", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"05.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780679601050", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"06.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345460950", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"07.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345460950", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"08.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345460950", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"09.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345460950", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"10.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345460950", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"11.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345460950", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"12.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780345460950", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"13.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780446579803", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"14.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780446579803", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"15.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780446579803", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"16.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780446579803", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"17.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780446579803", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    result = [_reader decode:_resources.imageWithFileNamed(@"18.png") hints:nil error:&error];
    if (!error) { XCTAssertEqualObjects(@"9780446579803", result.text); passed++; }
    else XCTAssertEqual(AGXNotFoundError, error.code);
    all++;
    error = nil;
    NSLog(@"%@:%@, all:%d, passed:%d", NSStringFromClass(self.class), NSStringFromSelector(_cmd), all, passed);
}

@end
