//
//  UINavigationController+Transition.m
//  CORKit 
//
//  Created by Seiya Sasaki on 2014/02/24.
//  Copyright (c) 2014年 Seiya Sasaki All rights reserved.
//

#import "UINavigationController+Transition.h"

@implementation UINavigationController (Transition)

/**
 * use custom animation for preventing VCs from be overlappded by each other
 */
- (void)pushNonOverWrappedViewController:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self pushViewController:viewController animated:NO];
}

- (void)popNonOverWrappedViewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popViewControllerAnimated:NO];
}

- (void)pushFadeViewController:(UIViewController *)viewController
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self pushViewController:viewController animated:NO];
}

- (void)popFadeViewController
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.view.layer addAnimation:transition forKey:nil];
    [self popViewControllerAnimated:NO];
}



@end
