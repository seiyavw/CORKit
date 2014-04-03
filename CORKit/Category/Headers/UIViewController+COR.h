//
//  UIViewController+COR.h
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (COR)

- (void)containerAddChildViewController:(UIViewController *)childViewController parentView:(UIView *)view;
- (void)containerAddChildViewController:(UIViewController *)childViewController;
- (void)containerRemoveChildViewController:(UIViewController *)childViewController;
- (void)containerRemoveCurrentViewController:(UIViewController *)childViewController;
- (void)containerRemoveFromParentViewController;
- (void)containerRemoveNavigationFromParentViewController;
- (BOOL)isCurrentChildViewController:(UIViewController *)viewController;

@end
