//
//  AGXWebViewJavascriptBridge.h
//  AGXWidget
//
//  Created by Char Aznable on 16/3/4.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

//
//  Copyright (c) 2011-2015 Marcus Westin, Antoine Lagadec
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#ifndef AGXWidget_AGXWebViewJavascriptBridge_h
#define AGXWidget_AGXWebViewJavascriptBridge_h

#import <UIKit/UIKit.h>
#import <AGXCore/AGXCore/AGXArc.h>

typedef void (^AGXBridgeResponseCallback)(id responseData);
typedef void (^AGXBridgeHandler)(id data, AGXBridgeResponseCallback responseCallback);

@protocol AGXWebViewJavascriptBridgeDelegate;

@interface AGXWebViewJavascriptBridge : NSObject
@property (nonatomic, AGX_WEAK) id<AGXWebViewJavascriptBridgeDelegate> delegate;
@property (nonatomic, assign) BOOL autoEmbedJavascript; // default YES

- (void)registerHandler:(NSString *)handlerName handler:(AGXBridgeHandler)handler;
- (void)registerHandler:(NSString *)handlerName handler:(id)handler selector:(SEL)selector;
- (void)callHandler:(NSString *)handlerName;
- (void)callHandler:(NSString *)handlerName data:(id)data;
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(AGXBridgeResponseCallback)responseCallback;

- (void)setupBridge;
- (BOOL)doBridgeWithRequest:(NSURLRequest *)request;
- (void)reset;

+ (void)enableLogging;
+ (void)setLogMaxLength:(int)length;
@end

@protocol AGXWebViewJavascriptBridgeDelegate <NSObject>
- (NSString *)evaluateJavascript:(NSString *)javascript;
@end

#endif /* AGXWidget_AGXWebViewJavascriptBridge_h */