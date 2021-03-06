//
//  AGXAdapt.h
//  AGXCore
//
//  Created by Char Aznable on 2016/2/4.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#ifndef AGXCore_AGXAdapt_h
#define AGXCore_AGXAdapt_h

#import "NSString+AGXCore.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
# error AGXToolkit is supported only on iOS 8 and above
#endif

#define AGX_CHECK_CURRENT_MODE_SIZE(width, height) \
([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake((width), (height)), UIScreen.mainScreen.currentMode.size) : NO)

#define AGX_IS_IPHONE4                  AGX_CHECK_CURRENT_MODE_SIZE(640, 960)
#define AGX_IS_IPHONE5                  AGX_CHECK_CURRENT_MODE_SIZE(640, 1136)
#define AGX_IS_IPHONE6                  AGX_CHECK_CURRENT_MODE_SIZE(750, 1334)
#define AGX_IS_IPHONE6_BIGMODE          AGX_CHECK_CURRENT_MODE_SIZE(640, 1136)
#define AGX_IS_IPHONE6P                 AGX_CHECK_CURRENT_MODE_SIZE(1242, 2208)
#define AGX_IS_IPHONE6P_BIGMODE         AGX_CHECK_CURRENT_MODE_SIZE(1125, 2001)
#define AGX_IS_IPHONEX                  AGX_CHECK_CURRENT_MODE_SIZE(1125, 2436)

#define AGX_DeviceScale                 (AGX_IS_IPHONE6P?1.29375:(AGX_IS_IPHONEX||AGX_IS_IPHONE6||AGX_IS_IPHONE6P_BIGMODE?1.171875:1.0))
#define AGX_ScreenSize                  (UIScreen.mainScreen.bounds.size)
#define AGX_ScreenWidth                 (AGX_ScreenSize.width)
#define AGX_ScreenHeight                (AGX_ScreenSize.height)
#define AGX_SinglePixel                 (1/UIScreen.mainScreen.scale)

#define AGX_SYSTEM_VERSION_COMPARE(ver) [UIDevice.currentDevice.systemVersion compareToVersionString:@ver]

#define AGX_BEFORE_IOS8_1               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("8.1"))
#define AGX_BEFORE_IOS8_2               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("8.2"))
#define AGX_BEFORE_IOS8_3               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("8.3"))
#define AGX_BEFORE_IOS8_4               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("8.4"))
#define AGX_BEFORE_IOS9_0               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("9.0"))
#define AGX_BEFORE_IOS9_1               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("9.1"))
#define AGX_BEFORE_IOS9_2               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("9.2"))
#define AGX_BEFORE_IOS9_3               (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("9.3"))
#define AGX_BEFORE_IOS10_0              (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("10.0"))
#define AGX_BEFORE_IOS10_1              (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("10.1"))
#define AGX_BEFORE_IOS10_2              (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("10.2"))
#define AGX_BEFORE_IOS10_3              (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("10.3"))
#define AGX_BEFORE_IOS11_0              (NSOrderedAscending == AGX_SYSTEM_VERSION_COMPARE("11.0"))

#define AGX_IOS8_1_OR_LATER             (!AGX_BEFORE_IOS8_1)
#define AGX_IOS8_2_OR_LATER             (!AGX_BEFORE_IOS8_2)
#define AGX_IOS8_3_OR_LATER             (!AGX_BEFORE_IOS8_3)
#define AGX_IOS8_4_OR_LATER             (!AGX_BEFORE_IOS8_4)
#define AGX_IOS9_0_OR_LATER             (!AGX_BEFORE_IOS9_0)
#define AGX_IOS9_1_OR_LATER             (!AGX_BEFORE_IOS9_1)
#define AGX_IOS9_2_OR_LATER             (!AGX_BEFORE_IOS9_2)
#define AGX_IOS9_3_OR_LATER             (!AGX_BEFORE_IOS9_3)
#define AGX_IOS10_0_OR_LATER            (!AGX_BEFORE_IOS10_0)
#define AGX_IOS10_1_OR_LATER            (!AGX_BEFORE_IOS10_1)
#define AGX_IOS10_2_OR_LATER            (!AGX_BEFORE_IOS10_2)
#define AGX_IOS10_3_OR_LATER            (!AGX_BEFORE_IOS10_3)
#define AGX_IOS11_0_OR_LATER            (!AGX_BEFORE_IOS11_0)

#define AGXCalendarUnitEra              NSCalendarUnitEra
#define AGXCalendarUnitYear             NSCalendarUnitYear
#define AGXCalendarUnitMonth            NSCalendarUnitMonth
#define AGXCalendarUnitDay              NSCalendarUnitDay
#define AGXCalendarUnitHour             NSCalendarUnitHour
#define AGXCalendarUnitMinute           NSCalendarUnitMinute
#define AGXCalendarUnitSecond           NSCalendarUnitSecond
#define AGXCalendarUnitWeekday          NSCalendarUnitWeekday
#define AGXCalendarUnitWeekdayOrdinal   NSCalendarUnitWeekdayOrdinal

#endif /* AGXCore_AGXAdapt_h */
