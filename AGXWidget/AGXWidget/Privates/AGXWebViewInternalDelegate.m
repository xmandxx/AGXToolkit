//
//  AGXWebViewInternalDelegate.m
//  AGXWidget
//
//  Created by Char Aznable on 16/4/15.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import "AGXWebViewInternalDelegate.h"
#import <AGXCore/AGXCore/AGXObjC.h>

@implementation AGXWebViewInternalDelegate

- (AGX_INSTANCETYPE)init {
    if (self = [super init]) {
        _bridge = [[AGXWebViewJavascriptBridge alloc] init];
        _bridge.delegate = self;
        
        _progress = [[AGXWebViewProgressSensor alloc] init];
        _progress.delegate = self;
        
        _extension = [[AGXWebViewExtension alloc] init];
        _extension.delegate = self;
    }
    return self;
}

- (void)setWebView:(AGXWebView *)webView {
    _webView = webView;
    _webView.delegate = self;
}

- (void)dealloc {
    AGX_RELEASE(_bridge);
    AGX_RELEASE(_progress);
    AGX_RELEASE(_extension);
    _webView.delegate = nil;
    _webView = nil;
    _delegate = nil;
    AGX_SUPER_DEALLOC;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector]
    || [_delegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _delegate;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView != _webView) return YES;
    
    if ([_bridge doBridgeWithRequest:request]) return NO;
    else if ([_progress senseCompletedWithRequest:request]) return NO;
    
    BOOL ret = YES;
    if ([_delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
        ret = [_delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    
    if (ret && [_progress shouldResetProgressWithRequest:request fromURL:webView.request.URL])
        [_progress resetProgressWithRequest:request];
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (webView != _webView) return;
    
    [_progress startProgress];
    if ([_delegate respondsToSelector:@selector(webViewDidStartLoad:)])
        [_delegate webViewDidStartLoad:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView != _webView) return;
    
    [_extension coordinate];
    [_bridge setupBridge];
    [_progress senseProgressFromURL:webView.request.mainDocumentURL withError:nil];
    if ([_delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
        [_delegate webViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (webView != _webView) return;
    
    [_progress senseProgressFromURL:webView.request.mainDocumentURL withError:error];
    if ([_delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
        [_delegate webView:webView didFailLoadWithError:error];
}

#pragma mark - AGXEvaluateJavascriptDelegate

- (NSString *)evaluateJavascript:(NSString *)javascript {
    return [_webView stringByEvaluatingJavaScriptFromString:javascript];
}

#pragma mark - AGXWebViewProgressSensorDelegate

- (void)webViewProgressSensor:(AGXWebViewProgressSensor *)sensor updateProgress:(float)progress {
    [_webView performSelector:@selector(setProgress:) withObject:@(progress)];
}

#pragma mark - AGXWebViewExtensionDelegate

- (void)coordinateWithBackgroundColor:(UIColor *)backgroundColor {
    _webView.backgroundColor = backgroundColor;
}

@end
