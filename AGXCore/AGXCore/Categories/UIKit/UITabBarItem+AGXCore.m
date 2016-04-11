//
//  UITabBarItem+AGXCore.m
//  AGXCore
//
//  Created by Char Aznable on 16/2/17.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import "UITabBarItem+AGXCore.h"
#import "AGXAppearance.h"

@category_implementation(UITabBarItem, AGXCore)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    return AGX_AUTORELEASE([[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage]);
}

+ (UIOffset)titlePositionAdjustment {
    return [APPEARANCE titlePositionAdjustment];
}

+ (void)setTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
    [APPEARANCE setTitlePositionAdjustment:titlePositionAdjustment];
}

@end
