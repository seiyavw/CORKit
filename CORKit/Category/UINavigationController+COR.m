//
//  UINavigationController+COR.m
//  CORKit 
//
//  Created by Seiya Sasaki on 2014/02/24.
//  Copyright (c) 2014年 Seiya Sasaki All rights reserved.
//

#import "UINavigationController+COR.h"

@implementation UINavigationController (COR)

- (void)pushTransparentViewController:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self pushViewController:viewController animated:NO];
}

- (void)popTransparentViewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self popViewControllerAnimated:NO];
}


@end
