//
//  CORRefreshControl.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/08/25.
//  Copyright (c) 2014年 jp.corleonis All rights reserved.
//

#import "CORRefreshControl.h"

@implementation CORRefreshControl {

    UIEdgeInsets _originalInset;
    CGFloat      _refreshOffsetY;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _refreshOffsetY = 50.f;// default
    }
    return self;
}

#pragma mark - UIView

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (void)didMoveToSuperview
{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        [self.superview addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
    }

}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    if (object == self.superview &&
        [keyPath isEqualToString:@"contentOffset"]) {
        
        [self checkUpdates];
    
    } else {
    
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark - update

- (void)checkUpdates
{
    //observerになる時点でチェックしているのでここではsuperviewのチェック不要
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    
    if (!scrollView.isDragging && //手を離したときのみ
        !_isRefreshing &&
        scrollView.contentOffset.y <= -_refreshOffsetY) {
        
        [self willStartRefreshing];
        _isRefreshing = YES;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        _originalInset = scrollView.contentInset;
        [UIView animateWithDuration:0.3f animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(_refreshOffsetY, 0, 0, 0);
        }];
    }
}

#pragma mark - public

- (void)endRefreshing
{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
    
        [self willEndRefreshing];
        
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        [UIView animateWithDuration:0.3f animations:^{
            scrollView.contentInset = _originalInset;
        } completion:^(BOOL finished) {
            _isRefreshing = NO;
        }];
    }
}

- (void)willStartRefreshing
{
    // you may start animation
}

- (void)willEndRefreshing
{
    // you may stop animation
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
