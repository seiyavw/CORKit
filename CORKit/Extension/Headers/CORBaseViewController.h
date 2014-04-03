//
//  CORBaseViewController.h
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/02/20.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CORBaseViewControllerPresentCompletion)();

@interface CORBaseViewController : UIViewController

- (void)presentTransparentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(CORBaseViewControllerPresentCompletion)completion;
- (void)dismiCORTransparentViewControllerAnimated:(BOOL)animated completion:(CORBaseViewControllerPresentCompletion)completion;

@end
