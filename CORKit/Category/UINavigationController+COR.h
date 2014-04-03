//
//  UINavigationController+COR.h
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/03/03.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (COR)

- (void)pushTransparentViewController:(UIViewController *)viewController;
- (void)popTransparentViewController;

@end