

//  CustomModelController
//  Copyright (c) 2015年 朝夕. All rights reserved.

#import "TXTransition.h"
#import "TXPresentationController.h"
#import "TXAnimatedTransitioning.h"

@implementation TXTransition
SingletonM(transition)

#pragma mark - UIViewControllerTransitioningDelegate
/** 控制将要model出来的控制器的展示和移除 */
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[TXPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

/** 控制展示动画 */
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    TXAnimatedTransitioning *anim = [[TXAnimatedTransitioning alloc] init];
    anim.presented = YES;
    return anim;
}

/** 控制销毁动画 */
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    TXAnimatedTransitioning *anim = [[TXAnimatedTransitioning alloc] init];
    anim.presented = NO;
    return anim;
}
@end
