//
//  UIActionSheet+AGXCore.m
//  AGXCore
//
//  Created by Char Aznable on 2016/3/23.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import "UIActionSheet+AGXCore.h"
#import "AGXArc.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_3

@category_implementation(UIActionSheet, AGXCore)

+ (AGX_INSTANCETYPE)actionSheetWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title delegate:delegate cancelButtonTitle:nil
                                      destructiveButtonTitle:nil otherButtonTitles:nil];
    if (destructiveButtonTitle) {
        [actionSheet addButtonWithTitle:destructiveButtonTitle];
        [actionSheet setDestructiveButtonIndex:actionSheet.numberOfButtons - 1];
    }
    if (otherButtonTitles) {
        [actionSheet setValue:@(actionSheet.numberOfButtons) forKey:@"firstOtherButtonIndex"];
        NSArray *buttonTitles = agx_va_list(otherButtonTitles);
        [buttonTitles enumerateObjectsUsingBlock:
         ^(NSString *title, NSUInteger idx, BOOL *stop) {
            [actionSheet addButtonWithTitle:title]; }];
    }
    if (cancelButtonTitle) {
        [actionSheet addButtonWithTitle:cancelButtonTitle];
        [actionSheet setCancelButtonIndex:actionSheet.numberOfButtons - 1];
    }
    return AGX_AUTORELEASE(actionSheet);
}

@end

#endif // __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_3
