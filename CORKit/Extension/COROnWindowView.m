//
//  COROnWindowView.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "COROnWindowView.h"

@implementation COROnWindowView

+ (COROnWindowView *)sharedView {
    
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
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
}

+ (void)show
{
    [[self sharedView] show];
}

+ (void)hide
{
    [[self sharedView] hide];
}

- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    self.alpha = 0.0;
    
    __weak typeof (self) weakSelf = self;
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.alpha = 1;
    } completion:nil];
    
}

- (void)hide
{
    __weak typeof (self) weakSelf = self;
    
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.alpha = 0.f;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end
