//
//  CORBaseViewController.m
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/02/20.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "CORBaseViewController.h"
#import "UIViewController+COR.h"

@interface CORBaseViewController ()

@end

@implementation CORBaseViewController
{
    UIViewController *_presentedViewController;
    CORBaseViewControllerPresentCompletion _presentCompletion;
    CORBaseViewControllerPresentCompletion _dismiCORCompletion;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentTransparentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(CORBaseViewControllerPresentCompletion)completion
{
    [self containerAddChildViewController:viewController];
    
    if (!animated) {
        
        return;
    }
    
    _presentedViewController = viewController;
    _presentCompletion = completion;
    
    CGFloat hiddenOffset = self.view.bounds.size.height;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.delegate = self;
    animation.fromValue = @(hiddenOffset);
    animation.toValue = @(0.f);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.duration = 0.42f;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints: .07f:1.0f:.69f:1.0f];
    [viewController.view.layer addAnimation:animation forKey:@"presentAnimation"];
}

- (void)dismiCORTransparentViewControllerAnimated:(BOOL)animated completion:(CORBaseViewControllerPresentCompletion)completion
{
    if (!animated) {
        
        [self containerRemoveFromParentViewController];
        return;
    }
    
    _dismiCORCompletion = completion;
    
    CGFloat hiddenOffset = self.view.bounds.size.height;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.delegate = self;
    animation.fromValue = @(0.f);
    animation.toValue = @(hiddenOffset);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    animation.duration = 0.28f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.view.layer addAnimation:animation forKey:@"dismiCORAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if (anim  == [_presentedViewController.view.layer animationForKey:@"presentAnimation"]) {
        
        [_presentedViewController.view.layer removeAnimationForKey:@"presentAnimation"];
        _presentedViewController = nil;
        if (_presentCompletion)
        {
            _presentCompletion();
            _presentCompletion = nil;
        }
        
    } else if (anim  == [self.view.layer animationForKey:@"dismiCORAnimation"]) {
        
        [self.view.layer removeAnimationForKey:@"dismiCORAnimation"];
        
        
        if (self.navigationController) {
            
            [self containerRemoveNavigationFromParentViewController];
            
        } else {
            
            [self containerRemoveFromParentViewController];
        }
        
        if (_dismiCORCompletion) {
            
            _dismiCORCompletion();
            _dismiCORCompletion = nil;
        }
    }
}


@end