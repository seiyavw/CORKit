//
//  CORWindowView.m
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "CORWindowView.h"
// import AppDelegate header

@implementation CORWindowView

+ (CORWindowView *)sharedView {
    static dispatch_once_t once;
    static CORWindowView *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup
{
    // override
    // setup subviews or something in SubClaCOR
}

+ (void)show
{
    [[self sharedView] showSharedView];
}

+ (void)hide
{
    [[self sharedView] hideSharedView];
}

- (void)showSharedView
{
    // acceCOR app delegate and add view
    
//    AppDelegate *aDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [aDelegate.window addSubview:self];
    
    self.alpha = 0.0;
    
    __weak typeof (self) weakSelf = self;
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)hideSharedView
{
    __weak typeof (self) weakSelf = self;
    
    [UIView animateWithDuration:0.3f delay:0.5f options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.alpha = 0.f;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end