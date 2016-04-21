//
//  AGXWebView.h
//  AGXWidget
//
//  Created by Char Aznable on 16/3/4.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#ifndef AGXWidget_AGXWebView_h
#define AGXWidget_AGXWebView_h

#import <UIKit/UIKit.h>
#import <AGXCore/AGXCore/AGXObjC.h>
#import <AGXCore/AGXCore/AGXArc.h>

typedef void (^AGXBridgeTrigger)(id SELF, id sender);

AGX_EXTERN NSString *AGXBridgeLoadedEventName;      // agxbloaded
AGX_EXTERN NSString *AGXBridgeInjectJSObjectName;   // AGXB

@interface AGXWebView : UIWebView
@property (nonatomic, assign)       BOOL        autoEmbedJavascript; // default YES
@property (nonatomic, assign)       BOOL        coordinateBackgroundColor; // default YES

@property (nonatomic, AGX_STRONG)   UIColor    *progressColor UI_APPEARANCE_SELECTOR; // default (22, 126, 251, 255)
+ (UIColor *)progressColor;
+ (void)setProgressColor:(UIColor *)progressColor;

@property (nonatomic, assign)       CGFloat     progressWidth UI_APPEARANCE_SELECTOR; // default 2
+ (CGFloat)progressWidth;
+ (void)setProgressWidth:(CGFloat)progressWidth;

- (void)registerHandlerName:(NSString *)handlerName handler:(id)handler selector:(SEL)selector;
- (SEL)registerTriggerAt:(Class)triggerClass withBlock:(AGXBridgeTrigger)triggerBlock;
- (SEL)registerTriggerAt:(Class)triggerClass withJavascript:(NSString *)javascript;

#pragma mark - UIWebView bridge handler
/* declaration&implementation in super class
- (void)reload;
- (void)stopLoading;
- (void)goBack;
- (void)goForward;
- (BOOL)canGoBack;
- (BOOL)canGoForward;
- (BOOL)isLoading; */
- (void)scaleFit;
- (void)setBounces:(BOOL)bounces;
- (void)setBounceHorizontal:(BOOL)bounceHorizontal;
- (void)setBounceVertical:(BOOL)bounceVertical;
- (void)setShowHorizontalScrollBar:(BOOL)showHorizontalScrollBar;
- (void)setShowVerticalScrollBar:(BOOL)showVerticalScrollBar;
@end

#endif /* AGXWidget_AGXWebView_h */
