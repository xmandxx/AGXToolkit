//
//  AGXJson.h
//  AGXJson
//
//  Created by Char Aznable on 16/2/19.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#ifndef AGXJson_AGXJson_h
#define AGXJson_AGXJson_h

#import <Foundation/Foundation.h>
#import <AGXCore/AGXCore/AGXObjC.h>
#import <AGXCore/AGXCore/AGXCategory.h>

typedef NS_OPTIONS(NSUInteger, AGXJsonOptions) {
    AGXJsonNone             = 0,
    AGXJsonWriteClassName   = 1 << 0
};

AGX_EXTERN NSString *const AGXJSON_CLASS_NAME;
AGX_EXTERN NSString *const AGXJSON_STRUCT_NAME;

// You can set AGX_USE_JSONKIT value TRUE/YES to use JSONKit, AGX_USE_JSONKIT default FALSE/NO.
AGX_EXTERN BOOL AGX_USE_JSONKIT;

@interface AGXJson : NSObject
+ (id)objectFromJsonData:(NSData *)jsonData;
+ (id)objectFromJsonData:(NSData *)jsonData asClass:(Class)clazz;

+ (id)objectFromJsonString:(NSString *)jsonString;
+ (id)objectFromJsonString:(NSString *)jsonString asClass:(Class)clazz;

+ (NSData *)jsonDataFromObject:(id)object;
+ (NSData *)jsonDataFromObject:(id)object withOptions:(AGXJsonOptions)options;

+ (NSString *)jsonStringFromObject:(id)object;
+ (NSString *)jsonStringFromObject:(id)object withOptions:(AGXJsonOptions)options;
@end

@category_interface(NSData, AGXJson)
- (id)agxJsonObject;
- (id)agxJsonObjectAsClass:(Class)clazz;
@end

@category_interface(NSString, AGXJson)
- (id)agxJsonObject;
- (id)agxJsonObjectAsClass:(Class)clazz;
@end

@category_interface(NSObject, AGXJson)
- (NSData *)agxJsonData;
- (NSData *)agxJsonDataWithOptions:(AGXJsonOptions)options;

- (NSString *)agxJsonString;
- (NSString *)agxJsonStringWithOptions:(AGXJsonOptions)options;
@end

@category_interface(NSObject, AGXJsonable)
- (AGX_INSTANCETYPE)initWithValidJsonObject:(id)jsonObject;
- (void)setPropertiesWithValidJsonObject:(id)jsonObject;
- (id)validJsonObject;
- (id)validJsonObjectWithOptions:(AGXJsonOptions)options;
@end

@category_interface(NSValue, AGXJsonable)
+ (void)addJsonableObjCType:(const char *)objCType withName:(NSString *)typeName;
+ (NSValue *)valueWithValidJsonObject:(id)jsonObject;
@end

// struct_jsonable

#define struct_jsonable_interface(structType)                           \
category_interface(NSValue, structType##JsonableDummy)                  \
@end                                                                    \
AGX_CONSTRUCTOR void add_##structType##_jsonable_support()              \
{ [NSValue addJsonableObjCType:@encode(structType)                      \
                      withName:@#structType]; }                         \
@interface NSValue (structType##Jsonable)                               \
- (id)validJsonObjectFor##structType;                                   \
+ (NSValue *)valueWithValidJsonObjectFor##structType:(id)jsonObject;    \
@end

#define struct_jsonable_implementation(structType)                      \
category_implementation(NSValue, structType##JsonableDummy)             \
@end                                                                    \
@implementation NSValue (structType##Jsonable)

// collection json

@category_interface(NSArray, AGXJsonable)
+ (NSArray *)arrayWithValidJsonObject:(id)jsonObject;
@end

@category_interface(NSMutableArray, AGXJsonable)
+ (NSMutableArray *)arrayWithValidJsonObject:(id)jsonObject;
@end

@category_interface(NSDictionary, AGXJsonable)
+ (NSDictionary *)dictionaryWithValidJsonObject:(id)jsonObject;
@end

@category_interface(NSMutableDictionary, AGXJsonable)
+ (NSMutableDictionary *)dictionaryWithValidJsonObject:(id)jsonObject;
@end

#endif /* AGXJson_AGXJson_h */