//
//  UIStoryboard+Access.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "UIStoryboard+Access.h"

@implementation UIStoryboard (Access)

+ (UIViewController *)initialViewControllerWithStoryboardName:(NSString *)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController *initialViewController = [storyboard instantiateInitialViewController];
    return initialViewController;
}

+ (UIViewController *)viewController:(NSString *)viewControllerID storyboardName:(NSString *)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerID];
    return viewController;
}

@end
