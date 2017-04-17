//
//  UIColor+AGXCore.m
//  AGXCore
//
//  Created by Char Aznable on 16/2/17.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import "UIColor+AGXCore.h"
#import "AGXArc.h"
#import "NSString+AGXCore.h"

@category_implementation(UIColor, AGXCore)

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    return [self colorWithIntegerRed:red green:green blue:blue alpha:255];
}

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha {
    return [UIColor colorWithRed:MIN(red, 255)/255. green:MIN(green, 255)/255. blue:MIN(blue, 255)/255. alpha:MIN(alpha, 255)/255.];
}

+ (UIColor *)colorWithRGBHexString:(NSString *)hexString {
    NSString *str = [[hexString trim] uppercaseString];
    if (AGX_EXPECT_F([str length] < 6)) return nil;
    return [self colorWithRGBAHexString:[[str substringWithRange:NSMakeRange(0, 6)] appendWithObjects:@"FF", nil]];
}

+ (UIColor *)colorWithRGBAHexString:(NSString *)hexString {
    NSString *str = [[hexString trim] uppercaseString];
    if (AGX_EXPECT_F([str length] < 6)) return nil;
    if (AGX_EXPECT_F([str length] < 8)) {
        str = [[str substringWithRange:NSMakeRange(0, 6)] appendWithObjects:@"FF", nil];
    }
    unsigned int red, green, blue, alpha;
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(0, 2)]] scanHexInt:&red];
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(2, 2)]] scanHexInt:&green];
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(4, 2)]] scanHexInt:&blue];
    [[NSScanner scannerWithString:[str substringWithRange:NSMakeRange(6, 2)]] scanHexInt:&alpha];
    return [self colorWithIntegerRed:red green:green blue:blue alpha:alpha];
}

- (CGColorRef)rgbaCGColorRef {
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat components[4] = {0, 0, 0, 0};
    [self getRed:&components[0] green:&components[1]
            blue:&components[2] alpha:&components[3]];
    CGColorRef colorRef = CGColorCreate(rgb, components);
    CGColorSpaceRelease(rgb);
    return (AGX_BRIDGE CGColorRef)AGX_AUTORELEASE((AGX_BRIDGE_TRANSFER id)colorRef);
}

- (CGFloat)colorAlpha {
    CGFloat r, g, b, a, w, h, s, l;
    if ([self getWhite:&w alpha:&a]) return a;
    else if ([self getRed:&r green:&g blue:&b alpha:&a]) return a;
    else { [self getHue:&h saturation:&s brightness:&l alpha:&a]; return a; }
}

- (AGXColorShade)colorShade {
    if (self.colorAlpha < 10e-5) return AGXColorShadeUnmeasured;

    const CGFloat *c = CGColorGetComponents(self.rgbaCGColorRef);
    return (c[0]*299+c[1]*587+c[2]*114)/1000 < 0.5 ? AGXColorShadeDark : AGXColorShadeLight;
}

- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[UIColor class]]) return NO;
    return [self isEqualToColor:object];
}

- (BOOL)isEqualToColor:(UIColor *)color {
    if (color == self) return YES;
    return CGColorEqualToColor(self.rgbaCGColorRef, color.rgbaCGColorRef);
}

@end

AGX_OVERLOAD UIColor *AGXColor(CGFloat red, CGFloat green, CGFloat blue) {
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.];
}

AGX_OVERLOAD UIColor *AGXColor(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha) {
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

AGX_OVERLOAD UIColor *AGXColor(NSUInteger red, NSUInteger green, NSUInteger blue) {
    return [UIColor colorWithIntegerRed:red green:green blue:blue];
}

AGX_OVERLOAD UIColor *AGXColor(NSUInteger red, NSUInteger green, NSUInteger blue, NSUInteger alpha) {
    return [UIColor colorWithIntegerRed:red green:green blue:blue alpha:alpha];
}

AGX_OVERLOAD UIColor *AGXColor(NSString *hexString) {
    return [UIColor colorWithRGBAHexString:hexString];
}
