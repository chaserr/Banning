

//  CustomModelController
//  Copyright (c) 2015年 朝夕. All rights reserved.

#import "TXAnimatedTransitioning.h"
#import "UIView+Extension.h"

const CGFloat duration = 0.5;

@implementation TXAnimatedTransitioning


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return duration;
}

#pragma mark-- 在这里可以可以自定义自己喜欢的动画
/** 控制展示和销毁的动画 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.presented) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//        toView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
//        toView.y = -toView.height;
        toView.x = toView.width;
        [UIView animateWithDuration:duration animations:^{
//            toView.y = 0;
            toView.x = 0;
//            toView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//            fromView.y = -fromView.height;
            fromView.x = -fromView.width;
//            fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
