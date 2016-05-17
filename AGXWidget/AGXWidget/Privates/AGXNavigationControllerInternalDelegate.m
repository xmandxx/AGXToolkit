//
//  AGXNavigationControllerInternalDelegate.m
//  AGXWidget
//
//  Created by Char Aznable on 16/4/15.
//  Copyright © 2016年 AI-CUC-EC. All rights reserved.
//

#import "AGXNavigationControllerInternalDelegate.h"
#import "AGXAnimationInternal.h"
#import <AGXCore/AGXCore/UIView+AGXCore.h>
#import <AGXCore/AGXCore/UIWindow+AGXCore.h>

#pragma mark - AGXNavigationTransition

@interface AGXNavigationTransition : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign)   UINavigationControllerOperation agxOperation;
@property (nonatomic, assign)   AGXTransition                   agxTransition;
@property (nonatomic, copy)     AGXTransitionCallback           agxStartTransition;
@property (nonatomic, copy)     AGXTransitionCallback           agxFinishTransition;
@end

@implementation AGXNavigationTransition

- (void)dealloc {
    AGX_BLOCK_RELEASE(_agxStartTransition);
    AGX_BLOCK_RELEASE(_agxFinishTransition);
    AGX_SUPER_DEALLOC;
}

- (void)setAgxStartTransition:(AGXTransitionCallback)agxStartTransition {
    AGXTransitionCallback temp = AGX_BLOCK_COPY(agxStartTransition);
    AGX_BLOCK_RELEASE(_agxStartTransition);
    _agxStartTransition = temp;
}

- (void)setAgxFinishTransition:(AGXTransitionCallback)agxFinishTransition {
    AGXTransitionCallback temp = AGX_BLOCK_COPY(agxFinishTransition);
    AGX_BLOCK_RELEASE(_agxFinishTransition);
    _agxFinishTransition = temp;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _agxTransition.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;

    if (_agxOperation == UINavigationControllerOperationPop) [container addSubview:toView];
    [container addSubview:fromView];
    if (_agxOperation == UINavigationControllerOperationPush) [container addSubview:toView];
    container.subviews.lastObject.shadowOpacity = 1.0;
    container.subviews.lastObject.shadowOffset = CGSizeMake(0, 0);

    fromView.frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = [transitionContext finalFrameForViewController:toVC];

    if (_agxStartTransition) _agxStartTransition(fromVC, toVC);

    AGXTransitionInternal internal = buildInternalTransition(fromView, toView, _agxTransition);

    UIView *fromMaskView = nil;
    UIView *toMaskView = nil;
    if (internal.hasFromMask) {
        fromMaskView = AGX_AUTORELEASE([[UIView alloc] initWithFrame:fromVC.view.bounds]);
        fromMaskView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        fromView.layer.mask = fromMaskView.layer;
    }
    if (internal.hasToMask) {
        toMaskView = AGX_AUTORELEASE([[UIView alloc] initWithFrame:toVC.view.bounds]);
        toMaskView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        toView.layer.mask = toMaskView.layer;
    }

    fromView.transform = internal.fromViewTransform.from;
    fromView.alpha = internal.fromViewAlpha.from;
    fromMaskView.transform = internal.fromMaskTransform.from;
    toView.transform = internal.toViewTransform.from;
    toView.alpha = internal.toViewAlpha.from;
    toMaskView.transform = internal.toMaskTransform.from;
    [UIView animateWithDuration:internal.duration delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromView.transform = internal.fromViewTransform.to;
                         fromView.alpha = internal.fromViewAlpha.to;
                         fromMaskView.transform = internal.fromMaskTransform.to;
                         toView.transform = internal.toViewTransform.to;
                         toView.alpha = internal.toViewAlpha.to;
                         toMaskView.transform = internal.toMaskTransform.to; }

                     completion:^(BOOL finished) {
                         fromView.transform = internal.fromViewTransform.final;
                         fromView.alpha = internal.fromViewAlpha.final;
                         fromMaskView.transform = internal.fromMaskTransform.final;
                         toView.transform = internal.toViewTransform.final;
                         toView.alpha = internal.toViewAlpha.final;
                         toMaskView.transform = internal.toMaskTransform.final;

                         if ([transitionContext transitionWasCancelled]) {
                             [transitionContext completeTransition:NO];
                         } else {
                             if (_agxFinishTransition) _agxFinishTransition(fromVC, toVC);
                             [transitionContext completeTransition:YES];
                         } }];
}

@end

#pragma mark - AGXNavigationControllerInternalDelegate

@implementation AGXNavigationControllerInternalDelegate {
    UIScreenEdgePanGestureRecognizer        *_edgePanGestureRecognizer;
    UIPercentDrivenInteractiveTransition    *_percentDrivenTransition;
    AGXNavigationTransition                 *_navigationTransition;
}

- (AGX_INSTANCETYPE)init {
    if (AGX_EXPECT_T(self = [super init])) {
        _edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(edgePanGesture:)];
        _edgePanGestureRecognizer.edges = UIRectEdgeLeft;
        _agxInteractivePopPercent = 0.5;
        _navigationTransition = [[AGXNavigationTransition alloc] init];
    }
    return self;
}

- (void)dealloc {
    AGX_RELEASE(_edgePanGestureRecognizer);
    AGX_RELEASE(_percentDrivenTransition);
    AGX_RELEASE(_navigationTransition);
    _delegate = nil;
    _navigationController = nil;
    AGX_SUPER_DEALLOC;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector]
    || [self.delegate respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.delegate;
}

- (UIRectEdge)agxPopGestureEdges {
    return _edgePanGestureRecognizer.edges;
}

- (void)setAgxPopGestureEdges:(UIRectEdge)agxPopGestureEdges {
    _edgePanGestureRecognizer.edges = agxPopGestureEdges;
}

- (void)setAgxInteractivePopPercent:(CGFloat)agxInteractivePopPercent {
    _agxInteractivePopPercent = MAX(0.1, MIN(0.9, agxInteractivePopPercent));
}

- (AGXTransition)agxTransition {
    return _navigationTransition.agxTransition;
}

- (void)setAgxTransition:(AGXTransition)agxTransition {
    _navigationTransition.agxTransition = agxTransition;
}

- (AGXTransitionCallback)agxStartTransition {
    return _navigationTransition.agxStartTransition;
}

- (void)setAgxStartTransition:(AGXTransitionCallback)agxStartTransition {
    _navigationTransition.agxStartTransition = agxStartTransition;
}

- (AGXTransitionCallback)agxFinishTransition {
    return _navigationTransition.agxFinishTransition;
}

- (void)setAgxFinishTransition:(AGXTransitionCallback)agxFinishTransition {
    _navigationTransition.agxFinishTransition = agxFinishTransition;
}

#pragma mark - UIScreenEdgePanGestureRecognizer action

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePanGestureRecognizer {
    CGFloat progress = progressOfUIScreenEdgePanGesture(edgePanGestureRecognizer);

    if (edgePanGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [_navigationController popViewControllerAnimated:YES];
    } else if (edgePanGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [_percentDrivenTransition updateInteractiveTransition:progress];
    } else if (edgePanGestureRecognizer.state == UIGestureRecognizerStateEnded ||
               edgePanGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > _agxInteractivePopPercent) {
            [_percentDrivenTransition finishInteractiveTransition];
        } else {
            [_percentDrivenTransition cancelInteractiveTransition];
        }
        AGX_RELEASE(_percentDrivenTransition);
        _percentDrivenTransition = nil;
    }
}

AGX_STATIC_INLINE CGFloat progressOfUIScreenEdgePanGesture(UIScreenEdgePanGestureRecognizer *gesture) {
    CGPoint gesPoint = [gesture locationInView:[UIWindow sharedKeyWindow]];
    CGSize recogSize = [UIWindow sharedKeyWindow].bounds.size;
    switch (gesture.edges) {
        case UIRectEdgeTop:     return gesPoint.y / recogSize.height;
        case UIRectEdgeBottom:  return (recogSize.height - gesPoint.y) / recogSize.height;
        case UIRectEdgeLeft:    return gesPoint.x / recogSize.width;
        case UIRectEdgeRight:   return (recogSize.width - gesPoint.x) / recogSize.width;
        default:                return 0;
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
    navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
    if (viewController != navigationController.viewControllers.firstObject && !viewController.disablePopGesture &&
        ![viewController.view.gestureRecognizers containsObject:_edgePanGestureRecognizer]) {
        [viewController.view addGestureRecognizer:_edgePanGestureRecognizer];
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([self.delegate respondsToSelector:@selector(navigationController:interactionControllerForAnimationController:)]) {
        return [self.delegate navigationController:navigationController interactionControllerForAnimationController:animationController];
    }
    return _percentDrivenTransition;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([self.delegate respondsToSelector:@selector(navigationController:animationControllerForOperation:fromViewController:toViewController:)]) {
        return [self.delegate navigationController:navigationController animationControllerForOperation:operation fromViewController:fromVC toViewController:toVC];
    }
    _navigationTransition.agxOperation = operation;
    return _navigationTransition;
}

@end
