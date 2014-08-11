//
//  UIViewController+Container.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "UIViewController+Container.h"

@implementation UIViewController (Container)

- (void)containerAddChildViewController:(UIViewController *)childViewController parentView:(UIView *)view
{
    //親のViewにサイズを合わせる
    childViewController.view.frame = view.bounds;
    [self addChildViewController:childViewController];
    [view addSubview:childViewController.view];
    [childViewController didMoveToParentViewController:self];
}

- (void)containerAddChildViewController:(UIViewController *)childViewController
{
    [self containerAddChildViewController:childViewController parentView:self.view];
}

- (void)containerRemoveFromParentViewController
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)containerRemoveNavigationFromParentViewController
{
    [self.navigationController willMoveToParentViewController:nil];
    [self.navigationController.view removeFromSuperview];
    [self.navigationController removeFromParentViewController];
}

- (void)containerRemoveChildViewController:(UIViewController *)childViewController
{
    [childViewController containerRemoveFromParentViewController];
}

- (void)containerRemoveCurrentViewController:(UIViewController *)childViewController
{
    if ([self.childViewControllers count] == 0)
        return;
    UIViewController *currentViewController = self.childViewControllers[0];
    [self containerRemoveCurrentViewController:currentViewController];
}

- (BOOL)isCurrentChildViewController:(UIViewController *)viewController
{
    if ([self.childViewControllers count] > 0) {
        
        UIViewController *currentViewController = self.childViewControllers[0];
        if (currentViewController == viewController)
        {
            return YES;
        }
        return NO;
        
    } else {
        
        return NO;
    }
}



@end
