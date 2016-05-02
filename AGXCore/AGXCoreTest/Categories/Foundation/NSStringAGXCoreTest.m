//
//  NSStringAGXCoreTest.m
//  AGXCore
//
//  Created by Char Aznable on 16/2/5.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGXCore.h"

@interface NSStringAGXCoreTest : XCTestCase

@end

@implementation NSStringAGXCoreTest

- (void)testNSStringAGXCoreSafe {
    NSString *string = nil;
    const char *cString = [string UTF8String];
    XCTAssert(cString == NULL);
    XCTAssertNil(@(cString));
}

- (void)testNSStringAGXCore {
    XCTAssertEqual(@"15".unsignedIntegerValue, 15);
    AGX_CLANG_Diagnostic
    (-Wimplicitly-unsigned-literal,
     XCTAssertEqual(@"9223372036854775808".unsignedIntegerValue, 9223372036854775808);
     )

    NSDictionary *dict = @{@"last name":@"Doe", @"first name":@"John"};
    NSString *parametric = @"He's name is ${first name}·${last name}.";
    XCTAssertEqualObjects([parametric parametricStringWithObject:dict], @"He's name is John·Doe.");

    NSArray *array = @[@1, @"is", @"name"];
    XCTAssertTrue([@"He's name is John·Doe. 1" containsAllOfStringInArray:array]);

    NSString *oriString = @"Lorem<==>ipsum=dolar>=<sit<>amet.";
    XCTAssertEqualObjects([oriString stringByReplacingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=><"] withString:@" " mergeContinuous:NO], @"Lorem    ipsum dolar   sit  amet.");
    XCTAssertEqualObjects([oriString stringByReplacingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=><"] withString:@" " mergeContinuous:YES], @"Lorem ipsum dolar sit amet.");
    XCTAssertEqualObjects([oriString stringByReplacingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"=><"] withString:@"" mergeContinuous:NO], @"Loremipsumdolarsitamet.");

    NSString *urlParam = @"key1=value2&key2==value1&key3value3&&key4=&=value4";
    NSDictionary *urlParamDict = [urlParam dictionarySeparatedByString:@"&"
                                             keyValueSeparatedByString:@"=" filterEmpty:YES];
    XCTAssertEqual(urlParamDict.count, 2);
    XCTAssertEqualObjects(urlParamDict[@"key1"], @"value2");
    XCTAssertEqualObjects(urlParamDict[@"key2"], @"=value1");
    XCTAssertNil(urlParamDict[@"key3"]);
    XCTAssertNil(urlParamDict[@"key4"]);

    NSComparator positive = ^NSComparisonResult(id key1, id key2) { return [key1 compare:key2 options:NSNumericSearch]; };
    NSComparator negative = ^NSComparisonResult(id key1, id key2) { return -[key1 compare:key2 options:NSNumericSearch]; };
    XCTAssertEqualObjects(@"key1=value2&key2==value1", [NSString stringWithDictionary:urlParamDict usingKeysComparator:positive separator:@"&" keyValueSeparator:@"=" filterEmpty:YES]);
    XCTAssertEqualObjects(@"key2==value1&key1=value2", [NSString stringWithDictionary:urlParamDict usingKeysComparator:negative separator:@"&" keyValueSeparator:@"=" filterEmpty:YES]);
}

@end
