

//  CustomModelController
//  Copyright (c) 2015年 朝夕. All rights reserved.

#import "TXPresentationController.h"

@implementation TXPresentationController
/** 控制model出来的控制器的大小 */
//- (CGRect)frameOfPresentedViewInContainerView
//{
////    return CGRectMake(0, 50, self.containerView.frame.size.width, self.containerView.frame.size.height - 100);
//    return CGRectInset(self.containerView.bounds, 0, 100);
//}

/** 开始model出一个控制器 */
- (void)presentationTransitionWillBegin
{
//    NSLog(@"presentationTransitionWillBegin");
    
    self.presentedView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.presentedView];
    
}

/** model结束 */
- (void)presentationTransitionDidEnd:(BOOL)completed
{
//    NSLog(@"presentationTransitionDidEnd");
}

/** 开始销毁model出来的控制器 */
- (void)dismissalTransitionWillBegin
{
//    NSLog(@"dismissalTransitionWillBegin");
}

/** 销毁结束 */
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
//    NSLog(@"dismissalTransitionDidEnd");
    [self.presentedView removeFromSuperview];
}
@end
