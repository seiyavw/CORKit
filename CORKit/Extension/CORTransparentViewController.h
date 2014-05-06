//
//  CORTransparentViewController.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/02/20.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CORTransparentPresentCompletion)();

@interface CORTransparentViewController : UIViewController

- (void)presentTransparentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(CORTransparentPresentCompletion)completion;
- (void)dismissTransparentViewControllerAnimated:(BOOL)animated completion:(CORTransparentPresentCompletion)completion;

@end
