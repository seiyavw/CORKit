//
//  UIStoryboard+COR.h
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (COR)

+ (UIViewController *)initialViewController:(NSString *)storyboardName;
+ (UIViewController *)viewController:(NSString *)viewControllerID storyboardName:(NSString *)storyboardName;

@end