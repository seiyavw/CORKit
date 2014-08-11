//
//  UINavigationController+Transition.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/03/03.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Transition)

- (void)pushNonOverWrappedViewController:(UIViewController *)viewController;
- (void)popNonOverWrappedViewController;
- (void)pushFadeViewController:(UIViewController *)viewController;
- (void)popFadeViewController;

@end
