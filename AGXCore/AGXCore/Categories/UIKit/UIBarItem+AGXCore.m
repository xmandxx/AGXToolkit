//
//  UIBarItem+AGXCore.m
//  AGXCore
//
//  Created by Char Aznable on 16/2/17.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import "UIBarItem+AGXCore.h"
#import "AGXGeometry.h"
#import "AGXAppearance.h"

@category_implementation(UIBarItem, AGXCore)

#pragma mark - textFont -

- (UIFont *)textFontForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(self, state, NSFontAttributeName);
}

- (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(self, state, NSFontAttributeName, textFont);
}

+ (UIFont *)textFontForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(APPEARANCE, state, NSFontAttributeName);
}

+ (void)setTextFont:(UIFont *)textFont forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(APPEARANCE, state, NSFontAttributeName, textFont);
}

#pragma mark - textColor -

- (UIColor *)textColorForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(self, state, NSForegroundColorAttributeName);
}

- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(self, state, NSForegroundColorAttributeName, textColor);
}

+ (UIColor *)textColorForState:(UIControlState)state {
    return titleTextAttributeForStateAndKey(APPEARANCE, state, NSForegroundColorAttributeName);
}

+ (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state {
    setTitleTextAttributeForStateAndKey(APPEARANCE, state, NSForegroundColorAttributeName, textColor);
}

#pragma mark - textShadowColor -

- (UIColor *)textShadowColorForState:(UIControlState)state {
    return titleShadowAttributeForState(self, state).shadowColor;
}

- (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state {
    NSShadow *shadow = defaultTitleShadowAttributeForState(self, state);
    [shadow setShadowColor:textShadowColor];
    setTitleShadowAttributeForState(self, state, shadow);
}

+ (UIColor *)textShadowColorForState:(UIControlState)state {
    return titleShadowAttributeForState(APPEARANCE, state).shadowColor;
}

+ (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state {
    NSShadow *shadow = defaultTitleShadowAttributeForState(APPEARANCE, state);
    [shadow setShadowColor:textShadowColor];
    setTitleShadowAttributeForState(APPEARANCE, state, shadow);
}

#pragma mark - textShadowOffset -

- (CGSize)textShadowOffsetForState:(UIControlState)state {
    return titleShadowAttributeForState(self, state).shadowOffset;
}

- (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state {
    NSShadow *shadow = defaultTitleShadowAttributeForState(self, state);
    [shadow setShadowOffset:textShadowOffset];
    setTitleShadowAttributeForState(self, state, shadow);
}

+ (CGSize)textShadowOffsetForState:(UIControlState)state {
    return titleShadowAttributeForState(APPEARANCE, state).shadowOffset;
}

+ (void)setTextShadowOffset:(CGSize)textShadowOffset forState:(UIControlState)state {
    NSShadow *shadow = defaultTitleShadowAttributeForState(APPEARANCE, state);
    [shadow setShadowOffset:textShadowOffset];
    setTitleShadowAttributeForState(APPEARANCE, state, shadow);
}

#pragma mark - textShadowSize -

- (CGFloat)textShadowSizeForState:(UIControlState)state {
    return titleShadowAttributeForState(self, state).shadowBlurRadius;
}

- (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state {
    NSShadow *shadow = defaultTitleShadowAttributeForState(self, state);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttributeForState(self, state, shadow);
}

+ (CGFloat)textShadowSizeForState:(UIControlState)state {
    return titleShadowAttributeForState(APPEARANCE, state).shadowBlurRadius;
}

+ (void)setTextShadowSize:(CGFloat)textShadowSize forState:(UIControlState)state {
    NSShadow *shadow = defaultTitleShadowAttributeForState(APPEARANCE, state);
    [shadow setShadowBlurRadius:textShadowSize];
    setTitleShadowAttributeForState(APPEARANCE, state, shadow);
}

@end
